import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/sources/connection_service.dart';
import 'package:game_controller/data/sources/player_local_storage_service.dart';
import 'package:game_controller/domain/repository/connection_repository.dart';


final connectionRepositoryProvider = Provider<ConnectionRepository>((ref){
  final connectionRepository = ConnectionRepositoryImpl(
    connectionService : ref.read(connectionServiveProvider),
    playerLocalStorage: ref.read(playerLocalStorageProvider).requireValue,
  );

  ref.onDispose(connectionRepository.disconnect);
  return connectionRepository;
});


class ConnectionRepositoryImpl extends ConnectionRepository {
  ConnectionRepositoryImpl({
    required this.connectionService,
    required this.playerLocalStorage,
  });

  final ConnectionService connectionService;
  final PlayerLocalStorageService playerLocalStorage;
  
  StreamSubscription ? _playerSubscription;

  @override
  Stream<PlayerConnectionStatus> get connectionStatusStream 
    => connectionService.connectionStatusStream;

  @override
  PlayerConnectionStatus get connectionStatus 
    => connectionService.connectionStatus;

  @override
  Stream<ServerEvent> get serverEventStream 
    => connectionService.serverEventStream;

  @override
  Stream<Duration?> get pingStream => connectionService.pingStream;

  @override
  Duration? get ping => connectionService.ping;

  

  @override
  void connect(String serverAddress, int port) async {
    try{
      await connectionService.connect(serverAddress, port);
      _subscribeToPlayerStream(); 

      connectionService.send(UpdateInfoPlayerEvent(
        player: await playerLocalStorage.player
      ));

    }catch(e){
      debugPrint("Error connection on ConnectionRepo: $e");
      disconnect();
      rethrow;
    }
  }

  @override
  void disconnect() async {
    _playerSubscription?.cancel();
    connectionService.disconnect();
  }

  @override
  void send(ButtonPlayerEvent pbe) => connectionService.send(pbe);
  

  /// Helpers
  void _subscribeToPlayerStream(){
    _playerSubscription?.cancel();
    _playerSubscription = playerLocalStorage.playerStream.listen(
      (player) => connectionService.send(UpdateInfoPlayerEvent(player: player))
    );
  }


  Future<T> awaitForServerEvent<T>({
    required T? Function(ServerEvent event) completeWith,
    Duration timeout = const Duration(seconds: 8),
  }) async {
    final completer = Completer<T>();
    late final StreamSubscription<ServerEvent> subscription;

    subscription = serverEventStream.listen(
      (event) {
        try {
          final completeVal = completeWith(event);
          if (completeVal != null && !completer.isCompleted) {
            completer.complete(completeVal);
          }
        } catch (e, st) {
          if (!completer.isCompleted) {
            completer.completeError(e, st);
          }
        }
      },
      onError: (Object error, StackTrace st) {
        if (!completer.isCompleted) {
          completer.completeError(error, st);
        }
      },
    );

    try {
      return await completer.future.timeout(
        timeout,
        onTimeout: () => throw TimeoutException('AwaitingServerEvent timed out after $timeout'),
      );
    } finally {
      
      await subscription.cancel();
    }
  }
}