import 'dart:convert';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core/src/models/event/_event_code.dart';

/// eventos generados en el virtual device
sealed class VirtualDeviceEvent implements Event{
  const VirtualDeviceEvent();

  @override
  EventCode get eventCode => .virtualDevice; 

  factory VirtualDeviceEvent.decode(dynamic source){
    final data = source as Uint8List;
    final (code, subCode) = Event.getInt4FromInt8(data[0]); 

    return switch(subCode){
      1 => VibrationVDEvent.decode(data),
      2 => FailInitVDEvent.decode(data),
      
      _ => throw FormatException('Unknown VirtualDeviceEvent code: $subCode'),
    };
  }
}


class VibrationVDEvent extends VirtualDeviceEvent{
  final int id;
  final int value; 
  
  const VibrationVDEvent({
    required this.id,
    required this.value
  });

  @override
  Uint8List encode() {
    return Uint8List.fromList([
      Event.getInt8FromInt4(eventCode.code, 1),
      id,  
      value
    ]); 
  }

  factory VibrationVDEvent.decode(Uint8List data){
    return VibrationVDEvent(
      id: data[1], 
      value: data[2]
    );
  }
}


class FailInitVDEvent extends VirtualDeviceEvent{
  final String error;
  
  const FailInitVDEvent({
    required this.error
  });

  @override
  Uint8List encode() {
    final encodedError = utf8.encode(error);
    final result = Uint8List(1 + encodedError.length);

    result[0] = Event.getInt8FromInt4(eventCode.code, 1);
    result.setRange(1, result.length, encodedError);

    return result;
  }

  factory FailInitVDEvent.decode(Uint8List data){
    return FailInitVDEvent(
      error: utf8.decode(data.sublist(1))
    );
  }
}


