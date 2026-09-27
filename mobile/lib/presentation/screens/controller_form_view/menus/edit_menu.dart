import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:game_controller/presentation/providers/controller_edit_provider.dart';
import 'package:game_controller/presentation/utils/inherited_value.dart';


class EditMenu extends ConsumerWidget{
  const EditMenu({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerId = InheritedValue.of<String?>(context);
    
    final (selectedBtnIndex, selectedGroupIndex) = ref.watch(
      controllerEditProvider(controllerId)
        .select(
          (cs) => (cs.selectedButtonIndex, cs.selectedGroupIndex)
    ));

    if(selectedBtnIndex == null || selectedGroupIndex == null){
      return SizedBox.shrink();
    }

    final selectedGroupPosition = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.controller.buttonGroups.length > selectedGroupIndex
          ? cs.controller.buttonGroups[selectedGroupIndex].relativePosition
          : null
    ));

    if(selectedGroupPosition == null) return SizedBox.shrink();

    return Align(
      alignment: selectedGroupPosition.dx > 0.5 
        ? .centerLeft
        : .centerRight,

      child: Card(
        elevation: 8,
        margin: const .all(12),
        clipBehavior: .hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: .all(.circular(10))
        ),

        color: Theme.of(context).colorScheme.tertiaryContainer,
              
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,

            padding: const .all(8),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.35,
              minHeight: MediaQuery.of(context).size.height - 16
            ),
            
            child: const Column(
              crossAxisAlignment: .start,
              children: [
                // general title
                EditingMenuTitle(),

                //group edits
                GroupPropertiesTitle(),
                EditSizeTile(),
                EditMarginTile(),
                EditPositionTile(),
                EditRotationTile(),
                
                // button edits
                ButtonPropertiesTitle(),
                EditButtonShapeTile(),
                EditButtonBorderRadiusTile(),
                EditButtonBorderWithTile(),
                EditButtonBackgroundColorTile(),
                EditButtonBorderColorTile(),
                EditButtonColorTile(),
                SizedBox(height: 16,),
              ],
            ),

          ),
        ),
      ),
    );
  }
}


class EditingMenuTitle extends ConsumerWidget {
  const EditingMenuTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerId = InheritedValue.of<String?>(context);
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              alignment: .centerStart,
              fit: .scaleDown,
              child: Text(AppLocalizations.of(context)!.editingMenu, style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer
              ),),
            ),
          ),

          IconButton(onPressed: (){
            ref.read(controllerEditProvider(controllerId).notifier)
              .removeSelecteds();
          }, icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.onTertiaryContainer,))
        ],
      ),
    );
  }
}


class EditSizeTile extends ConsumerWidget {
  const EditSizeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    final groupSize = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedGroupIndex == null 
          ? null
          : cs.selectedGroup?.screenRelativeSize
      ));

    if(groupSize == null) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        visualDensity: .compact,
        title: FittedBox(
          fit: .scaleDown,
          alignment: .centerStart,
          child: Text(AppLocalizations.of(context)!.size)),
        trailing: LessStringPlus(
          plus: (){
            updateValue(controllerId, 0.01, ref);
          }, 
          less: (){
            updateValue(controllerId, -0.01, ref);
          }, 
          label: groupSize.toStringAsFixed(2)
        ),
      ),
    );
  }

  void updateValue(String? controllerId, double change, WidgetRef ref){
    final selectedGroup = ref.read(controllerEditProvider(controllerId))
      .selectedGroup;
    
    if(selectedGroup == null){
      return;
    }
    ref.read(controllerEditProvider(controllerId).notifier)
      .editSelectedGroup(
        selectedGroup.copyWith( 
          screenRelativeSize: selectedGroup.screenRelativeSize + change)
    );
  }
}


