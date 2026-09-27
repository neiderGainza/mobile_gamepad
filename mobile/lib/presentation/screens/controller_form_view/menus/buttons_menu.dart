import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:game_controller/data/repositories/controller_repository_impl.dart';
import 'package:game_controller/data/static_collections/button_groups_collection.dart';
import 'package:game_controller/domain/model/button_group.dart';
import 'package:game_controller/presentation/providers/custom_buttons_provider.dart';
import 'package:game_controller/presentation/screens/controller_form_view/menus/custom_btn_form_menu.dart';
import 'package:game_controller/presentation/widgets/button_painters/button_group_painter.dart';
import 'package:go_router/go_router.dart';

class ButtonMenu extends StatelessWidget {
  const ButtonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16),

      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomButtonTile(),

            buttonsTile(
              l10n.simpleButtons,
              ButtonGroupsCollection.simpleSingleButtonGroup,
              80,
              true,
            ),
            buttonsTile(
              l10n.joysticks,
              ButtonGroupsCollection.joystickGroup,
              160,
              true,
            ),

            buttonsTile(
              l10n.collections,
              ButtonGroupsCollection.multipleButtons,
              160,
              true,
            ),            
          ],
        ),
      ),
    );
  }


  Widget buttonsTile(
    String title,
    List<ButtonGroup> buttons,
    double size, [
    bool expanded = false,
  ]) {
    return ExpansionTile(
      initiallyExpanded: expanded,
      tilePadding: .zero,
      title: Text(title),
      shape: RoundedRectangleBorder(),

      children: [
        SizedBox(
          height: size,

          child: ListView.separated(
            scrollDirection: .horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemCount: buttons.length,

            itemBuilder: (context, index) => Center(
              child: GestureDetector(
                onTap: () => context.pop(buttons[index]),
                child: AbsorbPointer(
                  child: ButtonGroupPainter(
                    size: size * 0.8,
                    buttonGroup: buttons[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}




class CustomButtonTile extends ConsumerWidget{
  const CustomButtonTile({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customGroupBtnsAsync = ref.watch(customButtonProvider);

    return ExpansionTile(
      initiallyExpanded: true,
      tilePadding: .zero,
      title: Text(AppLocalizations.of(context)!.shortcuts),
      shape: RoundedRectangleBorder(),

      children: [
        SizedBox(
          height: 80,

          child: customGroupBtnsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(),),
            
            error  : (e, t) => Text(e.toString()), 
            
            data   : (customGroupBtns) => ListView.separated(
              scrollDirection: .horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 8),
              itemCount: customGroupBtns.length + 1,

              itemBuilder: (context, index){
                if(index == 0){
                  return IconButton(
                    onPressed: () async {
                      final customBtnGroup = await showDialog(
                        context: context, 
                        barrierDismissible: false,
                        fullscreenDialog: true,
                        builder: (context) => const CreateBtnFormMenu()
                      );
                  
                      if(customBtnGroup is ButtonGroup){
                        ref.watch(controllerRepositoryProvider)
                          .upsertCustomButton( customBtnGroup);
                      }
                  
                    }, 
                    icon : Container(
                      padding: .all(8),
                      decoration: BoxDecoration(
                        borderRadius: .circular(10),
                        color: Theme.of(context).colorScheme.surfaceContainerHighest
                      ),
                      child: Icon(
                        Icons.add, 
                        size: 48,
                      ),
                    )
                  );
                }

                final customBtnGroup = customGroupBtns[index - 1];

                return Stack(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () => context.pop(customBtnGroup),
                        child: AbsorbPointer(
                          child: ButtonGroupPainter(
                            size: 80 * 0.8,
                            buttonGroup: customBtnGroup,
                          ),
                        ),
                      ),
                    ),
                
                    Positioned(
                      top  : 0,
                      right: -8,
                      child: IconButton(
                        visualDensity: .compact,
                        onPressed: (){
                          if(customBtnGroup.id != null){
                            ref.read(controllerRepositoryProvider)
                              .deleteCustomButton(customBtnGroup.id!);
                          }
                        }, 
                        icon: Icon(Icons.cancel_outlined)
                      ),
                    )
                  ],
                );
              }
            )
          )
        ),
      ],
    );
  }
}
