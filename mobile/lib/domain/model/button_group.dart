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
  final int ? rotationDegreess;
  final String ? id;

  ButtonGroup({   
    required List<Button> buttons,
    double screenRelativeSize = 0.09,
    double internalMargin     = 0.01,
    int  ? rotationDegreess,
    this.id
  }): buttons = UnmodifiableListView(buttons)
    , internalMargin     = internalMargin.clamp(0, 1)
    , screenRelativeSize = screenRelativeSize.clamp(0.05, 1)
    , rotationDegreess   = rotationDegreess?.clamp(0, 360);

  ButtonGroup.singleButtonGroup({
    required Button button,
    double screenRelativeSize = 0.09
  }) : this(
      buttons: [button], 
      screenRelativeSize: screenRelativeSize , 
      rotationDegreess: null
    );


  static ButtonGroup fromJson(Map json) => _$ButtonGroupFromJson(
    Map<String,dynamic>.from(json)
  );
  Map<String, dynamic> toJson() => _$ButtonGroupToJson(this);

  
}


