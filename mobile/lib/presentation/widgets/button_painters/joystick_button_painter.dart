import 'package:flutter/material.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick/joystick.dart';

/// Problema: el joistick envia informacion cada 5ms
/// (lo que puede sobrecargar la red)
///
/// Idea Optimizacion: guardamos el ultimo envio
/// y si la diferencia entre la nueva informacion y el envio
/// es insignificante, desechamos el cambio (no lo enviamos)
class JoystickButtonPainter extends StatefulWidget {
  const JoystickButtonPainter({super.key, required this.button});

  final Button button;

  @override
  State<JoystickButtonPainter> createState() => _JoystickButtonPainterState();
}

class _JoystickButtonPainterState extends State<JoystickButtonPainter> {
  @override
  Widget build(BuildContext context) {
    final buttonData = widget.button.buttonData;
    final cs = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, contrains) {
        return Joystick(
          dragCallback: (info) {},
          onDragEnd: () {},
          label: buttonData.label,
          stickSize: contrains.maxHeight / 2.5,
          fontColor: buttonData.color ?? cs.onPrimary,
          stickColor: buttonData.backgroundColor ?? cs.primary,
          borderColor: buttonData.backgroundColor ?? cs.primary,
          dragPadColor: Colors.transparent,
        );
      },
    );
  }
}
