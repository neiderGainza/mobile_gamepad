import 'dart:typed_data';

import 'package:core/src/models/event/event.dart';
import 'package:core/src/models/event/event_code.dart';

class PingEvent implements Event {
  @override
  final EventCode eventCode = EventCode.ping;
  final int identifier;

  const PingEvent(this.identifier);

  @override
  Uint8List encode() => Uint8List.fromList([eventCode.code, identifier]);

  static bool isPing(dynamic source) {
    return source is List<int> &&
      source.length == 2 &&
      source[0] == EventCode.ping.code;
  }

  factory PingEvent.decode(List<int> source) {
    if(!isPing(source)) {
      throw ArgumentError('Formato inválido para PingEvent');
    }
    return PingEvent(source[1]);
  }
}

class PongEvent implements Event {
  @override
  final EventCode eventCode = EventCode.pong;
  final int identifier;

  const PongEvent(this.identifier);

  @override
  Uint8List encode() => Uint8List.fromList([eventCode.code, identifier]);

  static bool isPong(dynamic source) {
    return source is List<int> &&
        source.length == 2 &&
        source[0] == EventCode.pong.code;
  }

  factory PongEvent.decode(List<int> source) {
    if (!isPong(source)) {
      throw ArgumentError('Formato inválido para PongEvent');
    }
    return PongEvent(source[1]);
  }
}