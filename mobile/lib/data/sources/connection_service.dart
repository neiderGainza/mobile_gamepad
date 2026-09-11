import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/subjects.dart';
import 'package:web_socket_channel/io.dart';

import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

// ------------------------ Provider --------------------------
final connectionServiveProvider = Provider((ref){
  final connectionService = ConnectionServiceImpl();
  ref.onDispose( connectionService.disconnect );
  return connectionService;
});


// -------------------------Interface ------------------------------
abstract class ConnectionService {
  Stream<ServerEvent> get serverEventStream;

  Stream<PlayerConnectionStatus> get connectionStatusStream;
  PlayerConnectionStatus get connectionStatus;

  Stream<Duration?> get pingStream;
  Duration? get ping;


  Future<void> connect(String serverAddress, int serverPort);
  
  void send(PlayerEvent event);

  void disconnect();
}


// ---------------------- Implementation -------------------------
class ConnectionServiceImpl extends ConnectionService{
  WebSocketChannel ? _channel;
  StreamSubscription ? _serverEventSubscription;
  Heartbeat ? _heartbeat;

  /// Broadcast del [_channel.stream]
  Stream<dynamic> ? _channelBroadcastStream;

  final BehaviorSubject<ServerEvent> _serverSubject = BehaviorSubject();
  final BehaviorSubject<Duration?>   _pingSubject = .seeded(null);
  final BehaviorSubject<PlayerConnectionStatus> _connectionSubject 
    = .seeded(.disconnected);

  @override
  PlayerConnectionStatus get connectionStatus 
    => _connectionSubject.value;
  
  @override
  Stream<PlayerConnectionStatus> get connectionStatusStream 
    => _connectionSubject.stream;
  
  @override
  Stream<ServerEvent> get serverEventStream 
    => _serverSubject.stream;

  @override
  Stream<Duration?> get pingStream => _pingSubject.stream;

  @override
  Duration? get ping => _pingSubject.value;


  @override
  Future<void> connect(String serverAddress, int serverPort) async {
    try{
      disconnect();
      _connectionSubject.add(.connecting);
      
      _channel = IOWebSocketChannel.connect(
        'ws://$serverAddress:$serverPort/v1/player_client',
        connectTimeout: Duration(seconds: 5),
        headers: {
          'x-api-key': dotenv.get('SERVER_API_KEY'),
        },
      );

      _channelBroadcastStream = _channel!.stream.asBroadcastStream();
      await _channel!.ready;

      _startSubscribeToServerEvent();
      _initHeartbeat();
    }catch(e){
      debugPrint("Error connection on ConnectionService: $e");
      rethrow;
    }
  }

  
  @override
  void send(PlayerEvent event) {
    _channel?.sink.add(event.encode());
  }

  @override 
  void disconnect() {
    // dejo de recibir
    _serverEventSubscription?.cancel();

    // pongo mis ultimos estados
    _connectionSubject.add(.disconnected);
    _pingSubject.add(null);

    // cierro los subjects
    _serverSubject.drain();
    _connectionSubject.drain();
    _pingSubject.drain();

    // dejo de mandar pings
    _heartbeat?.stopHeartbeat();
    _heartbeat = null;

    // cierro el channel completamente
    _channel?.sink.close(status.normalClosure);
    _channel = null;

    /// acabo con el broadcast del _channel
    _channelBroadcastStream?.drain();
    _channelBroadcastStream = null;
  }

  /// Server Event subscription
  void _startSubscribeToServerEvent(){
    _serverEventSubscription?.cancel();
    _serverEventSubscription = _channelBroadcastStream?.listen(
      (data){
        if(ServerEvent.isServerEvent(data)){
          final serverEvent = ServerEvent.decode(data);
          debugPrint('Server Event: $serverEvent');
          _serverSubject.add(serverEvent);     
        }else{
          // debugPrint('Rare Event: $data');
        }
      }
    );
  }

  void _initHeartbeat(){
    if(_heartbeat != null) throw Exception('initHearbit with a session open');
    if(_channel == null || _channelBroadcastStream == null) {
      throw Exception('initHearbit without _channel');
    }

    _heartbeat = Heartbeat(
      _channelBroadcastStream!,     
      _channel!.sink, 
      onPingChanged: _pingSubject.add, 
      onConnectionStatusChanged: _connectionSubject.add,
      onHeartbeatStop: disconnect, 
    );
  }
}