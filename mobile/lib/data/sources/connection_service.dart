import 'dart:async';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// ------------------------ Provider --------------------------
final connectionServiveProvider = Provider((ref){
  final connectionService = ConnectionServiceImpl();
  ref.onDispose( connectionService.disconnect );
  return connectionService;
});


// -------------------------Interface ------------------------------
abstract interface class ConnectionService{
  Stream<Event> get eventStream;

  Stream<ConnectionStatus> get connectionStatusStream;
  ConnectionStatus get connectionStatus;

  Stream<Duration?> get pingStream;
  Duration? get ping;


  Future<void> connect(String serverAddress, int serverPort);
  
  void send(Event event);

  void disconnect();

  /// @brief Generates and sends an [IdentifiableEvent]
  /// sets the callbacks for expecting an [IdentifiableEvent] in response
  /// 
  /// @params eventCallback gives you access to an internal Id to build your event
  /// ([IdentiafiableEvent] provide a get id property)
  /// 
  /// if the [CheckEvent] does not arrive before [checkTime] is over 
  /// [onCheckTimeOver] will be called and futures CheckEvents will 
  /// be ignored
  void sendAndCheckResult(
    IdentiafiableEvent Function(int id) eventCallback, {
    /// [event] is the response event
    /// [time] is the DateTime when your event was sent 
    required Function(IdentiafiableEvent event, DateTime time) onEventRecived, 
    /// [time] is the DateTime when your event was sent 
    required Function(DateTime eventOutTime) onCheckTimeOver, 
    Duration checkTime = const Duration(seconds: 5)
  });
}



// ---------------------- Implementation -------------------------
class ConnectionServiceImpl extends ConnectionService{
  WebSocketChannel ? _channel;
  Heartbeat ? _heartbeat; // compisition instead inherent
  CheckPool ? _checkPool; // compisition instead inherent
  
  StreamSubscription ? _serverEventSubscription;

  final BehaviorSubject<Event> _serverSubject = BehaviorSubject();
  final BehaviorSubject<Duration?>   _pingSubject = .seeded(null);
  final BehaviorSubject<ConnectionStatus> _connectionSubject 
    = .seeded(.disconnected);


  // --------------------- conectionStatus ----------------------
  @override
  ConnectionStatus get connectionStatus 
    => _connectionSubject.value;
  
  @override
  Stream<ConnectionStatus> get connectionStatusStream 
    => _connectionSubject.stream;

  // --------------------- serverEventStream ----------------------
  @override
  Stream<Event> get eventStream 
    => _serverSubject.stream;

  // ----------------------- ping ----------------------------------
  @override
  Stream<Duration?> get pingStream => _pingSubject.stream;

  @override
  Duration? get ping => _pingSubject.value;

  // ----------------------- methods --------------------------------
  @override
  Future<void> connect(String serverAddress, int serverPort) async {
    try{
      disconnect();
      _connectionSubject.add(.connecting);
      
      _channel = IOWebSocketChannel.connect(
        'ws://$serverAddress:$serverPort/v1/mobile_client',
        connectTimeout: Duration(seconds: 5),
        headers: {
          'x-api-key': dotenv.get('SERVER_API_KEY'),
        },
      );

      await Future.wait([
        _channel!.ready,
        Future.delayed(Duration(seconds: 1))
      ]);

      _startSubscribeToServerEvent();
      _initHeartbeat();
      _initCheckPool();
    }catch(e){
      debugPrint("Error connection on ConnectionService: $e");
      rethrow;
    }
  }

  @override
  void send(Event event) {
    _channel?.sink.add(event.encode());
  }

  @override
  void sendAndCheckResult( IdentiafiableEvent Function(int id) eventCallback, {
      required Function(IdentiafiableEvent event, DateTime time) onEventRecived, 
      required Function(DateTime eventOutTime) onCheckTimeOver, 
      Duration checkTime = const Duration(seconds: 5)
  }) {
    _checkPool?.sendAndCheckResult(
      eventCallback, 
      onEventRecived: onEventRecived, 
      onCheckTimeOver: onCheckTimeOver
    );
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
    _heartbeat?.stop();
    _heartbeat = null;
    
    // detengo la espera por checks checkPool
    _checkPool?.stop();
    _checkPool = null;

    // cierro el channel completamente
    _channel?.sink.close();
    _channel = null;
  }


  /// ---------------------------- Helpers --------------------------------
  void _startSubscribeToServerEvent(){
    _serverEventSubscription?.cancel();
    _serverEventSubscription = _channel?.stream.listen(
      (data){
        try{
          final event = Event.decode(data);
          _serverSubject.add(event);
        }catch(e){
          debugPrint("Problems with event reception: $e");
        }
        
      }
    );
  }

  void _initHeartbeat(){
    if(_heartbeat != null) throw Exception('initHearbit with a session open');
    if(_channel == null) throw Exception('initHearbit without _channel');

    _heartbeat = Heartbeat(
      eventStream,
      _channel!.sink, 
      onPingChanged: _pingSubject.add, 
      onConnectionStatusChanged: _connectionSubject.add,
      onHeartbeatStop: disconnect, 
    )..start();
  }

  void _initCheckPool(){
    if(_checkPool != null) throw Exception('initCheckPool with a session open');
    if(_channel == null ) throw Exception('initCheckPool without _channel');
    
    _checkPool = CheckPool(
      _serverSubject.stream, 
      _channel!.sink
    )..start();
  }
}