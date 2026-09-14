import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/sources/connection_service.dart';
import 'package:game_controller/data/sources/player_local_storage_service.dart';
import 'package:game_controller/data/sources/vibration_service.dart';
import 'package:game_controller/domain/enums/player_info_sync_state.dart';
import 'package:game_controller/domain/repository/connection_repository.dart';
import 'package:rxdart/rxdart.dart';


final connectionRepositoryProvider = Provider<ConnectionRepository>((ref){
  final connectionRepository = ConnectionRepositoryImpl(
    connectionService : ref.read(connectionServiveProvider),
    playerLocalStorage: ref.read(playerLocalStorageProvider).requireValue,
    vibrationService  : ref.read(vibrationServiceProvider)
  );

  ref.onDispose(connectionRepository.disconnect);
  return connectionRepository;
});



class ConnectionRepositoryImpl extends ConnectionRepository {
  ConnectionRepositoryImpl({
    required this.connectionService,
    required this.playerLocalStorage,
    required this.vibrationService
  });

  final ConnectionService connectionService;
  final PlayerLocalStorageService playerLocalStorage;
  final VibrationService vibrationService;

  StreamSubscription ? _localPlayerSubscription;
  StreamSubscription ? _serverEventSubscription;

  final BehaviorSubject<PlayerInfoSyncState> _playerInfoSyncStateSubject
   = .seeded(.none); 

  // --------------------- conectionStatus ---------------------
  @override
  Stream<PlayerConnectionStatus> get connectionStatusStream 
    => connectionService.connectionStatusStream;

  @override
  PlayerConnectionStatus get connectionStatus 
    => connectionService.connectionStatus;

  /// -------------------- ping ---------------------------------
  @override
  Stream<Duration?> get pingStream => connectionService.pingStream;

  @override
  Duration? get ping => connectionService.ping;

  ///---------------------- playerInfoSyncState ------------------
  /// en el futuro esto va a cambiar de playerInfo a cualquier info
  /// simple syncState, y se va a referir al estado de sincronizacion
  /// de la informacion
  @override
  Stream<PlayerInfoSyncState> get playerInfoSyncStateStream 
    => _playerInfoSyncStateSubject.stream;

  @override
  PlayerInfoSyncState get playerInfoSyncState
    => _playerInfoSyncStateSubject.value;


  /// -----------------------methods-------------------------------
  @override
  void connect(String serverAddress, int port) async {
    try{
      await connectionService.connect(serverAddress, port);
      
      _subscribeToLocalPlayerStream(); 
      _subscribeToServerEvent();

      connectionService.send(UpdateInfoPlayerEvent(
        player: await playerLocalStorage.player,
        id    : 0
      ));

    }catch(e){
      debugPrint("Error connection on ConnectionRepo: $e");
      disconnect();
      rethrow;
    }
  }

  @override
  void disconnect() async {
    _localPlayerSubscription?.cancel();
    _serverEventSubscription?.cancel();
    
    connectionService.disconnect();
  }

  @override
  void send(ButtonPlayerEvent pbe) => connectionService.send(pbe);
  
  @override
  void syncPlayerData() async {
    final player = await playerLocalStorage.player;

    connectionService.send(UpdateInfoPlayerEvent(player: player, id: 200));

    // connectionService.sendAndCheckResult(
    //   (id) => UpdateInfoPlayerEvent(player: player, id: id),
    //   onCheckTimeOver: () => _playerInfoSyncStateSubject.add(.failed), 
      
    //   onEventRecived: (identifiableEvent){
    //     if(identifiableEvent is SuccessCheckEvent){
    //       _playerInfoSyncStateSubject.add(.success);
    //     }else if(identifiableEvent is ErrorCheckEvent){
    //       _playerInfoSyncStateSubject.add(.failed);
    //     }
    //   },
    // );
  }


  /// ------------------------- Helpers --------------------------
  void _subscribeToLocalPlayerStream(){
    _localPlayerSubscription?.cancel();
    _localPlayerSubscription = playerLocalStorage.playerStream.listen(
      (player) {
        _playerInfoSyncStateSubject.add(.progres);       
        
        syncPlayerData();
      }
    );
  }

  void _subscribeToServerEvent(){
    _serverEventSubscription?.cancel();
    _serverEventSubscription = connectionService.eventStream.listen(
      (event){
        switch(event){
          case VibrationVDEvent():
            vibrationService.process(event);
        }
      }
    );
  }
}