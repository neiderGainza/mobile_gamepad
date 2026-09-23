// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ButtonData _$ButtonDataFromJson(Map<String, dynamic> json) => ButtonData(
  label: json['label'] as String,
  shape: $enumDecodeNullable(_$BoxShapeEnumMap, json['shape']),
  backgroundColorValue: (json['backgroundColorValue'] as num?)?.toInt(),
  borderColorValue: (json['borderColorValue'] as num?)?.toInt(),
  colorValue: (json['colorValue'] as num?)?.toInt(),
  borderWidth: (json['borderWidth'] as num?)?.toDouble() ?? 1,
  borderRadius: (json['borderRadius'] as num?)?.toDouble() ?? 10,
  elevation: (json['elevation'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ButtonDataToJson(ButtonData instance) =>
    <String, dynamic>{
      'shape': _$BoxShapeEnumMap[instance.shape],
      'backgroundColorValue': instance.backgroundColorValue,
      'borderColorValue': instance.borderColorValue,
      'colorValue': instance.colorValue,
      'elevation': instance.elevation,
      'borderWidth': instance.borderWidth,
      'label': instance.label,
      'borderRadius': instance.borderRadius,
    };

const _$BoxShapeEnumMap = {
  BoxShape.rectangle: 'rectangle',
  BoxShape.circle: 'circle',
};
