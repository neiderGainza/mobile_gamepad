import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/providers/controller_edit_provider.dart';
import 'package:game_controller/presentation/widgets/inherited_value.dart';

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
                EditingMenuTitle(),
                Divider(height: 16,),
                EditSizeTile(),
                Divider(height: 16,),
                EditPositionTile(),
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
            child: Text("Editing Menu", style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.onTertiaryContainer
            ),),
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

    return ListTile(
      title: Text("Size:"),
      trailing: LessStringPlus(
        plus: (){
          updateValue(controllerId, 0.01, ref);
        }, 
        less: (){
          updateValue(controllerId, -0.01, ref);
        }, 
        label: groupSize.toStringAsFixed(2)
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
          title: Text("Pos x:"),
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
          title: Text("Pos y:"),
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







