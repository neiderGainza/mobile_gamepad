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
  buttonCode: const ButtonCodeConverter().fromJson(
    json['buttonCode'] as String,
  ),
);

Map<String, dynamic> _$ButtonToJson(Button instance) => <String, dynamic>{
  'buttonData': instance.buttonData,
  'buttonType': _$ButtonTypeEnumMap[instance.buttonType]!,
  'buttonCode': const ButtonCodeConverter().toJson(instance.buttonCode),
};

const _$ButtonTypeEnumMap = {
  ButtonType.sinlgePress: 0,
  ButtonType.joystick: 1,
  ButtonType.tactilPanel: 2,
};
