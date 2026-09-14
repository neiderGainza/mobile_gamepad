import 'dart:convert';
import 'dart:typed_data';
import 'package:core/src/models/event/_event.dart';
import 'package:core/src/models/event/_event_code.dart';




sealed class CheckEvent implements IdentiafiableEvent {
  @override
  final int id;

  const CheckEvent({ required this.id });

  @override
  EventCode get eventCode => .check;

  factory CheckEvent.decode(dynamic source){
    final data = source as Uint8List;
    // if(data[0] != EventCode.check.code) throw FormatException('Wrong eventType');
    
    return switch(data[1]){
      0 => ErrorCheckEvent.decode(data.sublist(2)),
      1 => SuccessCheckEvent.decode(data.sublist(2)),

      _ => throw FormatException('Unknown CheckEvent code: ${data[1]}'),
     
    };
  }
}


class ErrorCheckEvent extends CheckEvent{
  final String ? error;
  
  const ErrorCheckEvent({
    required super.id,
    this.error
  });

  @override
  Uint8List encode() {
    final encodedError = utf8.encode(error ?? '');
    final result = Uint8List(3 + encodedError.length);

    result[0] = eventCode.code;
    result[1] = 0; // subEventCode
    result[2] = id;
    result.setRange(3, result.length, encodedError);

    return result;
  }

  factory ErrorCheckEvent.decode(Uint8List data){
    return ErrorCheckEvent(
      id: data[0],
      error: utf8.decode(data.sublist(1))
    );
  }
}


class SuccessCheckEvent extends CheckEvent{
  const SuccessCheckEvent({
    required super.id
  });

  @override
  Uint8List encode() => Uint8List.fromList([
    eventCode.code, // eventCode
    1, // eventSubCode
    id 
  ]);

  factory SuccessCheckEvent.decode(Uint8List data){
    return SuccessCheckEvent(
      id: data[0]
    );
  }
}










