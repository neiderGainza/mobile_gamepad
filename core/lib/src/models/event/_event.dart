import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core/src/models/event/_event_code.dart';
import 'package:core/src/models/event/check_event.dart';
import 'package:core/src/models/event/ping_pong_event.dart';
import 'package:core/src/models/event/player_event.dart';
import 'package:core/src/models/event/server_event.dart';


abstract interface class Event {
  EventCode get eventCode;

  /// Rules for encode:
  /// First  int8 = eventCode
  /// Second int8 = subEventCode
  /// Third  int8 = id in case of IdentifiableEvent
  /// Then information
  Uint8List encode();

  static Event decode(dynamic source){
    try{
      if(source is Uint8List){
        
        switch(source[0]){
          case 0: return CheckEvent.decode(source);
          case 1: return PingEvent.decode(source);
          case 2: return PongEvent.decode(source);
          case 3: return ServerEvent.decode(source);
          case 4: return PlayerEvent.decode(source);
          case 5: return VirtualDeviceEvent.decode(source);
          
          default: throw FormatException('No Event with EventCode ${source[0]}');
        }
      }
      else{ throw FormatException('Wrong Event Format: ${source.runtimeType}'); }
    
    }catch(e){
      throw FormatException('Error decoding Event: $e');
    }
  }
  
}

abstract interface class IdentiafiableEvent implements Event{
  int get id;
}