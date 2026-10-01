import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick_dpad_tactil/joystick.dart';

/// Problema: el joistick envia informacion cada 5ms
/// (lo que puede sobrecargar la red)
///
/// Idea Optimizacion: guardamos el ultimo envio
/// y si la diferencia entre la nueva informacion y el envio
/// es insignificante, desechamos el cambio (no lo enviamos)
/// 
/// el 0.8 del movieminto del joystick envia el total del movimiento
class JoystickButtonPainter extends ConsumerStatefulWidget {
  const JoystickButtonPainter({super.key, required this.button});

  final Button button;

  @override
  ConsumerState<JoystickButtonPainter> createState() => _JoystickButtonPainterState();
}

class _JoystickButtonPainterState extends ConsumerState<JoystickButtonPainter> {
  DragInfo lastInfo = DragInfo(0, 0);
  final double minChangeToSend = 0.05;

  @override
  Widget build(BuildContext context) {
    final buttonData = widget.button.buttonData;
    
    return Joystick(
      size: double.infinity, // size is controlled on ButtonPainter

      onDragUpdated: onDrag,
      onDragEnd    : onDragEnded,
    
      label: buttonData.label,
      borderWidth: buttonData.borderWidth,          
      fontColor: buttonData.color,
      stickColor: buttonData.backgroundColor,
      borderColor: buttonData.borderColor,
    );
  }

  void onDrag(DragInfo info){
    if((lastInfo.x - info.x).abs() > minChangeToSend){
      ref.read(connectionRepositoryProvider).send(ButtonPlayerEvent(
          btn  : widget.button.buttonCodes.first, 
          axis : .horizontal, 
          value: info.x / 0.8
      ));

      lastInfo = DragInfo(info.x, lastInfo.y);
    }

    if((lastInfo.y - info.y).abs() > minChangeToSend){
      ref.read(connectionRepositoryProvider).send(ButtonPlayerEvent(
          btn  : widget.button.buttonCodes.first, 
          axis : .vertical, 
          value: info.y / 0.8
      ));

      lastInfo = DragInfo(lastInfo.x, info.y);
    }

    // if((lastInfo.x - info.x).abs() > minChangeToSend &&
    //    (lastInfo.y - info.y).abs() > minChangeToSend
    // ){
    //   ref.read(connectionRepositoryProvider).send(MultiButtonPlayerEvent(
    //     buttonPlayerEvents: [
    //       ButtonPlayerEvent(
    //         btn  : widget.button.buttonCodes.first, 
    //         axis : .horizontal, 
    //         value: info.x / 0.8
    //       ),
    //       ButtonPlayerEvent(
    //         btn: widget.button.buttonCodes.first, 
    //         axis: .vertical, 
    //         value: info.y/ 0.8
    //       )
    //   ]));

    //   lastInfo = DragInfo(info.x, info.y);
    // }
    
  }

  void onDragEnded(){
    ref.read(connectionRepositoryProvider).send(MultiButtonPlayerEvent(
      buttonPlayerEvents: [
        ButtonPlayerEvent(
          btn  : widget.button.buttonCodes.first, 
          axis : .horizontal, 
          value: 0
        ),
        ButtonPlayerEvent(
          btn: widget.button.buttonCodes.first, 
          axis: .vertical, 
          value: 0
        )
    ]));

    lastInfo = DragInfo(0, 0);
  }
}
