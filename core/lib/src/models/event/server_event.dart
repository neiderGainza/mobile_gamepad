import 'dart:typed_data';

import 'package:core/src/models/event/_event.dart';
import 'package:core/src/models/event/_event_code.dart';

/// eventos generados por el server
sealed class ServerEvent implements Event{
  const ServerEvent();

  @override
  EventCode get eventCode => EventCode.serverEvent;


  factory ServerEvent.decode(dynamic source){
    final data = source as Uint8List;
    final (code, subCode) = Event.getInt4FromInt8(data[0]); 

    return switch (subCode) {
      1 => PlayerInfoRequestServerEvent(),

      _ => throw FormatException('Unknown ServerEvent code: $subCode'),
    };
  } 
}

/// Pedir datos al usuario
class PlayerInfoRequestServerEvent extends ServerEvent{
  @override
  Uint8List encode() => Uint8List.fromList([
    Event.getInt8FromInt4(eventCode.code, 1)
  ]);
}

