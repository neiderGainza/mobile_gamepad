import 'dart:typed_data';

import 'package:core/src/models/event/_event.dart';
import 'package:core/src/models/event/_event_code.dart';

class PingEvent implements IdentiafiableEvent{
  @override
  final EventCode eventCode = EventCode.ping;
  final int id;

  const PingEvent(this.id);

  @override
  Uint8List encode() => Uint8List.fromList([eventCode.code, id]);

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

// caso especial de checkEvent
class PongEvent implements IdentiafiableEvent{
  @override
  final EventCode eventCode = EventCode.pong;
  final int id;

  const PongEvent(this.id);

  @override
  Uint8List encode() => Uint8List.fromList([eventCode.code, id]);

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