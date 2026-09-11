import 'package:flutter/material.dart';
import 'package:game_controller/data/static_collections/button_groups_collection.dart';
import 'package:game_controller/domain/model/button_group.dart';
import 'package:game_controller/presentation/widgets/button_group_painter.dart';
import 'package:go_router/go_router.dart';

class ButtonMenu extends StatelessWidget {
  const ButtonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),

      child: SingleChildScrollView(
        child: Column(
          children: [
            buttonsTile(
              'Simple Buttons',
              ButtonGroupsCollection.simpleSingleButtonGroup,
              80,
              true,
            ),

            buttonsTile(
              'Joysticks',
              ButtonGroupsCollection.joystickGroup,
              160,
              true,
            ),

            buttonsTile(
              'Collections',
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
