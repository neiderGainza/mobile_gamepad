import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick_dpad_tactil/tactil_panel.dart';


/// TODO : definir cambio minimo q no se envia
class TactilPanelPainter extends ConsumerStatefulWidget{
  const TactilPanelPainter({
    super.key, 
    required this.button
  });

  final Button button;

  @override
  ConsumerState<TactilPanelPainter> createState() => _TactilPanelPainterState();
}

class _TactilPanelPainterState extends ConsumerState<TactilPanelPainter> {
  @override
  Widget build(BuildContext context) {  
    final connectionRepo = ref.watch(connectionRepositoryProvider);
    
    return TactilPanel(
      button: widget.button,
      callBackFreequency: const Duration(milliseconds: 5),
      onStop: (){
        connectionRepo.send(ButtonPlayerEvent(
          btn  : .rs, 
          axis : .vertical, 
          value: 0
        ));
        connectionRepo.send(ButtonPlayerEvent(
          btn  : .rs, 
          axis : .horizontal, 
          value: 0
        ));
      },
      onUpdated: (vx, vy){
        print("Data:");
        print(vx);
        print(vy);

        connectionRepo.send(ButtonPlayerEvent(
          btn  : .rs, 
          axis : .vertical, 
          value:  vy
        ));
        connectionRepo.send(ButtonPlayerEvent(
          btn  : .rs, 
          axis : .horizontal, 
          value: vx
        ));    
      },
    ); 
  }
}