import 'dart:async';
import 'dart:io';

import 'package:core/core.dart';
import 'package:desktop/data/source/connection_interface_service.dart';
import 'package:desktop/data/source/connection_service.dart';
import 'package:core/src/models/network/server_address.dart';
import 'package:core/src/models/network/server_interface.dart';
import 'package:desktop/domain/repository/connection_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as p;

final connectionRepositoryProvider = Provider<ConnectionRepository>((ref){
  final repo = ConnectionRepositoryImpl(
    connectionService: ref.watch(connectionServiceProvider),
    connectionInterfaceService: ref.watch(connectionInterfaceServiceProvider)
  );

  return repo;
});


class ConnectionRepositoryImpl implements ConnectionRepository{
  final ConnectionService connectionService;
  final ConnectionInterfaceService connectionInterfaceService;

  /// [_serverPortSubscription] + [_serverInterfaceSubscription]
  /// gives the result of [_serverAddressSubject]
  StreamSubscription<List<ServerInterface>> ? _serverInterfacesSubscription;
  StreamSubscription<int?> ? _serverPortSubcription;

  final BehaviorSubject<List<ServerAddress>> _serverAddressSubject
    = .seeded([]);

  ConnectionRepositoryImpl({
    required this.connectionService,
    required this.connectionInterfaceService
  }){
    _initServerInterfaceSubscription();
    _initServerPortSubscritpion();
    connect();
  }

  // ---------------------- Server Address ---------------------
  @override
  List<ServerAddress> get serverAddress 
    => _serverAddressSubject.value;

  @override
  Stream<List<ServerAddress>> get serverAddressStream 
    => _serverAddressSubject.stream;

  // -------------------- ConnectionStatus -----------------------
  @override
  Stream<ConnectionStatus> get serverStatusStream 
    => connectionService.connectionStatusStream;

  @override
  ConnectionStatus get serverStatus 
    => connectionService.connectionStatus;

  // --------------------- PlayerState List ----------------------
  @override
  Stream<List<PlayerState>> get playersStateStream 
    => connectionService.playersStateStream;
  
  @override
  List<PlayerState> get playersState 
    => connectionService.playersState;

  // --------------------- methods ---------------------------
  @override
  Future<void> connect() async {
    try{
      final lastPort = await ServerConfigService.serverPort;

      if(lastPort != null){
        final isConnected = await connectionService.connectToServer(lastPort);

        if(!isConnected){
          await _initServer();
          
          for(int i = 0 ; i < 3; i++){
            await Future.delayed(Duration(seconds: 1));
            final lastPort = await ServerConfigService.serverPort;
            
            if(lastPort != null){
              if(await connectionService.connectToServer(lastPort)) break;
            }          
          }
        }
      }

    }catch(e){
      debugPrint("Error ConnectionRepository.connect $e");
      rethrow;
    }
  }

  @override
  void disconnect() async {
    try{
      connectionService.disconnectFromServer();
      
    }catch(e){
      debugPrint("Error ConnectionRepository.disconnect $e");
      rethrow;
    }
  }

  @override
  void stopServer() {
    try{
      connectionService.stopServer();
      
    }catch(e){
      debugPrint("Error ConnectionRepository.stopServer $e");
      rethrow;
    }
  }

  // -------------------------- helpers ---------------------------
  Future<void> _initServer() async {
    final appDir = File(Platform.resolvedExecutable).parent.path;

    if (Platform.isWindows) {
      final serverPath = p.join(appDir, 'bin/server.exe');
      await Process.start(
        serverPath,
        [],
        mode: ProcessStartMode.detached,
      );
    } else if (Platform.isLinux) {
      await Process.start(
        'gamepad_server',
        [],
        mode: ProcessStartMode.detached,
      );
    } else {
      throw Exception('Unsupported platform');
    }
  }
 
  void _initServerInterfaceSubscription(){
    _serverInterfacesSubscription?.cancel();
    _serverInterfacesSubscription = connectionInterfaceService
      .interfacesStream.listen(
        (interfaces){
          _updateServerAddress(connectionService.serverPort, interfaces);
        }
    );
  }

  void _initServerPortSubscritpion(){
    _serverPortSubcription?.cancel();
    _serverPortSubcription = connectionService.serverPortStream.listen(
      (port){
        _updateServerAddress(port, connectionInterfaceService.interfaces);
      }
    );
  }

  void _updateServerAddress(int ? port, List<ServerInterface> interfaces){
    if(port == null || interfaces.isEmpty){
      _serverAddressSubject.add([]);
      return;
    }

    _serverAddressSubject.add([
      for(final interface in connectionInterfaceService.interfaces)
      ServerAddress(port: port, interface: interface)
    ]);
  }




}