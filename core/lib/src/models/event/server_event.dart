import 'dart:typed_data';

import 'package:core/src/models/event/_event.dart';
import 'package:core/src/models/event/_event_code.dart';

/// eventos generados por el server
sealed class ServerEvent implements Event{
  const ServerEvent();

  @override
  EventCode get eventCode => EventCode.serverEvent;


  static bool isServerEvent(dynamic source){
    if(source is Uint8List){
      return source[0] == EventCode.serverEvent.code;
    }
    return false;
  }


  factory ServerEvent.decode(dynamic source){
    if (!isServerEvent(source)) {
      throw FormatException('Format input error on serverEvent.decode');
    }

    final data = source as Uint8List;
    final subEventCode = data[1];

    return switch (subEventCode) {
      1 => PlayerInfoRequestServerEvent(),
      2 => VibrateServerEvent.decode(data.sublist(2)),

      _ => throw FormatException('Unknown ServerEvent code: $subEventCode'),
    };
  } 
}

/// Pedir datos al usuario
class PlayerInfoRequestServerEvent extends ServerEvent{
  @override
  Uint8List encode() => Uint8List.fromList([
    eventCode.code, // eventCode
    1 // subEventCode
  ]);
}


class VibrateServerEvent extends ServerEvent{
  final int code ; // id de vibracion (native u16)
  final int value; // 0 stop , n repeticions (native s32)

  const VibrateServerEvent({
    required this.code,
    required this.value
  });

  @override
  Uint8List encode() {
    final result = Uint8List(8);
    final bd = ByteData.sublistView(result);
    
    bd.setInt8(0, eventCode.code); // EventCode
    bd.setInt8(1, 2);              //subEventCode 
    bd.setUint16(2, code);         // id
    bd.setInt32(3, value);         // repeticions

    return result;
  }

  factory VibrateServerEvent.decode(Uint8List data){
    final bd = ByteData.sublistView(data);

    return VibrateServerEvent(
      code: bd.getUint16(0), 
      value: bd.getInt32(1)
    );
  }
}