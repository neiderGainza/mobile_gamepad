import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/providers/controller_edit_provider.dart';
import 'package:game_controller/presentation/screens/controller_form_view/widgets/reactive_button_group_painter.dart';
import 'package:game_controller/presentation/utils/inherited_value.dart';

/// Responsible for reacting to:
///   new PosButtonGroup
///   change in position of a PosButtonGroup
class ReactiveControllerPainter extends ConsumerWidget{
  const ReactiveControllerPainter({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerId = InheritedValue.of<String?>(context);

    final posBtnGroupLength = ref.watch(controllerEditProvider(controllerId)
      .select(
        (c) => c.controller.buttonGroups.length
    ));

    return Stack(
      children: [
        
        for(int i = 0; i < posBtnGroupLength; i++)
        Consumer(
          builder: (context, ref, child){
            final position = ref.watch(controllerEditProvider(controllerId)
              .select(
                (c) => c.controller.buttonGroups.length > i
                  ? c.controller.buttonGroups[i].relativePosition
                  : null
            ));  

            if(position == null) return SizedBox.shrink();

            return Align(
              alignment: AlignmentGeometry.xy(
                2 * (position.dx - 0.5),
                2 * (position.dy - 0.5)
              ),
              child: child,
            );
          },
          child: ReactiveButtonGroupPainter(btnGroupIndex: i),
        )
        
      ],
    );
  }
}