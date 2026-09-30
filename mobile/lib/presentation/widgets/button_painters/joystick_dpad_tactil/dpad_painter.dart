import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick_dpad_tactil/dpad.dart';

class DpadPainter extends ConsumerStatefulWidget{
  const DpadPainter({
    super.key,
    required this.button,
    required this.margin
  });

  final Button button;
  final double margin;

  @override
  ConsumerState<DpadPainter> createState() => _DpadPainterState();
}

class _DpadPainterState extends ConsumerState<DpadPainter> {
  // up , right , down , left
  List<bool> lastPress = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Dpad(
      button: widget.button, 
      margin: widget.margin,
      onPress: (pressed) {
        final connectionRepository = ref.read(connectionRepositoryProvider);

        if(lastPress[0] != pressed[0] || lastPress[2] != pressed[2]){
          connectionRepository.send(ButtonPlayerEvent(
            btn  : widget.button.buttonCodes.first, 
            axis : .vertical, 
            value: pressed[0] 
                    ? 1 
                    : pressed[2]
                      ? -1
                      : 0
          ));
        }
        
        if(lastPress[1] != pressed[1] || lastPress[3] != pressed[3]){
          connectionRepository.send(ButtonPlayerEvent(
            btn  : widget.button.buttonCodes.first, 
            axis : .horizontal, 
            value: pressed[1] 
                    ? 1 
                    : pressed[3]
                      ? -1
                      : 0
          ));      
        }


        lastPress = [...pressed];
      },
    );
  }
}