// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'positioned_button_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionedButtonGroup _$PositionedButtonGroupFromJson(
  Map<String, dynamic> json,
) => PositionedButtonGroup(
  buttonGroup: ButtonGroup.fromJson(
    json['buttonGroup'] as Map<String, dynamic>,
  ),
  relativePosition: json['relativePosition'] == null
      ? const Offset(0.5, 0.5)
      : const OffsetJsonConverter().fromJson(
          json['relativePosition'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$PositionedButtonGroupToJson(
  PositionedButtonGroup instance,
) => <String, dynamic>{
  'buttonGroup': instance.buttonGroup,
  'relativePosition': const OffsetJsonConverter().toJson(
    instance.relativePosition,
  ),
};
