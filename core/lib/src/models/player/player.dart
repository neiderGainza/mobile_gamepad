import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
@JsonSerializable()
class Player with _$Player{
  final String deviceName;
  final String deviceId;
  final String name;

  const Player({
    required this.deviceId,
    required this.deviceName,
    required this.name
  });
  
  String get id => deviceId;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}