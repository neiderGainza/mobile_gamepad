// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ButtonGroup _$ButtonGroupFromJson(Map<String, dynamic> json) => ButtonGroup(
  buttons: (json['buttons'] as List<dynamic>)
      .map((e) => Button.fromJson(e as Map<String, dynamic>))
      .toList(),
  screenRelativeSize: (json['screenRelativeSize'] as num?)?.toDouble() ?? 0.23,
  internalMargin: (json['internalMargin'] as num?)?.toDouble() ?? 0.01,
  rotationDegreess: (json['rotationDegreess'] as num?)?.toInt(),
);

Map<String, dynamic> _$ButtonGroupToJson(ButtonGroup instance) =>
    <String, dynamic>{
      'buttons': instance.buttons,
      'screenRelativeSize': instance.screenRelativeSize,
      'internalMargin': instance.internalMargin,
      'rotationDegreess': instance.rotationDegreess,
    };
