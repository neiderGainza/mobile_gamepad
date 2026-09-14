import 'package:flutter/material.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick_button_painter.dart';
import 'package:game_controller/presentation/widgets/button_painters/single_press_button_painter.dart';

class ButtonPainter extends StatelessWidget {
  const ButtonPainter({
    super.key, 
    required this.button,
    required this.size 
  });

  final Button button;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
    
      child: switch (button.buttonType) {
        .sinlgePress => SinglePressButtonPainter(button: button),
        .joystick => JoystickButtonPainter(button: button),
        _ => throw UnimplementedError(),
      },
    );
  }
}
