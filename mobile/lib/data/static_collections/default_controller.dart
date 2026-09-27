import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/domain/model/button_data.dart';
import 'package:game_controller/domain/model/button_group.dart';
import 'package:game_controller/domain/model/controller.dart';
import 'package:game_controller/domain/model/positioned_button_group.dart';

class DefaultController {
  static bool isDefault(Controller controller){
    return controller.id?.startsWith('Default')??false;
  }

  static bool isDefaultById(String controllerId){
    return controllerId.startsWith('Default');
  }

  static Controller getDefaultControllerById(String controllerId){
    return switch(controllerId){
      'Default 1' => defaultController,
      
      _ => throw FormatException('No default controller with id $controllerId')
    };
  }

  static final defaultController = Controller(
    id: 'Default 1',
    i10ln: 'Default Controller 1',
    buttonGroups: [
      PositionedButtonGroup(
        buttonGroup: ButtonGroup(
          buttons: [
            Button(
              buttonData: ButtonData(
                backgroundColorValue: 4281812815,
                label: 'Y',
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCodes: [PlayerButton.btnY],
            ),
            Button(
              buttonData: ButtonData(
                backgroundColorValue: 4281812815,
                label: 'B',
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCodes: [PlayerButton.btnB],
            ),
            Button(
              buttonData: ButtonData(
                backgroundColorValue: 4281812815,
                label: 'A',
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCodes: [PlayerButton.btnA],
            ),
            Button(
              buttonData: ButtonData(
                backgroundColorValue: 4281812815,
                label: 'X',
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCodes: [PlayerButton.btnX],
            ),
          ],
          screenRelativeSize: 0.23,
          internalMargin: 0.2,
        ),
        relativePosition: const Offset(0.9811965811965812, 0.9870370370370369),
      ),

      PositionedButtonGroup(
        buttonGroup: ButtonGroup(
          buttons: [
            Button(
              buttonData: ButtonData(
                shape: BoxShape.rectangle,
                backgroundColorValue: 4280693304,
                label: '≡',
                borderRadius: 8.0,
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCodes: [PlayerButton.menu],
            ),
            Button(
              buttonData: ButtonData(
                shape: BoxShape.rectangle,
                backgroundColorValue: 4280693304,
                label: '►',
                borderRadius: 8.0,
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCodes: [PlayerButton.view],
            ),
          ],
          screenRelativeSize: 0.18,
          internalMargin: 0.0,
          rotationDegreess: 0,
        ),
        relativePosition: const Offset(0.10854700854700854, 0.2675925925925926),
      ),
      
      PositionedButtonGroup(
        buttonGroup: ButtonGroup(
          buttons: [
            Button(
              buttonData: ButtonData(
                shape: BoxShape.rectangle,
                backgroundColorValue: 4280693304,
                label: 'RB',
                borderRadius: 12.0,
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCodes: [PlayerButton.rb],
            ),
            Button(
              buttonData: ButtonData(
                shape: BoxShape.rectangle,
                backgroundColorValue: 4280693304,
                label: 'RT',
                borderRadius: 12.0,
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCodes: [PlayerButton.rt],
            ),
          ],
          screenRelativeSize: 0.18,
          internalMargin: 0.0,
          rotationDegreess: 90,
        ),
        relativePosition: const Offset(0.7064102564102563, 0.9131481481481482),
      ),
      
      PositionedButtonGroup(
        buttonGroup: ButtonGroup(
          buttons: [
            Button(
              buttonData: ButtonData(
                shape: BoxShape.rectangle,
                backgroundColorValue: 4280693304,
                label: 'LB',
                borderRadius: 12.0,
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCodes: [PlayerButton.lb],
            ),
            Button(
              buttonData: ButtonData(
                shape: BoxShape.rectangle,
                backgroundColorValue: 4280693304,
                label: 'LT',
                borderRadius: 12.0,
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCodes: [PlayerButton.lt,]
            ),
          ],
          screenRelativeSize: 0.18,
          internalMargin: 0.0,
          rotationDegreess: 90,
        ),
        relativePosition: const Offset(0.34444444444444444, 0.9055555555555554),
      ),
      
      PositionedButtonGroup(
        buttonGroup: ButtonGroup(
          buttons: [
            Button(
              buttonData: ButtonData(
                shape: null,
                backgroundColorValue: null,
                borderWidth: 4.0,
                label: 'l',
                borderRadius: 10.0,
              ),
              buttonType: ButtonType.joystick,
              buttonCodes: [PlayerButton.ls],
            ),
          ],
          screenRelativeSize: 0.18,
          internalMargin    : 0.01,
          rotationDegreess  : null,
        ),
        relativePosition: const Offset(0.1064102564102564, 0.9259259259259259),
      ),

      
    ],
  );

}