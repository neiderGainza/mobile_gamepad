// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerState _$PlayerStateFromJson(Map<String, dynamic> json) => PlayerState(
  player: Player.fromJson(json['player'] as Map<String, dynamic>),
  connectionStatus:
      $enumDecodeNullable(
        _$PlayerConnectionStatusEnumMap,
        json['connectionStatus'],
      ) ??
      .disconnected,
  ping: _$JsonConverterFromJson<int, Duration>(
    json['ping'],
    const DurationJsonConverter().fromJson,
  ),
);

Map<String, dynamic> _$PlayerStateToJson(PlayerState instance) =>
    <String, dynamic>{
      'player': instance.player,
      'connectionStatus':
          _$PlayerConnectionStatusEnumMap[instance.connectionStatus]!,
      'ping': _$JsonConverterToJson<int, Duration>(
        instance.ping,
        const DurationJsonConverter().toJson,
      ),
    };

const _$PlayerConnectionStatusEnumMap = {
  PlayerConnectionStatus.connected: 'connected',
  PlayerConnectionStatus.disconnected: 'disconnected',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
