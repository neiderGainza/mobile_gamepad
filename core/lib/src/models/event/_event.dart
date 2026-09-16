import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core/src/models/event/_event_code.dart';


abstract interface class Event {
  EventCode get eventCode;

  /// Rules for encode:
  /// First  int4 = eventCode
  /// Second int4 = subEventCode
  /// Third  int8 = id in case of IdentifiableEvent
  /// Then information
  Uint8List encode();

  static Event decode(dynamic source){
    try{
      if(source is Uint8List){
        final (code, _) = getInt4FromInt8(source[0]); 

        switch(code){
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
  
  static (int , int) getInt4FromInt8(int source){
    int first = 0, second = 0;
    
    for(int bit = 0; bit < 4; bit ++){
      first  = first  |  ( source & ( 1 << bit       ));
      second = second |  ( source & ( 1 << (bit + 4) ));
    }

    return (first, second >> 4);
  }

  static int getInt8FromInt4(int first, int second){
    return first | (second << 4);
  }
}



/// this interface is used for [CheckPool] to send 
/// events and wait for and awnser containing the same id
/// 
/// Aunq muchos eventos puede q cumplan con la implementacion
/// (ejem : PingEvent PongEvent) solo le doy la interfaz a los 
/// eventos a los q quiero poder responder (de la respuesta
/// de ping pong ya se encarga [Hearbeat] similar a [CheckPool]).
abstract interface class IdentiafiableEvent implements Event{
  int get id;
}