// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_edit_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ControllerEditState _$ControllerEditStateFromJson(Map<String, dynamic> json) =>
    ControllerEditState(
      controller: Controller.fromJson(
        json['controller'] as Map<String, dynamic>,
      ),
      selectedButtonIndex: (json['selectedButtonIndex'] as num?)?.toInt(),
      selectedGroupIndex: (json['selectedGroupIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ControllerEditStateToJson(
  ControllerEditState instance,
) => <String, dynamic>{
  'controller': instance.controller,
  'selectedButtonIndex': instance.selectedButtonIndex,
  'selectedGroupIndex': instance.selectedGroupIndex,
};
