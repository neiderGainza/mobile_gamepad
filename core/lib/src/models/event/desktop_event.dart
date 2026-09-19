import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core/src/models/event/_event_code.dart';


sealed class DesktopEvent implements Event{
  const DesktopEvent();

  @override
  EventCode get eventCode => .desktopEvent;

  factory DesktopEvent.decode(dynamic source){
    final data = source as Uint8List;
    final (code, subCode) = Event.getInt4FromInt8(data[0]); 

    return switch (subCode) {
      0 => StopServerDesktopEvent(),
      
      _ => throw FormatException('Unknown DesktopEvent code: $subCode'),
    };
  }
}


class StopServerDesktopEvent extends DesktopEvent{
  const StopServerDesktopEvent();

  @override
  Uint8List encode() => Uint8List.fromList([
    Event.getInt8FromInt4(eventCode.code, 0)
  ]);
}



