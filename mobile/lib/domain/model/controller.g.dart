// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Controller _$ControllerFromJson(Map<String, dynamic> json) => Controller(
  id: json['id'] as String?,
  name: json['name'] as String?,
  i10ln: json['i10ln'] as String?,
  description: json['description'] as String?,
  lastEdited: json['lastEdited'] == null
      ? null
      : DateTime.parse(json['lastEdited'] as String),
  buttonGroups:
      (json['buttonGroups'] as List<dynamic>?)
          ?.map(
            (e) => PositionedButtonGroup.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$ControllerToJson(Controller instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'i10ln': instance.i10ln,
      'description': instance.description,
      'lastEdited': instance.lastEdited.toIso8601String(),
      'buttonGroups': instance.buttonGroups,
    };
