// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionMessage _$ConnectionMessageFromJson(Map<String, dynamic> json) =>
    ConnectionMessage(
      type: $enumDecode(_$ConnectionMessageTypeEnumMap, json['type']),
      content: json['content'] as String,
    );

Map<String, dynamic> _$ConnectionMessageToJson(ConnectionMessage instance) =>
    <String, dynamic>{
      'type': _$ConnectionMessageTypeEnumMap[instance.type]!,
      'content': instance.content,
    };

const _$ConnectionMessageTypeEnumMap = {
  ConnectionMessageType.message: 'message',
  ConnectionMessageType.error: 'error',
  ConnectionMessageType.warning: 'warning',
};