class EditPositionTile extends ConsumerWidget {
  const EditPositionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    final groupPosition = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedGroupIndex == null 
          ? null
          : cs.selectedPosGroup?.relativePosition
      ));

    if(groupPosition == null) return SizedBox.shrink();

    return Column(
      children: [
        ListTile(
          visualDensity: .compact,
          title: FittedBox(
            fit: .scaleDown,
            alignment: .centerStart,
            child: Text(AppLocalizations.of(context)!.positionX)),
          trailing: LessStringPlus(
            plus: (){
              updateValue(controllerId,0.01, ref);
            }, 
            less: (){
              updateValue(controllerId,-0.01, ref);
            }, 
            label: groupPosition.dx.toStringAsFixed(2)
          ),
        ),
        const SizedBox(height: 8,),
        ListTile(
          visualDensity: .compact,
          title: FittedBox(
            fit: .scaleDown,
            alignment: .centerStart,
            child: Text(AppLocalizations.of(context)!.positionY)),
          
          trailing: LessStringPlus(
            plus: (){
              updateValue(controllerId, 0.01, ref, false);
            }, 
            less: (){
              updateValue(controllerId, -0.01, ref, false);
            }, 
            label: groupPosition.dy.toStringAsFixed(2)
          ),
        ),
        const SizedBox(height: 8,)
      ],
    );
  }

  void updateValue(String? controllerId, double change, WidgetRef ref, [bool isX = true]){    
    final pos = ref.read(controllerEditProvider(controllerId))
      .selectedPosGroup?.relativePosition;
    
    if(pos == null){
      return;
    }

    ref.read(controllerEditProvider(controllerId).notifier)
      .editSelectedPosition(
        isX 
          ? Offset(pos.dx + change, pos.dy) 
          : Offset(pos.dx         , pos.dy + change)
    );
  }

}


class EditRotationTile extends ConsumerWidget {
  const EditRotationTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    final groupRotation = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedGroupIndex == null 
          ? null
          : cs.selectedGroup?.rotationDegreess
      ));
    
    if(groupRotation == null) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        visualDensity: .compact,
        title: FittedBox(
          fit: .scaleDown,
          alignment: .centerStart,
          child: Text(AppLocalizations.of(context)!.rotation)),
        trailing: LessStringPlus(
          plus: (){
            updateValue(controllerId, 15, ref);
          }, 
          less: (){
            updateValue(controllerId, -15, ref);
          }, 
          label: groupRotation.toStringAsFixed(1)
        ),
      ),
    );
  }

  void updateValue(String? controllerId, int change, WidgetRef ref){
    final selectedGroup = ref.read(controllerEditProvider(controllerId))
      .selectedGroup;
    
    if(selectedGroup == null){
      return;
    }
    ref.read(controllerEditProvider(controllerId).notifier)
      .editSelectedGroup(
        selectedGroup.copyWith( 
          rotationDegreess: selectedGroup.rotationDegreess! + change)
    );
  }
}



class EditMarginTile extends ConsumerWidget {
  const EditMarginTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    final groupMargin = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedGroupIndex == null 
          ? null
          : cs.selectedGroup?.internalMargin
      ));

    if(groupMargin == null) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        visualDensity: .compact,
        title: FittedBox(
          fit: .scaleDown,
          alignment: .centerStart,
          child: Text(AppLocalizations.of(context)!.margin)),
        trailing: LessStringPlus(
          plus: (){
            updateValue(controllerId, 0.01, ref);
          }, 
          less: (){
            updateValue(controllerId, -0.01, ref);
          }, 
          label: groupMargin.toStringAsFixed(2)
        ),
      ),
    );
  }

  void updateValue(String? controllerId, double change, WidgetRef ref){
    final selectedGroup = ref.read(controllerEditProvider(controllerId))
      .selectedGroup;
    
    if(selectedGroup == null){
      return;
    }

    ref.read(controllerEditProvider(controllerId).notifier)
      .editSelectedGroup(
        selectedGroup.copyWith( 
          internalMargin: selectedGroup.internalMargin + change)
    );
  }
}


