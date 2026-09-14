import 'dart:async';

import 'package:core/core.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


abstract interface class CheckPoolInterface {
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


class CheckPool implements CheckPoolInterface {
  final Stream<Event> _eventStream;
  final WebSocketSink _channelSink;

  StreamSubscription ? _eventSubscription;

  CheckPool(this._eventStream, this._channelSink){
    start();
  }

  void start() {
    _initChannelSubscription();
  }


  @override
  void sendAndCheckResult(
    IdentiafiableEvent Function(int id) eventCallback, {
    /// [event] is the response event
    /// [time] is the DateTime when your event was sent 
    required Function(IdentiafiableEvent event, DateTime time) onEventRecived, 
    /// [time] is the DateTime when your event was sent 
    required Function(DateTime eventOutTime) onCheckTimeOver, 
    Duration checkTime = const Duration(seconds: 5)
  }) {
    final id    = _syncEventIdCount;
    final event = eventCallback(id);
    
    // enviar el mensaje
    // for(int i =0; i < 5; i++) print('a');
    // print(event.encode());
    // for(int i =0; i < 5; i++) print('a');

    _channelSink.add(event.encode());

    // poner el removeTimer
    final eventTimer = _setRemoveTimer(checkTime, event);

    // guardar el evento y el tiempo en el que fue enviado
    _eventPool[id] = (
      onEventRecived: onEventRecived,
      onCheckTimeOver: onCheckTimeOver,
      time: DateTime.now(),
      timer: eventTimer
    );
  }


  void stop() {
    _eventSubscription?.cancel();
    _eventPool.clear();
  }


  /// Id (int8 up to 256 events awaiting for confirmation)
  int _syncEventIdCountVal = 0;
  int get _syncEventIdCount {
    _syncEventIdCountVal = (_syncEventIdCountVal + 1)%256;
    return _syncEventIdCountVal;
  }


  final Map<int , ({
    Function(IdentiafiableEvent event, DateTime time) onEventRecived,
    Function(DateTime time) onCheckTimeOver,
    Timer timer,
    DateTime time,
  })> _eventPool = {};


  void _initChannelSubscription(){
    _eventSubscription?.cancel();
    _eventSubscription = _eventStream.listen(
      (event){
        if( event is IdentiafiableEvent){
          final id = event.id;
          if(_eventPool.containsKey(id)){
            final waitEvent = _eventPool[id];
            waitEvent?.timer.cancel();
            _eventPool.remove(id);

            if(waitEvent != null){
              waitEvent.onEventRecived.call(event,waitEvent.time);
            }
          }
        }
      }
    );
  }

  Timer _setRemoveTimer(Duration checkTime, IdentiafiableEvent event){
    return Timer(checkTime, (){
      final id = event.id;

      if(_eventPool.containsKey(id)){
        final waitEvent = _eventPool[id];
        _eventPool.remove(id);

        if(waitEvent != null){
          waitEvent.onCheckTimeOver.call(waitEvent.time);
          waitEvent.timer.cancel();    
        }
      }
    }); 
  }
}



