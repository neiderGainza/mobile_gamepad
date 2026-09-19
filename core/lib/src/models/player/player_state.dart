import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_state.freezed.dart';
part 'player_state.g.dart';

@freezed
@JsonSerializable()
class PlayerState with _$PlayerState{
  final Player player;
  final ConnectionStatus connectionStatus;

  const PlayerState({
    required this.player,
    this.connectionStatus = .disconnected,
  });

  factory PlayerState.fromJson(Map<String, dynamic> json) => _$PlayerStateFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerStateToJson(this);
}
