import 'package:game_controller/data/static_collections/buttons_collection.dart';
import 'package:game_controller/domain/model/button_group.dart';


class ButtonGroupsCollection {
  static List<ButtonGroup> simpleSingleButtonGroup = [
    .singleButtonGroup(button: DefaultBtnCollection.btnA),
    .singleButtonGroup(button: DefaultBtnCollection.btnB),
    .singleButtonGroup(button: DefaultBtnCollection.btnX),
    .singleButtonGroup(button: DefaultBtnCollection.btnY),

    .singleButtonGroup(button: DefaultBtnCollection.lt),
    .singleButtonGroup(button: DefaultBtnCollection.lb),
    .singleButtonGroup(button: DefaultBtnCollection.rt),
    .singleButtonGroup(button: DefaultBtnCollection.rb),
    
    .singleButtonGroup(button: DefaultBtnCollection.menu , screenRelativeSize: 0.2),
    .singleButtonGroup(button: DefaultBtnCollection.play , screenRelativeSize: 0.2),
  ];
  
  static List<ButtonGroup> joystickGroup = [
    .singleButtonGroup(button: DefaultBtnCollection.leftJoystick  , screenRelativeSize: 0.5),
    .singleButtonGroup(button: DefaultBtnCollection.rightJoystick , screenRelativeSize: 0.5),    
  ];

  static List<ButtonGroup> multipleButtons  = [
    ButtonGroup(buttons: [
      DefaultBtnCollection.btnY,
      DefaultBtnCollection.btnB,
      DefaultBtnCollection.btnA,
      DefaultBtnCollection.btnX,
    ], screenRelativeSize: 0.5, internalMargin: 0.05, rotationDegreess: 0),
    
    ButtonGroup(buttons: [
      DefaultBtnCollection.btnY,
      DefaultBtnCollection.btnA,
      DefaultBtnCollection.btnX,
    ], screenRelativeSize: 0.5, internalMargin: 0.05, rotationDegreess: 0),
    
  ];
}