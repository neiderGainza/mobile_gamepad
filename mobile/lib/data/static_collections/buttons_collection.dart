import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/domain/model/button_data.dart';


class DefaultBtnCollection{
  static Button btnA = Button(
    buttonData: ButtonData(label: 'A', backgroundColorValue: 4294901760, shape: .circle), 
    buttonCodes: [.btnA],
    isSwitch: false
  );
  static Button btnB = Button(
    buttonData: ButtonData(label: 'B', shape: .circle), 
    buttonCodes: [.btnB],
    isSwitch: false
  );
  static Button btnX = Button(
    buttonData: ButtonData(label: 'X', shape: .circle), 
    buttonCodes: [.btnX],
    isSwitch: false
  );
  static Button btnY = Button(
    buttonData: ButtonData(label: 'Y', shape: .circle), 
    buttonCodes: [.btnY],
    isSwitch: false
  );
  
  static Button menu = Button(
    buttonData: ButtonData(
      label: '≡', 
      shape: .rectangle,
      borderRadius: 10,
    ), 
    buttonCodes: [.menu],
  );

  static Button play = Button(
    buttonData: ButtonData(
      label: '►', 
      shape: .rectangle,
      borderRadius: 10,
    ), 
    buttonCodes: [.view],
  );

  static Button lt = Button(
    buttonData: ButtonData(
      label: 'LT', 
      shape: .rectangle,
      borderRadius: 10,
    ), 
    buttonCodes: [.lt],
    isSwitch: false
  );
  static Button rt = Button(
    buttonData: ButtonData(
      label: 'RT', 
      shape: .rectangle,
      borderRadius: 10,
    ), 
    buttonCodes: [.rt],
    isSwitch: false
  );
  static Button lb = Button(
    buttonData: ButtonData(
      label: 'LB', 
      shape: .rectangle,
      borderRadius: 10,
    ), 
    buttonCodes: [.lb],
    isSwitch: false
  );

  static Button rb = Button(
    buttonData: ButtonData(
      label: 'RB', 
      shape: .rectangle,
      borderRadius: 10,
    ), 
    buttonCodes: [.rb],
    isSwitch: false
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

  static Button gravityHorizontal = Button(
    buttonType: .gravityH,
    buttonData: ButtonData(label: "Gravity -", borderWidth: 2), 
    buttonCodes: [
      .ls
    ]
  );

  static Button gravityVertical = Button(
    buttonType: .gravityV,
    buttonData: ButtonData(label: "Gravity |", borderWidth: 2), 
    buttonCodes: [
      .ls
    ]
  );

}

