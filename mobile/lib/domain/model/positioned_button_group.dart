import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_controller/core/json_converters/offset_json_converter.dart';
import 'package:game_controller/domain/model/button_group.dart';

part 'positioned_button_group.freezed.dart';
part 'positioned_button_group.g.dart';

@freezed
@JsonSerializable()
class PositionedButtonGroup with _$PositionedButtonGroup{
  final ButtonGroup buttonGroup;
  @OffsetJsonConverter()
  final Offset relativePosition;

  const PositionedButtonGroup({
    required this.buttonGroup,
    this.relativePosition = const Offset(0.5, 0.5)
  }) ;

  static PositionedButtonGroup fromJson(Map json) => _$PositionedButtonGroupFromJson(
    Map<String,dynamic>.from(json)
  );
  Map<String, dynamic> toJson() => _$PositionedButtonGroupToJson(this);
}