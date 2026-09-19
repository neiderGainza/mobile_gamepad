import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/domain/model/positioned_button_group.dart';
import 'package:game_controller/presentation/providers/controller_edit_provider.dart';
import 'package:game_controller/presentation/screens/controller_form_view/menus/buttons_menu.dart';
import 'package:game_controller/presentation/screens/controller_form_view/menus/controller_metada_form.dart';
import 'package:game_controller/presentation/utils/inherited_value.dart';
import 'package:go_router/go_router.dart';

class TopMenu extends ConsumerWidget {
  const TopMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      padding: const .symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius : .vertical(bottom: .circular(10)),
        color        : Theme.of(context).colorScheme.primaryContainer,
      ),

      child: Row(
        mainAxisSize: .min,
        children: [
          myBackButton(context),
          addButton(context, ref),    
          saveButton(context, ref)    
        ],
      ),
    );
  }

  Widget addButton(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    return FilledButton(
      onPressed: () async {
        final buttonGroup = await showModalBottomSheet(
          context: context,
          builder: (context) => const ButtonMenu(),
        );

        if (buttonGroup != null) {
          ref.read(controllerEditProvider(controllerId).notifier)
            .addPositionedBtnGroup(PositionedButtonGroup(buttonGroup: buttonGroup));
        }
      },
      child: Text("Add Button"),
    );
  }

  Widget myBackButton(BuildContext context){
    return BackButton(
      color: Theme.of(context).colorScheme.onPrimaryContainer
    ); 
  }

  Widget saveButton(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    final controllerName = ref.watch(controllerEditProvider(controllerId)
      .select( (c) => c.controller.name )
    );

    return IconButton(
      onPressed: () async {
        final updatedAndSaved = await showDialog(
          useSafeArea: false,
          context: context, 
          builder: (context) => ControllerMetadaForm(
            controllerId: controllerId,
            initValue: controllerName,
          )
        );

        if(updatedAndSaved == true){ context.pop(); }
      },
      icon: Icon(
        Icons.save_as_outlined,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    ); 
  }
}
