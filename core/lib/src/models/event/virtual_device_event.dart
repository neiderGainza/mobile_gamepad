import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core/src/models/event/_event_code.dart';

sealed class VirtualDeviceEvent implements Event{
  const VirtualDeviceEvent();

  @override
  EventCode get eventCode => .virtualDevice; 

  factory VirtualDeviceEvent.decode(dynamic source){
    final data = source as Uint8List;
    final subEventCode = data[1];

    return switch(subEventCode){
      1 => VibrationVDEvent.decode(data.sublist(2)),

      _ => throw FormatException('Unknown VirtualDeviceEvent code: $subEventCode'),
    };
  }
}


class VibrationVDEvent extends VirtualDeviceEvent implements IdentiafiableEvent{
  @override
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