import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_controller/domain/model/button.dart';

part 'button_group.freezed.dart';
part 'button_group.g.dart';

@freezed
@JsonSerializable()
class ButtonGroup with _$ButtonGroup{
  final UnmodifiableListView<Button> buttons;
  final double screenRelativeSize;
  final double internalMargin;

  ButtonGroup({
    required List<Button> buttons,
    double screenRelativeSize = 0.23,
    double internalMargin     = 0.01,
  }): buttons = UnmodifiableListView(buttons)
    , internalMargin     = internalMargin.clamp(0, 1)
    , screenRelativeSize = screenRelativeSize.clamp(0.05, 1);

  ButtonGroup.singleButtonGroup({
    required Button button,
    double screenRelativeSize = 0.13
  }) : this(buttons: [button], screenRelativeSize: screenRelativeSize);


  static ButtonGroup fromJson(Map json) => _$ButtonGroupFromJson(
    Map<String,dynamic>.from(json)
  );
  Map<String, dynamic> toJson() => _$ButtonGroupToJson(this);

  
}


