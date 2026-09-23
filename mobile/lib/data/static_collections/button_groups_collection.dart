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
    
    .singleButtonGroup(button: DefaultBtnCollection.menu , screenRelativeSize: 0.09),
    .singleButtonGroup(button: DefaultBtnCollection.play , screenRelativeSize: 0.09),
  ];
  
  static List<ButtonGroup> joystickGroup = [
    .singleButtonGroup(button: DefaultBtnCollection.leftJoystick  , screenRelativeSize: 0.23),
    .singleButtonGroup(button: DefaultBtnCollection.rightJoystick , screenRelativeSize: 0.23),    
    .singleButtonGroup(button: DefaultBtnCollection.dpad, screenRelativeSize: 0.23),
    .singleButtonGroup(button: DefaultBtnCollection.tactilPanel, screenRelativeSize: 0.30)
  ];

  static List<ButtonGroup> multipleButtons  = [
    ButtonGroup(buttons: [
      DefaultBtnCollection.btnY,
      DefaultBtnCollection.btnB,
      DefaultBtnCollection.btnA,
      DefaultBtnCollection.btnX,
    ], screenRelativeSize: 0.23, internalMargin: 0, rotationDegreess: 0),
  
    ButtonGroup(buttons: [
      DefaultBtnCollection.menu,
      DefaultBtnCollection.play
    ], screenRelativeSize: 0.20, internalMargin: 0, rotationDegreess: 0),

    ButtonGroup(buttons: [
      DefaultBtnCollection.rb,
      DefaultBtnCollection.rt
    ], screenRelativeSize: 0.20, internalMargin: 0, rotationDegreess: 90),
    
    ButtonGroup(buttons: [
      DefaultBtnCollection.lb,
      DefaultBtnCollection.lt
    ], screenRelativeSize: 0.20, internalMargin: 0, rotationDegreess: 90)
    
  ];
}