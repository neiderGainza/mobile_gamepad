// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerState _$PlayerStateFromJson(Map<String, dynamic> json) => PlayerState(
  player: Player.fromJson(json['player'] as Map<String, dynamic>),
  connectionStatus:
      $enumDecodeNullable(
        _$ConnectionStatusEnumMap,
        json['connectionStatus'],
      ) ??
      .disconnected,
);

Map<String, dynamic> _$PlayerStateToJson(PlayerState instance) =>
    <String, dynamic>{
      'player': instance.player,
      'connectionStatus': _$ConnectionStatusEnumMap[instance.connectionStatus]!,
    };

const _$ConnectionStatusEnumMap = {
  ConnectionStatus.connected: 0,
  ConnectionStatus.connecting: 1,
  ConnectionStatus.disconnected: 2,
};
