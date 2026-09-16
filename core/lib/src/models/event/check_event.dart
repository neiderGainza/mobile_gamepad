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
    final (code, subCode) = Event.getInt4FromInt8(data[0]); 

    return switch(subCode){
      0 => ErrorCheckEvent.decode(data),
      1 => SuccessCheckEvent.decode(data),

      _ => throw FormatException('Unknown CheckEvent code: $subCode'),
     
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
    final result = Uint8List(2 + encodedError.length);

    result[0] = Event.getInt8FromInt4(eventCode.code , 0);
    result[1] = id;
    result.setRange(2, result.length, encodedError);

    return result;
  }

  factory ErrorCheckEvent.decode(Uint8List data){
    return ErrorCheckEvent(
      id   : data[1],
      error: utf8.decode(data.sublist(2))
    );
  }
}


class SuccessCheckEvent extends CheckEvent{
  const SuccessCheckEvent({
    required super.id
  });

  @override
  Uint8List encode() => Uint8List.fromList([
    Event.getInt8FromInt4(eventCode.code , 1),
    id 
  ]);

  factory SuccessCheckEvent.decode(Uint8List data){
    return SuccessCheckEvent(
      id: data[1]
    );
  }
}










