import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_controller/core/json_converters/button_code_converter.dart';
import 'package:game_controller/domain/model/button_data.dart';

part 'button.freezed.dart';
part 'button.g.dart';

@freezed
@JsonSerializable()
class Button with _$Button{
  final ButtonData buttonData;
  final ButtonType buttonType;
  @ButtonCodeConverter()
  final PlayerButton buttonCode;

  const Button({
    required this.buttonData,
    this.buttonType = .sinlgePress,
    required this.buttonCode,
  });

  static Button fromJson(Map json) => _$ButtonFromJson(
    Map<String,dynamic>.from(json)
  );
  Map<String, dynamic> toJson() => _$ButtonToJson(this);
}


enum ButtonType {
  @JsonValue(0)
  sinlgePress,
  @JsonValue(1)
  joystick,
  @JsonValue(2)
  tactilPanel,
}

