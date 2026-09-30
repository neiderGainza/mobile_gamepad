// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Button _$ButtonFromJson(Map<String, dynamic> json) => Button(
  buttonData: ButtonData.fromJson(json['buttonData'] as Map<String, dynamic>),
  buttonType:
      $enumDecodeNullable(_$ButtonTypeEnumMap, json['buttonType']) ??
      .sinlgePress,
  buttonCodes: (json['buttonCodes'] as List<dynamic>)
      .map((e) => const ButtonCodeConverter().fromJson(e as String))
      .toList(),
);

Map<String, dynamic> _$ButtonToJson(Button instance) => <String, dynamic>{
  'buttonData': instance.buttonData,
  'buttonType': _$ButtonTypeEnumMap[instance.buttonType]!,
  'buttonCodes': instance.buttonCodes
      .map(const ButtonCodeConverter().toJson)
      .toList(),
};

const _$ButtonTypeEnumMap = {
  ButtonType.sinlgePress: 0,
  ButtonType.joystick: 1,
  ButtonType.tactilPanel: 2,
  ButtonType.dpad: 3,
};
