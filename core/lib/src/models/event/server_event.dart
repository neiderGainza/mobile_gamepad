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
    final subEventCode = data[1];

    return switch (subEventCode) {
      1 => PlayerInfoRequestServerEvent(),

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

