// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_interface.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerInterface _$ServerInterfaceFromJson(Map<String, dynamic> json) =>
    ServerInterface(
      interfaceName: json['interfaceName'] as String,
      ip: json['ip'] as String,
    );

Map<String, dynamic> _$ServerInterfaceToJson(ServerInterface instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'interfaceName': instance.interfaceName,
    };