class GroupPropertiesTitle extends ConsumerWidget {
  const GroupPropertiesTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerId = InheritedValue.of<String?>(context);
    final _  = ref.watch(controllerEditProvider(controllerId)
      .select(
        (c) => c.selectedGroup
      ));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              alignment: .centerStart,
              fit: .scaleDown,
              child: Text(AppLocalizations.of(context)!.groupProperties, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer
              ),),
            ),
          ),

          // IconButton(onPressed: (){
          //   ref.read(controllerEditProvider(controllerId).notifier)
          //     .removeSelecteds();
          // }, icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.onTertiaryContainer,))
        ],
      ),
    );
  }
}


class ButtonPropertiesTitle extends ConsumerWidget {
  const ButtonPropertiesTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerId = InheritedValue.of<String?>(context);
    final selectedBtn  = ref.watch(controllerEditProvider(controllerId)
      .select(
        (c) => c.selectedBtn
      ));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              alignment: .centerStart,
              fit: .scaleDown,
              child: Text(
                "${AppLocalizations.of(context)!.buttonProperties} (${selectedBtn?.buttonCodes.toString().split('.')[1]})", 
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onTertiaryContainer
                ),),
            ),
          ),
        ],
      ),
    );
  }
}


class EditButtonElevationTile extends ConsumerWidget {
  const EditButtonElevationTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    final btnElevation = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedBtn?.buttonData.elevation
      ));

    if(btnElevation == null) return SizedBox.shrink();

    return ListTile(
      visualDensity: .compact,
      title: FittedBox(
        fit: .scaleDown,
        alignment: .centerStart,
        child: Text(AppLocalizations.of(context)!.elevation)),
      trailing: LessStringPlus(
        plus: (){
          updateValue(controllerId, 1, ref);
        }, 
        less: (){
          updateValue(controllerId, -1, ref);
        }, 
        label: btnElevation.toString()
      ),
    );
  }

  void updateValue(String? controllerId, int change, WidgetRef ref){
    final selectedBtn = ref.read(controllerEditProvider(controllerId))
      .selectedBtn;
    
    if(selectedBtn == null){
      return;
    }

    ref.read(controllerEditProvider(controllerId).notifier)
      .editSelectedButton(
        selectedBtn.copyWith( 
          buttonData: selectedBtn.buttonData.copyWith(
            elevation: selectedBtn.buttonData.elevation + change
          )
        )
    );
  }
}


class EditButtonBorderWithTile extends ConsumerWidget {
  const EditButtonBorderWithTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    final property = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedBtn?.buttonData.borderWidth
      ));

    if(property == null) return SizedBox.shrink();

    return ListTile(
      visualDensity: .compact,
      title: FittedBox(
        fit: .scaleDown,
        alignment: .centerStart,
        child: Text(AppLocalizations.of(context)!.borderWidth)),
      trailing: LessStringPlus(
        plus: (){
          updateValue(controllerId, 0.1, ref);
        }, 
        less: (){
          updateValue(controllerId, -0.1, ref);
        }, 
        label: property.toStringAsFixed(1)
      ),
    );
  }

  void updateValue(String? controllerId, double change, WidgetRef ref){
    final selectedBtn = ref.read(controllerEditProvider(controllerId))
      .selectedBtn;
    
    if(selectedBtn == null){
      return;
    }

    ref.read(controllerEditProvider(controllerId).notifier)
      .editSelectedButton(
        selectedBtn.copyWith( 
          buttonData: selectedBtn.buttonData.copyWith(
            borderWidth: selectedBtn.buttonData.borderWidth + change
          )
        )
    );
  }
}


