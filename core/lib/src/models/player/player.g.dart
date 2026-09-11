// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
  deviceId: json['deviceId'] as String,
  deviceName: json['deviceName'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
  'deviceName': instance.deviceName,
  'deviceId': instance.deviceId,
  'name': instance.name,
};
