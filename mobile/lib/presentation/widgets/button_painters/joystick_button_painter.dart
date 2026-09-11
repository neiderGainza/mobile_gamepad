import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick_customisable/flutter_joystick_customisable.dart' as j;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick/joystick.dart';

/// Problema: el joistick envia informacion cada 5ms
/// (lo que puede sobrecargar la red)
///
/// Idea Optimizacion: guardamos el ultimo envio
/// y si la diferencia entre la nueva informacion y el envio
/// es insignificante, desechamos el cambio (no lo enviamos)
class JoystickButtonPainter extends ConsumerStatefulWidget {
  const JoystickButtonPainter({super.key, required this.button});

  final Button button;

  @override
  ConsumerState<JoystickButtonPainter> createState() => _JoystickButtonPainterState();
}

class _JoystickButtonPainterState extends ConsumerState<JoystickButtonPainter> {
  j.DragInfo lastInfo = j.DragInfo(0, 0);
  final double minChangeToSend = 0.03;

  @override
  Widget build(BuildContext context) {
    final buttonData = widget.button.buttonData;
    final cs = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, contrains) {
        return Joystick(
          dragCallback: (info) {  
            
            if((lastInfo.x - info.x).abs() > minChangeToSend){
              ref.read(connectionRepositoryProvider).send(ButtonPlayerEvent(
                btn: widget.button.buttonCode, 
                axis: .horizontal, 
                value: info.x
              ));
              lastInfo = j.DragInfo(info.x, lastInfo.y);
            }

            if((lastInfo.y - info.y).abs() > minChangeToSend){
              ref.read(connectionRepositoryProvider).send(ButtonPlayerEvent(
                btn: widget.button.buttonCode, 
                axis: .vertical, 
                value: info.y
              ));
              lastInfo = j.DragInfo(lastInfo.x, info.y);
            }
          },
          onDragEnd: (){
            
            ref.read(connectionRepositoryProvider).send(ButtonPlayerEvent(
              btn: widget.button.buttonCode, 
              axis: .horizontal, 
              value: 0
            ));

            ref.read(connectionRepositoryProvider).send(ButtonPlayerEvent(
              btn: widget.button.buttonCode, 
              axis: .vertical, 
              value: 0
            ));

            lastInfo = j.DragInfo(0, 0);
          },

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