class EditButtonShapeTile extends ConsumerWidget {
  const EditButtonShapeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    final property = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedBtn?.buttonData.shape
      ));

    final btnType = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedBtn?.buttonType
      ));


    if(property == null || btnType == .joystick) return SizedBox.shrink();

    return ListTile(
      visualDensity: .compact,
      title: FittedBox(
        fit: .scaleDown,
        alignment: .centerStart,
        child: Text(AppLocalizations.of(context)!.shape)),
      trailing: Container(
        clipBehavior: .hardEdge,
        padding: .only(left: 8),
        decoration: BoxDecoration(
          border: .all(width: 1, color: Theme.of(context).colorScheme.onTertiaryContainer),
          borderRadius: .circular(10)
        ),
        child: DropdownButton<BoxShape>(
          value: property,
          items: [
            for(final shape in BoxShape.values)
            DropdownMenuItem(
              value: shape,
              child: Text(shape == BoxShape.circle
                ? AppLocalizations.of(context)!.circle
                : AppLocalizations.of(context)!.rectangle),
            )
          ], 
          onChanged: (newShape){
            if(newShape != null){
              updateValue(controllerId, newShape, ref);
            }
          },
            
          borderRadius: .circular(10),
          underline: SizedBox.shrink(),
        )
      ),
      
      
    );
  }

  void updateValue(String? controllerId, BoxShape change, WidgetRef ref){
    final selectedBtn = ref.read(controllerEditProvider(controllerId))
      .selectedBtn;
    
    if(selectedBtn == null){
      return;
    }

    ref.read(controllerEditProvider(controllerId).notifier)
      .editSelectedButton(
        selectedBtn.copyWith( 
          buttonData: selectedBtn.buttonData.copyWith(
            shape: change
          )
        )
    );
  }
}


class EditButtonBorderRadiusTile extends ConsumerWidget {
  const EditButtonBorderRadiusTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    final radius = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedBtn?.buttonData.borderRadius
      ));
    
    final shape = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedBtn?.buttonData.shape
      ));
    
    if(radius == null || shape == null || shape == .circle) return SizedBox.shrink();

    return ListTile(
      visualDensity: .compact,
      title: FittedBox(
        fit: .scaleDown,
        alignment: .centerStart,
        child: Text(AppLocalizations.of(context)!.borderRadius)),
      trailing: LessStringPlus(
        plus: (){
          updateValue(controllerId, 1, ref);
        }, 
        less: (){
          updateValue(controllerId, -1, ref);
        }, 
        label: radius.toStringAsFixed(0)
      ),
    );
  }

  void updateValue(String? controllerId, double change, WidgetRef ref){
    final selectedBtn = ref.read(controllerEditProvider(controllerId))
      .selectedBtn;
    
    if(selectedBtn == null){
      return;
    }

    ref.read(controllerEditProvider(controllerId).notifier)
      .editSelectedButton(
        selectedBtn.copyWith( 
          buttonData: selectedBtn.buttonData.copyWith(
            borderRadius: selectedBtn.buttonData.borderRadius + change
          )
        )
    );
  }
}


class EditButtonBackgroundColorTile extends ConsumerWidget {
  const EditButtonBackgroundColorTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    final btnBackgroundColor = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedBtn?.buttonData.backgroundColor
      ));

    if(btnBackgroundColor == null) return SizedBox.shrink();

    return ListTile(
      visualDensity: .compact,
      title: FittedBox(
        fit: .scaleDown,
        alignment: .centerStart,
        child: Text(AppLocalizations.of(context)!.backgroundColor)
      ),
      trailing: ColorIndicator(
        color: btnBackgroundColor,
        borderColor: Theme.of(context).colorScheme.onTertiaryContainer,
        hasBorder: true,
        width: 60,
        height: 40,
        borderRadius: 10,
        onSelectFocus: false,
        onSelect: () async {
          final newColor = await showColorPickerDialog(
            context, 
            btnBackgroundColor,

          );
          updateValue(controllerId, newColor, ref);
        },
      ),
    );

  }

  void updateValue(String? controllerId, Color color, WidgetRef ref){
    final selectedBtn = ref.read(controllerEditProvider(controllerId))
      .selectedBtn;
    
    if(selectedBtn == null){
      return;
    }

    ref.read(controllerEditProvider(controllerId).notifier)
      .editSelectedButton(
        selectedBtn.copyWith( 
          buttonData: selectedBtn.buttonData.copyWith(
            backgroundColorValue: color.toARGB32()
          )
        )
    );
  }
}


