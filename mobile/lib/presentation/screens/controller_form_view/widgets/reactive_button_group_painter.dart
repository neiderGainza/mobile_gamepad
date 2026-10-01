import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/providers/controller_edit_provider.dart';
import 'package:game_controller/presentation/widgets/button_painters/button_group_painter.dart';
import 'package:game_controller/presentation/utils/inherited_value.dart';


/// Responsible for reacting to:
///   Changes in the ButtonGroup
class ReactiveButtonGroupPainter extends ConsumerStatefulWidget{
  const ReactiveButtonGroupPainter({
    super.key,
    required this.btnGroupIndex
  });

  final int btnGroupIndex;

  @override
  ConsumerState<ReactiveButtonGroupPainter> createState() => _ReactiveButtonGroupPainterState();
}

class _ReactiveButtonGroupPainterState extends ConsumerState<ReactiveButtonGroupPainter> {
  
  @override
  Widget build(BuildContext context) {
    final controllerId = InheritedValue.of<String?>(context);

    final buttonGroup = ref.watch(controllerEditProvider(controllerId)
      .select(
        (c) => c.controller.buttonGroups.length > widget.btnGroupIndex
          ? c.controller.buttonGroups[widget.btnGroupIndex].buttonGroup
          : null
    ));

    final isSelected = ref.watch(controllerEditProvider(controllerId)
      .select( (c) => c.selectedGroupIndex == widget.btnGroupIndex));

    if(buttonGroup == null) return SizedBox.shrink();
    final size = MediaQuery.of(context).size;


    return DottedBorder(
      
      options: RoundedRectDottedBorderOptions(
        radius: .circular(10),
        color : isSelected == true
          ? Theme.of(context).colorScheme.onSurface
          : Colors.transparent,
      ),

      child: ButtonGroupPainter(
        buttonGroup: buttonGroup,
        btnBuilder: (button, btnIndex)=>GestureDetector(
      
          child: AbsorbPointer(child: button,),
       
          onPanDown: (_) {
            ref.read(controllerEditProvider(controllerId).notifier)
              .selectGroupAndButton( widget.btnGroupIndex, btnIndex);
          },
      
          

          onLongPressMoveUpdate: (details){
            
            final double dx = (
              (details.globalPosition.dx + details.localPosition.dx)/ size.width 
            );
            final double dy = (
              (details.globalPosition.dy + details.localPosition.dy)/ size.height
            );
            
            ref.read(controllerEditProvider(controllerId).notifier)
              .editSelectedPosition( Offset(dx, dy) );
          },
       
        )
      ),
    );
  }
}