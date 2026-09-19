import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'desktop_client_state.freezed.dart';
// part 'desktop_client_state.g.dart';

@freezed
// @JsonSerializable()
class DesktopClientState with _$DesktopClientState{
  final ConnectionStatus connectionStatus;

  const DesktopClientState({
    this.connectionStatus = .connecting
  });
}
