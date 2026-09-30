import 'dart:async';
import 'package:core/core.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';



/// utilidad para escuchar los mensajes de un webSocketChannel
/// convertirlos en eventos
/// y exponer un eventSubject (necesario para heartbeat, y check_poool)
class ChannelEventListener {
  /// Subcription
  StreamSubscription<dynamic> ? _webSocketChannelSubscritpion;
  /// Subject
  final BehaviorSubject<Event> _eventSubject = BehaviorSubject();

  ChannelEventListener(this._webSocketChannel, {
    required this.handleEvent,
    this.handleNoEvent
  });

  final WebSocketChannel _webSocketChannel;
  void Function(Event event) handleEvent;

  /// Entrada al webSocketChannel q no pasa por Event.decode
  void Function(dynamic data, Object err) ? handleNoEvent;
  
  /// exposicion
  Stream<Event> get eventStream => _eventSubject.stream;
  

  void start(){
    _initWebSocketChannelSubscription();
  }

  void _initWebSocketChannelSubscription(){
    _webSocketChannelSubscritpion?.cancel();
    _webSocketChannelSubscritpion = _webSocketChannel.stream.listen(
      (data){
        try{
          final event = Event.decode(data);
          handleEvent(event);
          _eventSubject.add(event);
        }catch(e){
          handleNoEvent?.call(data, e);
        }
      }
    );
  }

  void stop(){
    _webSocketChannelSubscritpion?.cancel();
    _webSocketChannelSubscritpion = null;
    _eventSubject.drain();
  }
}