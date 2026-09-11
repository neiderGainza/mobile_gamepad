import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/providers/controller_edit_provider.dart';
import 'package:game_controller/presentation/screens/controller_form_view/menus/edit_menu.dart';
import 'package:game_controller/presentation/screens/controller_form_view/menus/top_menu.dart';
import 'package:game_controller/presentation/screens/controller_form_view/widgets/reative_controller_painter.dart';
import 'package:game_controller/presentation/widgets/inherited_value.dart';


class ControllerFormView extends ConsumerStatefulWidget{
  const ControllerFormView({
    super.key,
    required this.controllerId
  });

  final String ? controllerId;

  @override
  ConsumerState<ControllerFormView> createState() => _ControllerFormViewState();
}

class _ControllerFormViewState extends ConsumerState<ControllerFormView> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

  }
  
  @override
  void dispose() {
    
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _ = ref.watch(controllerEditProvider(widget.controllerId)
      .select(
        (c) => (
          c.controller.name, 
          c.controller.description
        ))
    );

    return InheritedValue<String?>(
      value: widget.controllerId,
      
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onTap: (){
                ref.read(controllerEditProvider(widget.controllerId).notifier)
                  .selectGroupAndButton(null, null);
              },
            ),
      
            const ReactiveControllerPainter(),
            const Align( alignment: .topCenter, child: TopMenu()),
            const EditMenu(),
          ],
        ),
      ),
    );
  }
} 
