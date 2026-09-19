import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_controller/domain/model/positioned_button_group.dart';

part 'controller.freezed.dart';
part 'controller.g.dart';


@freezed
@JsonSerializable()
class Controller with _$Controller{
  final String ? id;
  final String ? name;
  final String ? i10ln;
  final String ? description;
  final DateTime lastEdited;

  //actual controller
  final UnmodifiableListView<PositionedButtonGroup> buttonGroups;  

  Controller({
    this.id,
    this.name,
    this.i10ln,
    this.description,
    DateTime ? lastEdited,
    List<PositionedButtonGroup> buttonGroups = const []
  }): lastEdited = lastEdited ?? DateTime.now()
    , buttonGroups = UnmodifiableListView(buttonGroups);

  static Controller fromJson(Map json) => _$ControllerFromJson(
    Map<String,dynamic>.from(json)
  );
  Map<String, dynamic> toJson() => _$ControllerToJson(this);
}