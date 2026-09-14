import 'dart:typed_data';

import 'package:core/src/models/event/_event.dart';
import 'package:core/src/models/event/_event_code.dart';

class PingEvent implements Event{
  @override
  final EventCode eventCode = EventCode.ping;
  final int id;

  const PingEvent(this.id);

  @override
  Uint8List encode() => Uint8List.fromList([eventCode.code, id]);

  factory PingEvent.decode(List<int> source) {
    return PingEvent(source[1]);
  }
}

// caso especial de checkEvent
class PongEvent implements Event{
  @override
  final EventCode eventCode = EventCode.pong;
  final int id;

  const PongEvent(this.id);

  @override
  Uint8List encode() => Uint8List.fromList([eventCode.code, id]);

  factory PongEvent.decode(List<int> source) {
    return PongEvent(source[1]);
  }
}