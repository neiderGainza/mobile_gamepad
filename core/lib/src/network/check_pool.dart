import 'dart:async';

import 'package:core/core.dart';
import 'package:core/src/models/event/_event.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Mixin vs anidamiento
class CheckPool {
  final Stream<dynamic> _channelStream;
  final WebSocketSink _channelSink;

  StreamSubscription ? _channelStreamSubscription;

  CheckPool(this._channelStream, this._channelSink);

  void start() {
    _initChannelSubscription();
  }

  /// TODO : what do we have to do when a new event is resolved and 
  /// an old one is wainting for event
  void sendAndCheckResult(
    IdentiafiableEvent Function(int id) eventCallback, {
    Function(IdentiafiableEvent event)? onEventRecived, 
    Function()? onCheckTimeOver, 
    Duration checkTime = const Duration(seconds: 5)
  }) {
    final id    = _syncEventIdCount;
    final event = eventCallback(id);
    
    _channelSink.add(event.encode());

    final eventTimer = Timer(checkTime, (){
      if(_eventWaitingForCheckPool.containsKey(id)){
        final onCheckTimeOver = _eventWaitingForCheckPool[id]!.onCheckTimeOver;
        _eventWaitingForCheckPool.remove(id);
        onCheckTimeOver?.call();    
      }
    }); 

    _eventWaitingForCheckPool[id] = (
      onEventRecived  : onEventRecived as Function(IdentiafiableEvent),
      onCheckTimeOver : onCheckTimeOver,
      timer           : eventTimer,
      dateTime        : DateTime.now()
    );
  }


  void stop() {
    _channelStreamSubscription?.cancel();
    _eventWaitingForCheckPool.clear();
  }

  /// Id (int8 up to 256 events awaiting for confirmation)
  int _syncEventIdCountVal = 0;
  int get _syncEventIdCount {
    _syncEventIdCountVal = (_syncEventIdCountVal + 1)%256;
    return _syncEventIdCountVal;
  }

  final Map<int, ({
    Function(IdentiafiableEvent event)? onEventRecived,
    Function()? onCheckTimeOver,
    Timer timer,
    DateTime dateTime, 
  })> _eventWaitingForCheckPool = {};



  void _initChannelSubscription(){
    _channelStreamSubscription?.cancel();
    _channelStreamSubscription = _channelStream.listen(
      (data){
        try{
          final event = Event.decode(data);
          if(event is IdentiafiableEvent && 
             _eventWaitingForCheckPool.containsKey(event.id)
          ){
            _eventWaitingForCheckPool[event.id]?.timer.cancel();
            final eventWaitingForCheck = _eventWaitingForCheckPool[event.id];
            
            if(eventWaitingForCheck != null){
              eventWaitingForCheck.onEventRecived?.call(event);
            }

            _eventWaitingForCheckPool.remove(event.id);
          }
        }catch(_){}
      }
    );
  }
}




/// Exposes the sendAndCheckResult Function
abstract mixin class CheckPoolMixin{
  CheckPool ? get _checkPool;
  
  /// @brief Generates and sends an [IdentifiableEvent]
  /// sets the callbacks for expecting an [IdentifiableEvent] in response
  /// 
  /// @params eventCallback gives you access to an internal Id to build your event
  /// ([IdentiafiableEvent] provide a get id property)
  /// 
  /// depending on the result of the server proccess it will responde
  /// with SuccessCheckEvent or ErrorCheckEvent , the function 
  /// [onSuccessCheckEvent] and [onErrorCheckEvent] will be called
  /// 
  /// if the [CheckEvent] does not arrive before [checkTime] is over 
  /// [onCheckTimeOver] will be called and futures CheckEvents will 
  /// be ignored
  void sendAndCheckResult(
    IdentiafiableEvent Function(int id) eventCallback, {
    Function(IdentiafiableEvent event)? onEventRecived, 
    Function()? onCheckTimeOver, 
    Duration checkTime = const Duration(seconds: 5)
  }){
    _checkPool?.sendAndCheckResult(
      eventCallback,
      onEventRecived: onEventRecived,
      onCheckTimeOver: onCheckTimeOver,
      checkTime: checkTime
    );
  }
} 