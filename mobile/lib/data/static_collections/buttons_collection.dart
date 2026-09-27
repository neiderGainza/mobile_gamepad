import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/domain/model/button_data.dart';


class DefaultBtnCollection{
  static Button btnA = Button(
    buttonData: ButtonData(label: 'A', backgroundColorValue: 4294901760), 
    buttonCodes: [.btnA],
  );
  static Button btnB = Button(
    buttonData: ButtonData(label: 'B'), 
    buttonCodes: [.btnB],
  );
  static Button btnX = Button(
    buttonData: ButtonData(label: 'X'), 
    buttonCodes: [.btnX],
  );
  static Button btnY = Button(
    buttonData: ButtonData(label: 'Y'), 
    buttonCodes: [.btnY],
  );
  
  static Button menu = Button(
    buttonData: ButtonData(
      label: '≡', 
      shape: .rectangle,
      borderRadius: 8,
    ), 
    buttonCodes: [.menu],
  );

  static Button play = Button(
    buttonData: ButtonData(
      label: '►', 
      shape: .rectangle,
      borderRadius: 8,
    ), 
    buttonCodes: [.view],
  );

  static Button lt = Button(
    buttonData: ButtonData(
      label: 'LT', 
      shape: .rectangle,
      borderRadius: 12,
    ), 
    buttonCodes: [.lt],
  );
  static Button rt = Button(
    buttonData: ButtonData(
      label: 'RT', 
      shape: .rectangle,
      borderRadius: 12,
    ), 
    buttonCodes: [.rt],
  );
  static Button lb = Button(
    buttonData: ButtonData(
      label: 'LB', 
      shape: .rectangle,
      borderRadius: 12,
    ), 
    buttonCodes: [.lb],
  );

  static Button rb = Button(
    buttonData: ButtonData(
      label: 'RB', 
      shape: .rectangle,
      borderRadius: 12,
    ), 
    buttonCodes: [.rb],
  );


  static Button leftJoystick = Button(
    buttonType: .joystick,
    buttonData: ButtonData(
      label: 'l', 
      borderWidth: 4
    ), 
    buttonCodes: [.ls],
  );

  static Button rightJoystick = Button(
    buttonType: .joystick,
    buttonData: ButtonData(
      label: 'r',
      borderWidth: 4 
    ), 
    buttonCodes: [.rs],

  );

  static Button dpad = Button(
    buttonType: .dpad,
    buttonData: ButtonData(
      label : 'dpad',
      borderWidth: 2   
    ), 
    buttonCodes: [.dpad],

  );
  
  static Button tactilPanel = Button(
    buttonType: .tactilPanel,
    buttonData: ButtonData(
      label: "tactilPanel",
      borderWidth: 2,
      borderRadius: 20
    ), 
    buttonCodes: [.rs]
  );
}

