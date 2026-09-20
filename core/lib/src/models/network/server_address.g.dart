// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerAddress _$ServerAddressFromJson(Map<String, dynamic> json) =>
    ServerAddress(
      port: (json['port'] as num).toInt(),
      interface: ServerInterface.fromJson(
        json['interface'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ServerAddressToJson(ServerAddress instance) =>
    <String, dynamic>{'port': instance.port, 'interface': instance.interface};
