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
    final subEventCode = data[1];

    return switch(subEventCode){
      1 => VibrationVDEvent.decode(data.sublist(2)),
      2 => FailInitVDEvent.decode(data.sublist(2)),
      
      _ => throw FormatException('Unknown VirtualDeviceEvent code: $subEventCode'),
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
      eventCode.code, //eventCode
      1, // subEventCode
      id,  
      value
    ]); 
  }

  factory VibrationVDEvent.decode(Uint8List data){
    return VibrationVDEvent(
      id: data[0], 
      value: data[1]
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
    final result = Uint8List(2 + encodedError.length);

    result[0] = eventCode.code;
    result[1] = 2; // subEventCode
    result.setRange(2, result.length, encodedError);

    return result;
  }

  factory FailInitVDEvent.decode(Uint8List data){
    return FailInitVDEvent(
      error: utf8.decode(data)
    );
  }
}


