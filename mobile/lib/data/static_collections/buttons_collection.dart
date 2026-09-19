import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/domain/model/button_data.dart';


class DefaultBtnCollection{
  static Button btnA = Button(
    buttonData: ButtonData(label: 'A', backgroundColorValue: 4294901760), 
    buttonCode: .btnA,
  );
  static Button btnB = Button(
    buttonData: ButtonData(label: 'B'), 
    buttonCode: .btnB,
  );
  static Button btnX = Button(
    buttonData: ButtonData(label: 'X'), 
    buttonCode: .btnX,
  );
  static Button btnY = Button(
    buttonData: ButtonData(label: 'Y'), 
    buttonCode: .btnY,
  );
  
  static Button menu = Button(
    buttonData: ButtonData(
      label: '≡', 
      shape: .rectangle,
      borderRadius: 8,
    ), 
    buttonCode: .menu,
  );

  static Button play = Button(
    buttonData: ButtonData(
      label: '►', 
      shape: .rectangle,
      borderRadius: 8,
    ), 
    buttonCode: .view,
  );

  static Button lt = Button(
    buttonData: ButtonData(
      label: 'LT', 
      shape: .rectangle,
      borderRadius: 12,
    ), 
    buttonCode: .lt,
  );
  static Button rt = Button(
    buttonData: ButtonData(
      label: 'RT', 
      shape: .rectangle,
      borderRadius: 12,
    ), 
    buttonCode: .rt,
  );
  static Button lb = Button(
    buttonData: ButtonData(
      label: 'LB', 
      shape: .rectangle,
      borderRadius: 12,
    ), 
    buttonCode: .lb,
  );

  static Button rb = Button(
    buttonData: ButtonData(
      label: 'RB', 
      shape: .rectangle,
      borderRadius: 12,
    ), 
    buttonCode: .rb,
  );


  static Button leftJoystick = Button(
    buttonType: .joystick,
    buttonData: ButtonData(
      label: 'l', 
      borderWidth: 4
    ), 
    buttonCode: .ls,
  );

  static Button rightJoystick = Button(
    buttonType: .joystick,
    buttonData: ButtonData(
      label: 'r',
      borderWidth: 4 
    ), 
    buttonCode: .rs,

  );


}