class EditButtonBorderColorTile extends ConsumerWidget {
  const EditButtonBorderColorTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    final color = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedBtn?.buttonData.borderColor
      ));

    if(color == null) return SizedBox.shrink();

    return ListTile(
      visualDensity: .compact,
      title: FittedBox(
        fit: .scaleDown,
        alignment: .centerStart,
        child: Text(AppLocalizations.of(context)!.borderColor)
      ),
      trailing: ColorIndicator(
        color: color,
        borderColor: Theme.of(context).colorScheme.onTertiaryContainer,
        hasBorder: true,
        width: 60,
        height: 40,
        borderRadius: 10,
        onSelectFocus: false,
        onSelect: () async {
          final newColor = await showColorPickerDialog(
            context, 
            color,
          );
          updateValue(controllerId, newColor, ref);
        },
      ),
    );

  }

  void updateValue(String? controllerId, Color color, WidgetRef ref){
    final selectedBtn = ref.read(controllerEditProvider(controllerId))
      .selectedBtn;
    
    if(selectedBtn == null){
      return;
    }

    ref.read(controllerEditProvider(controllerId).notifier)
      .editSelectedButton(
        selectedBtn.copyWith( 
          buttonData: selectedBtn.buttonData.copyWith(
            borderColorValue: color.toARGB32()
          )
        )
    );
  }
}


class EditButtonColorTile extends ConsumerWidget {
  const EditButtonColorTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final controllerId = InheritedValue.of<String?>(context);
    
    final color = ref.watch(controllerEditProvider(controllerId)
      .select(
        (cs) => cs.selectedBtn?.buttonData.color
      ));

    if(color == null) return SizedBox.shrink();

    return ListTile(
      visualDensity: .compact,
      title: FittedBox(
        fit: .scaleDown,
        alignment: .centerStart,
        child: Text(AppLocalizations.of(context)!.fontColor)
      ),
      trailing: ColorIndicator(
        color: color,
        borderColor: Theme.of(context).colorScheme.onTertiaryContainer,
        hasBorder: true,
        width: 60,
        height: 40,
        borderRadius: 10,
        onSelectFocus: false,
        onSelect: () async {
          final newColor = await showColorPickerDialog(
            context, 
            color,
          );
          updateValue(controllerId, newColor, ref);
        },
      ),
    );

  }

  void updateValue(String? controllerId, Color color, WidgetRef ref){
    final selectedBtn = ref.read(controllerEditProvider(controllerId))
      .selectedBtn;
    
    if(selectedBtn == null){
      return;
    }

    ref.read(controllerEditProvider(controllerId).notifier)
      .editSelectedButton(
        selectedBtn.copyWith( 
          buttonData: selectedBtn.buttonData.copyWith(
            colorValue: color.toARGB32()
          )
        )
    );
  }
}


class LessStringPlus extends StatelessWidget{
  const LessStringPlus({
    super.key,
    required this.plus,
    required this.less,
    required this.label
  });

  final Function() plus;
  final Function() less;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;  
    
    return Container(
      decoration: BoxDecoration(
        border: .all(width: 1, color: cs.onTertiaryContainer),
        borderRadius: .circular(10)
      ),
      padding: const .symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: .min,
        children: [
          IconButton(
            onPressed: less, 
            onLongPress: less,
            icon: Icon(Icons.remove, color: cs.onTertiaryContainer)),
          const SizedBox(width: 8,),
          Text(label, style: tt.bodyLarge?.copyWith(
            fontFamily: 'monospace',
            fontWeight: .bold,
            color: cs.onTertiaryContainer)),
          const SizedBox(width: 8,),
          IconButton(
            onPressed  : plus, 
            icon: Icon(Icons.add, color: cs.onTertiaryContainer,))
        ],
      ),
    );
  }
}





