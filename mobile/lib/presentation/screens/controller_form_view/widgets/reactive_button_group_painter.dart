import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/providers/controller_edit_provider.dart';
import 'package:game_controller/presentation/widgets/button_group_painter.dart';
import 'package:game_controller/presentation/widgets/inherited_value.dart';


/// Responsible for reacting to:
///   Changes in the ButtonGroup
class ReactiveButtonGroupPainter extends ConsumerWidget{
  const ReactiveButtonGroupPainter({
    super.key,
    required this.btnGroupIndex
  });

  final int btnGroupIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerId = InheritedValue.of<String?>(context);

    final buttonGroup = ref.watch(controllerEditProvider(controllerId)
      .select(
        (c) => c.controller.buttonGroups.length > btnGroupIndex
          ? c.controller.buttonGroups[btnGroupIndex].buttonGroup
          : null
    ));
    
    if(buttonGroup == null) return SizedBox.shrink();

    final size = MediaQuery.of(context).size;

    return ButtonGroupPainter(
      buttonGroup: buttonGroup,
      btnBuilder: (button, btnIndex)=>GestureDetector(
        
        child: AbsorbPointer(child: button,),
 
        onTap: () {
          ref.read(controllerEditProvider(controllerId).notifier)
            .selectGroupAndButton( btnGroupIndex, btnIndex);
        },

        onLongPressStart: (details){
          ref.read(controllerEditProvider(controllerId).notifier)
            .selectGroupAndButton( btnGroupIndex, btnIndex );
        },

        // onScaleUpdate: (details){
        //   ref.read(controllerEditProvider.notifier).editSelectedButtonGroup(
        //     buttonGroup.copyWith(
        //       screenRelativeSize: (buttonGroup.screenRelativeSize * details.scale)
        //       .clamp(0.03, 1)
        //     )
        //   );
        // },

        onLongPressMoveUpdate: (details){

          final double dx = (
            (details.globalPosition.dx / size.width) 
          ).clamp(0, 1);
          final double dy = (
            (details.globalPosition.dy / size.height)
          ).clamp(0, 1);
          
          ref.read(controllerEditProvider(controllerId).notifier)
            .editSelectedPosition( Offset(dx, dy) );
        },
 
      )
    );
  }


}