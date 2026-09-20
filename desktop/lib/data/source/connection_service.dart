import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/subjects.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// ---------------------- provider --------------------------
final connectionServiceProvider = Provider<ConnectionService>((ref){
  final service = ConnectionServiceImpl();
  ref.onDispose(service.disconnectFromServer);
  return service;
});


//----------------------- interface --------------------------
abstract class ConnectionService {  
  Stream<ConnectionStatus> get connectionStatusStream;
  ConnectionStatus get connectionStatus;

  Stream<List<PlayerState>> get playersStateStream;
  List<PlayerState> get playersState;

  Stream<int?> get serverPortStream;
  int? get serverPort;

  Future<bool> connectToServer(int port);

  void disconnectFromServer();

  void stopServer();
}


// ----------------------- implementation ------------------
class ConnectionServiceImpl extends ConnectionService{
  WebSocketChannel ? _webSocketChannel;
  ChannelEventListener ? _channelEventListener;
  Heartbeat ? _heartbeat;


  final BehaviorSubject<ConnectionStatus> _connectionStatusSubject
    = .seeded(.disconnected);
  
  final BehaviorSubject<List<PlayerState>> _playersSubject
    = .seeded([]);

  final BehaviorSubject<int?> _portSubject
    = .seeded(null);
  

  // -------------------------- ConnectionStatus --------------------
  @override
  Stream<ConnectionStatus> get connectionStatusStream 
    => _connectionStatusSubject.stream;

  @override
  ConnectionStatus get connectionStatus 
    => _connectionStatusSubject.value;
  
  //----------------------------------- playerState -----------------------
  @override
  Stream<List<PlayerState>> get playersStateStream 
    => _playersSubject.stream;

  @override
  List<PlayerState> get playersState => _playersSubject.value;

  // ---------------------------------Port--------------------------------
  @override
  Stream<int?> get serverPortStream => _portSubject.stream;

  @override
  int? get serverPort => _portSubject.value;

  // ---------------------------------- Methods -------------------------
  @override
  Future<bool> connectToServer(int port) async {
    try{
      _webSocketChannel?.sink.close();
      _webSocketChannel = IOWebSocketChannel.connect(
        'ws://127.0.0.1:$port/v1/desktop_client',
        connectTimeout: Duration(seconds: 5),
        headers: {
          'x-api-key': 'ABXCD-1DJKO-39AKD-0I2KD',
        },
      );
      
      await _webSocketChannel!.ready;
      
      _portSubject.add(port);
      _connectionStatusSubject.add(.connected);

      _initChannelEventListener();
      _initHeartBeat();
      return true;
    }catch(e){
      debugPrint("Error _connectToServerAddress: $e");
      return false;
    }
  }

  @override
  void stopServer() {
    _portSubject.add(null);
    _playersSubject.add([]);
    _connectionStatusSubject.add(.connecting);
    _webSocketChannel?.sink.add(StopServerDesktopEvent().encode());
  }

  @override
  void disconnectFromServer(){
    /// add status to subjects
    _connectionStatusSubject.add(.disconnected);
    _portSubject.add(null);
    
    /// close extensions
    _heartbeat?.stop();
    _heartbeat = null;
    _channelEventListener?.stop();
    _channelEventListener = null;
    
    /// close webSocketChannel
    _webSocketChannel?.sink.close();
    _webSocketChannel = null;
  }


  // ------------------------------ helpers ---------------------------------

  void _initChannelEventListener(){
    if(_webSocketChannel == null){
      throw Exception('_initChannelEventListner wwith null WebSocketChannel');
    }

    _channelEventListener?.stop();
    _channelEventListener = ChannelEventListener(
      _webSocketChannel!, 
      handleEvent: (event){
        switch(event){
          case PlayerListUpdated():
            _playersSubject.add(event.playerList);
            return;
          
        }

      },
      handleNoEvent: (data) {
        print("Was error");
      },
    )..start();
  }

  void _initHeartBeat(){
    if(_webSocketChannel == null || _channelEventListener == null){
      throw Exception("_initHeartbeat with null WebSocketChannel"
        "or null _channelEventListener");
    }

    _heartbeat?.stop();
    _heartbeat = Heartbeat(
      _channelEventListener!.eventStream,
      _webSocketChannel!.sink, 
      onPingChanged: (newPing){
        
      }, 
      onConnectionStatusChanged: _connectionStatusSubject.add,
      onHeartbeatStop: disconnectFromServer, 
    )..start();
  }
}