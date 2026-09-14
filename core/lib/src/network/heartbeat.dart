import 'dart:async';
import 'package:core/core.dart';
import 'package:core/src/models/event/ping_pong_event.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class Heartbeat{
  final Duration pingInterval;
  final int maxPingFailed;
  
  final Stream<Event> _channelStream;
  final WebSocketSink _channelSink;

  final Function(Duration ? ping) onPingChanged;
  final Function(PlayerConnectionStatus status) onConnectionStatusChanged;
  final Function() onHeartbeatStop;

  Heartbeat(this._channelStream , this._channelSink, {
    this.pingInterval  = const Duration(seconds: 1),
    this.maxPingFailed = 2,

    required this.onPingChanged,
    required this.onHeartbeatStop,
    required this.onConnectionStatusChanged
  }){
    start();
  }


  // timers
  StreamSubscription ? _eventSubscription;

  Timer ? _pingTimer;  
  int _pingCounter = 0;
  final Map<int, DateTime> _pingPool = {};


  PlayerConnectionStatus ? _connectionStatus;
  set connectionStatus(PlayerConnectionStatus status){
    if(status != _connectionStatus){
      onConnectionStatusChanged(status);
      _connectionStatus = status;
    }
  }

  void start() {
    _subscribeToChannel();
    _startPingTimer();
  }

  void stop({bool callCallback = false}) {
    _eventSubscription?.cancel();
    _pingTimer?.cancel();
    _pingPool.clear();      
    
    onPingChanged(null);
    connectionStatus = .disconnected;
    if(callCallback) onHeartbeatStop();
  }


  /// Helpers
  void _startPingTimer(){
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(
      pingInterval,
      (_){
        if(_pingPool.isNotEmpty){
          connectionStatus = .connecting;
        }

        if(_pingPool.length >= maxPingFailed){
          stop(callCallback: true);
          return;
        }

        _channelSink.add(PingEvent(_pingCounter).encode());
        _pingPool[_pingCounter] = DateTime.now();
        _pingCounter = (_pingCounter + 1) % (255);
      }
    );
  }

  void _subscribeToChannel(){
    _eventSubscription?.cancel();
    _eventSubscription = _channelStream.listen(
      (event){
        switch(event){
          case PingEvent():
            _channelSink.add(PongEvent(event.id).encode());
          case PongEvent():
            _handlePong(event.id);
        }

        connectionStatus = .connected;
      },
      onDone:(){
        stop(callCallback: true);
      }
    );
  }

  void _handlePong(int identifier){
    if(_pingPool.containsKey(identifier)){
      final pingTime = _pingPool[identifier]!;
      
      onPingChanged(DateTime.now().difference(pingTime));
      
      _pingPool.remove(identifier);
      _pingPool.removeWhere((id, time){
        return time.isBefore(pingTime);
      });
    }
  }
}


