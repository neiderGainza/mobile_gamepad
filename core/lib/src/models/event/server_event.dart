import 'dart:typed_data';

import 'package:core/src/models/event/event.dart';
import 'package:core/src/models/event/event_code.dart';

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
      0 => PlayerInfoSyncServerEvent(),
      1 => PlayerInfoRequestServerEvent(),
      
      _ => throw FormatException('Unknown ServerEvent code: $subEventCode'),
    };
  } 
}

class PlayerInfoSyncServerEvent extends ServerEvent{
  @override
  Uint8List encode() => Uint8List.fromList([0]);
}

class PlayerInfoRequestServerEvent extends ServerEvent{
  @override
  Uint8List encode() => Uint8List.fromList([1]);
}

