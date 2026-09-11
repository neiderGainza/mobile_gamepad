import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/domain/model/button_group.dart';
import 'package:game_controller/domain/model/controller.dart';
import 'package:game_controller/domain/model/positioned_button_group.dart';
import 'package:game_controller/presentation/providers/controllers_provider.dart';
import 'package:game_controller/presentation/utils/controller_extensions.dart';

part 'controller_edit_provider.freezed.dart';
part 'controller_edit_provider.g.dart';

final controllerEditProvider = NotifierProvider
  .family<ControllerEditNotifier, ControllerEditState, String?>(
    ControllerEditNotifier.new
  );


class ControllerEditNotifier extends Notifier<ControllerEditState>{
  ControllerEditNotifier(this.controllerId);

  final String ? controllerId;

  @override
  ControllerEditState build(){
    if(controllerId == null){
      return ControllerEditState(controller: Controller());
    }
    
    try{
      return ControllerEditState(
        controller: ref.read(controllersProvider).firstWhere(
          (c) => c.id == controllerId)
      );
    }catch(e){
      debugPrint("Error setting controller $e");
      rethrow;
    }
    
  }


  void addPositionedBtnGroup(PositionedButtonGroup posBtnGroup){
    state = state.copyWith( controller: state.controller.copyWith(
      buttonGroups: [...state.controller.buttonGroups, posBtnGroup]
    ));
  }

  void selectGroupAndButton(int ? groupIndex, int ? btnIndex){  
    state = state.copyWith(
      selectedButtonIndex: btnIndex,
      selectedGroupIndex: groupIndex
    );
  }

  void removeSelecteds(){
    if(state.selectedGroupIndex == null) return;

    state = state.copyWith( 
      selectedButtonIndex: null,
      selectedGroupIndex: null,
      
      controller: state.controller.copyWith(
        buttonGroups: [
          for(int i = 0 ; i < state.controller.buttonGroups.length; i++)
          if(i != state.selectedGroupIndex)
          state.controller.buttonGroups[i]
        ]
      ),
    );
  }
  
  /// Tree of copyWith edictSelectedButton uses editSelectedGroup
  /// que usa edit selectedPosGroup
  /// que usa edit controller
  void editController(Controller Function(Controller controller) edit){
    state = state.copyWith(controller: edit(state.controller));
  }

  void editSelectedPosGroup(PositionedButtonGroup posGroup){
    if(state.selectedGroupIndex == null) return;
    editController( (controller) => 
      controller.editPosGroup(state.selectedGroupIndex!, posGroup)
    );
  }

  void editSelectedPosition(Offset position){
    if(state.selectedPosGroup == null) return;

    editController( (controller) =>
      controller.editPostion(state.selectedGroupIndex!, position)
    );
  }

  void editSelectedGroup(ButtonGroup btnGroup){
    if(state.selectedGroupIndex == null) return;

    editController( (controller) =>
      controller.editGroup(state.selectedGroupIndex!, btnGroup)
    );
  }

  void editSelectedButton(Button btn){
    if(state.selectedBtn == null || state.selectedGroup == null) return;
    
    editController( (controller) =>
      controller.editButton(
        state.selectedGroupIndex!, 
        state.selectedButtonIndex!, 
        btn
      )
    );
  }


  Future<void> save() async {
    if(state.controller.id == null){
      await ref.read(controllersProvider.notifier).insertController(
          state.controller.copyWith( lastEdited: DateTime.now() )
        );
    }else{
      await ref.read(controllersProvider.notifier)
        .updateController(state.controller.copyWith( 
          lastEdited: DateTime.now()
        ));
    }
  }
}


@freezed
@JsonSerializable()
class ControllerEditState with _$ControllerEditState{
  final Controller controller;
  final int ? selectedButtonIndex;
  final int ? selectedGroupIndex;

  const ControllerEditState({
    required this.controller,
    this.selectedButtonIndex,
    this.selectedGroupIndex
  });

  PositionedButtonGroup ? get selectedPosGroup => selectedGroupIndex == null
    ? null
    : controller.getPosGroupAtIndex(selectedGroupIndex!);
  
  ButtonGroup ? get selectedGroup => selectedGroupIndex == null
    ? null
    : controller.getGroupAtIndex(selectedGroupIndex!);

  Button ? get selectedBtn => 
    (selectedButtonIndex != null && selectedGroupIndex != null)
      ? controller.getButtonAtIndex(selectedGroupIndex!, selectedButtonIndex!)
      : null;

  List<PositionedButtonGroup> get posBtnGroups => controller.buttonGroups;
}