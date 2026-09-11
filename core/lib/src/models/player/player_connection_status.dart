import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum PlayerConnectionStatus {
  @JsonValue('connected')
  connected,
  @JsonValue('connecting')
  connecting,
  @JsonValue('disconnected')
  disconnected;
}