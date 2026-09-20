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
                shape: BoxShape.circle,
                backgroundColorValue: 4280693304,
                label: 'Y',
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCode: PlayerButton.btnY,
            ),
            Button(
              buttonData: ButtonData(
                shape: BoxShape.circle,
                backgroundColorValue: 4280693304,
                label: 'B',
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCode: PlayerButton.btnB,
            ),
            Button(
              buttonData: ButtonData(
                shape: BoxShape.circle,
                backgroundColorValue: 4280693304,
                label: 'A',
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCode: PlayerButton.btnA,
            ),
            Button(
              buttonData: ButtonData(
                shape: BoxShape.circle,
                backgroundColorValue: 4280693304,
                label: 'X',
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCode: PlayerButton.btnX,
            ),
          ],
          screenRelativeSize: 0.6,
          internalMargin: 0.05,
        ),
        relativePosition: const Offset(0.9811965811965812, 0.9870370370370369),
      ),
      PositionedButtonGroup(
        buttonGroup: ButtonGroup(
          buttons: [
            Button(
              buttonData: ButtonData(
                shape: BoxShape.circle,
                backgroundColorValue: 4280693304,
                borderWidth: 4.000000000000003,
                label: 'l',
              ),
              buttonType: ButtonType.joystick,
              buttonCode: PlayerButton.ls,
            ),
          ],
          screenRelativeSize: 0.5,
          internalMargin: 0.01,
        ),
        relativePosition: const Offset(0.16282051282051282, 0.8568518518518519),
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
              buttonCode: PlayerButton.lb,
            ),
          ],
          screenRelativeSize: 0.23,
          internalMargin: 0.01,
        ),
        relativePosition: const Offset(0.4253846153846153, 0.9681481481481483),
      ),
      PositionedButtonGroup(
        buttonGroup: ButtonGroup(
          buttons: [
            Button(
              buttonData: ButtonData(
                shape: BoxShape.rectangle,
                backgroundColorValue: 4282263331,
                label: '≡',
                borderRadius: 8.0,
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCode: PlayerButton.menu,
            ),
          ],
          screenRelativeSize: 0.23,
          internalMargin: 0.01,
        ),
        relativePosition: const Offset(0.018376068376068373, 0.1935185185185185),
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
              buttonCode: PlayerButton.rb,
            ),
          ],
          screenRelativeSize: 0.23,
          internalMargin: 0.01,
        ),
        relativePosition: const Offset(0.6687179487179488, 0.9735185185185188),
      ),
      PositionedButtonGroup(
        buttonGroup: ButtonGroup(
          buttons: [
            Button(
              buttonData: ButtonData(
                shape: BoxShape.rectangle,
                backgroundColorValue: 4282263331,
                label: '►',
                borderRadius: 8.0,
              ),
              buttonType: ButtonType.sinlgePress,
              buttonCode: PlayerButton.view,
            ),
          ],
          screenRelativeSize: 0.23,
          internalMargin: 0.01,
        ),
        relativePosition: const Offset(0.13547008547008546, 0.19611111111111107),
      ),
    ],
  );

}