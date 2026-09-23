import 'package:flutter/material.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick_dpad_tactil/dpad_painter.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick_dpad_tactil/joystick_button_painter.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick_dpad_tactil/single_press_button_painter.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick_dpad_tactil/tactil_panel_painter.dart';

class ButtonPainter extends StatelessWidget {
  const ButtonPainter({
    super.key, 
    required this.button,
    required this.size,
    this.margin 
  });

  final Button button;
  final double size;
  /// parche for pasing margin to dpadPainter 
  /// (looks like a group but it is a singlebutton)
  final double ? margin;

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: size,
      width: size,
    
      child: switch (button.buttonType) {
        .sinlgePress => SinglePressButtonPainter(button: button),
        .joystick    => JoystickButtonPainter(button: button),
        .dpad        => DpadPainter( button: button, margin: margin ?? 0.1),
        .tactilPanel => TactilPanelPainter( button: button, ),
      },
    );
  }
}
