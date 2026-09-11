import 'package:flutter/material.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/domain/model/button_group.dart';
import 'package:game_controller/domain/model/controller.dart';
import 'package:game_controller/domain/model/positioned_button_group.dart';

extension ControllerExtensions on Controller{
  PositionedButtonGroup getPosGroupAtIndex(int index) 
    => buttonGroups[index];
  ButtonGroup getGroupAtIndex(int index) 
    => getPosGroupAtIndex(index).buttonGroup;
  Button getButtonAtIndex(int groupIndex, int btnIndex) 
    => getGroupAtIndex(groupIndex).buttons[btnIndex];


  Controller editPosGroup(int posGroupIndex, PositionedButtonGroup posGroup){
    return copyWith(
      buttonGroups: [
        for(int i = 0 ; i < buttonGroups.length; i++)
        if(i != posGroupIndex) buttonGroups[i]
        else posGroup
      ]
    );
  }

  Controller editPostion(int posGroupIndex, Offset position){
    return editPosGroup(
      posGroupIndex, 
      getPosGroupAtIndex(posGroupIndex).copyWith(
        relativePosition: position
      )
    );
  }

  Controller editGroup(int groupIndex, ButtonGroup group){
    return editPosGroup(
      groupIndex, 
      getPosGroupAtIndex(groupIndex).copyWith(
        buttonGroup: group
      )
    );
  }

  Controller editButton(int groupIndex, int btnIndex, Button button){
    final group = getGroupAtIndex(groupIndex);
    
    return editGroup(
      groupIndex, 
      group.copyWith(
        buttons: [
          for(int i = 0 ; i < group.buttons.length; i++)
          if(i != btnIndex) group.buttons[i]
          else button
        ]
      )
    );
  }

  
}