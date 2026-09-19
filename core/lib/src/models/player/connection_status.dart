import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum ConnectionStatus {
  @JsonValue(0)
  connected(0),

  @JsonValue(1)
  connecting(1),
  
  @JsonValue(2)
  disconnected(2),

  @JsonValue(3)
  disconnecting(3);

  final int code;
  const ConnectionStatus(this.code);

  static ConnectionStatus decode(int code){
    switch(code){
      case 0: 
        return .connected;
      case 1:
        return .connecting;
      case 2:
        return .disconnected;
      case 3:
        return .disconnecting;
    }
    throw FormatException('No code $code on ConnectionStatus');
  }
}