import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';


class ButtonCodeConverter implements JsonConverter<PlayerButton, String> {
  const ButtonCodeConverter();

  @override
  PlayerButton fromJson(String source) {
    return .fromCode(int.parse(source));
  }

  @override
  String toJson(PlayerButton btn) {
    return btn.code.toString();
  }
}