import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_message.freezed.dart';
part 'connection_message.g.dart';

@freezed
@JsonSerializable()
class ConnectionMessage with _$ConnectionMessage{
  final ConnectionMessageType type;
  final DateTime time;
  final String content;

  ConnectionMessage({
    required this.type,
    required this.content
  }) : time = DateTime.now();

  ConnectionMessage.message(String content) 
    : this(type: .message, content : content);

  ConnectionMessage.error(String content) 
    : this(type: .error, content : content);
  
  ConnectionMessage.warning(String content) 
    : this(type: .warning, content : content);
  
}


enum ConnectionMessageType{
  message,
  error,
  warning;
}