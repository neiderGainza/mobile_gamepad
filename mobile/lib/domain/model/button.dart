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
  final List<PlayerButton> buttonCodes;
  
  /// if null no option will appear
  /// if is true the botton should be press and press again ffor release
  /// if false the button behaived like normal
  /// only single press buttons can be swtich
  final bool ? isSwitch;

  const Button({
    required this.buttonData,
    this.buttonType = .sinlgePress,
    this.isSwitch,
    required this.buttonCodes,
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
  @JsonValue(3)
  dpad,
  @JsonValue(4)
  gravityH,
  @JsonValue(5)
  gravityV,
}

