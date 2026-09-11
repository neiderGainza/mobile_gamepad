import 'package:core/core.dart';
import 'package:core/src/json_converters/duration_json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_state.freezed.dart';
part 'player_state.g.dart';


@freezed
@JsonSerializable()
class PlayerState with _$PlayerState{
  final Player player;
  final PlayerConnectionStatus connectionStatus;
  
  @DurationJsonConverter()
  final Duration ? ping;

  const PlayerState({
    required this.player,
    this.connectionStatus = .disconnected,
    this.ping,
  });


  static PlayerState fromJson(Map<String, dynamic> json) 
    => _$PlayerStateFromJson(json);
  
  Map<String, dynamic> toJson() => _$PlayerStateToJson(this);
}