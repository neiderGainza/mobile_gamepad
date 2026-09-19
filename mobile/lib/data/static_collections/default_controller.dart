import 'dart:convert';

import 'package:game_controller/domain/model/controller.dart';
import 'package:game_controller/domain/model/positioned_button_group.dart';

class DefaultController {
  static final defaultController = Controller(
    id: 'Default 1',
    i10ln: 'Default Controller 1',
    
    buttonGroups: [
      PositionedButtonGroup.fromJson(jsonDecode(
        '{"buttonGroup":{"buttons":[{"buttonData":{"shape":"circle","backgroundColorValue":4280693304,"borderColorValue":null,"colorValue":null,"elevation":0,"borderWidth":1.0,"label":"Y","borderRadius":10.0},"buttonType":0,"buttonCode":"3"},{"buttonData":{"shape":"circle","backgroundColorValue":4280693304,"borderColorValue":null,"colorValue":null,"elevation":0,"borderWidth":1.0,"label":"B","borderRadius":10.0},"buttonType":0,"buttonCode":"1"},{"buttonData":{"shape":"circle","backgroundColorValue":4280693304,"borderColorValue":null,"colorValue":null,"elevation":0,"borderWidth":1.0,"label":"A","borderRadius":10.0},"buttonType":0,"buttonCode":"0"},{"buttonData":{"shape":"circle","backgroundColorValue":4280693304,"borderColorValue":null,"colorValue":null,"elevation":0,"borderWidth":1.0,"label":"X","borderRadius":10.0},"buttonType":0,"buttonCode":"2"}],"screenRelativeSize":0.6000000000000001,"internalMargin":0.05},"relativePosition":{"dx":0.9811965811965812,"dy":0.9870370370370369}}'
      )),
      PositionedButtonGroup.fromJson(jsonDecode(
        '{"buttonGroup":{"buttons":[{"buttonData":{"shape":"circle","backgroundColorValue":4280693304,"borderColorValue":null,"colorValue":null,"elevation":0,"borderWidth":4.000000000000003,"label":"l","borderRadius":10.0},"buttonType":1,"buttonCode":"9"}],"screenRelativeSize":0.5,"internalMargin":0.01},"relativePosition":{"dx":0.16282051282051282,"dy":0.8568518518518519}}'
      )),        
      PositionedButtonGroup.fromJson(jsonDecode(
        '{"buttonGroup":{"buttons":[{"buttonData":{"shape":"rectangle","backgroundColorValue":4280693304,"borderColorValue":null,"colorValue":null,"elevation":0,"borderWidth":1.0,"label":"LB","borderRadius":12.0},"buttonType":0,"buttonCode":"5"}],"screenRelativeSize":0.23,"internalMargin":0.01},"relativePosition":{"dx":0.4253846153846153,"dy":0.9681481481481483}}'
      )),
      PositionedButtonGroup.fromJson(jsonDecode(
        '{"buttonGroup":{"buttons":[{"buttonData":{"shape":"rectangle","backgroundColorValue":4282263331,"borderColorValue":null,"colorValue":null,"elevation":0,"borderWidth":1.0,"label":"≡","borderRadius":8.0},"buttonType":0,"buttonCode":"12"}],"screenRelativeSize":0.23000000000000004,"internalMargin":0.01},"relativePosition":{"dx":0.018376068376068373,"dy":0.1935185185185185}}'
      )),        
      PositionedButtonGroup.fromJson(jsonDecode(
        '{"buttonGroup":{"buttons":[{"buttonData":{"shape":"rectangle","backgroundColorValue":4280693304,"borderColorValue":null,"colorValue":null,"elevation":0,"borderWidth":1.0,"label":"RB","borderRadius":12.0},"buttonType":0,"buttonCode":"6"}],"screenRelativeSize":0.23,"internalMargin":0.01},"relativePosition":{"dx":0.6687179487179488,"dy":0.9735185185185188}}'
      )),
      PositionedButtonGroup.fromJson(jsonDecode(
        '{"buttonGroup":{"buttons":[{"buttonData":{"shape":"rectangle","backgroundColorValue":4282263331,"borderColorValue":null,"colorValue":null,"elevation":0,"borderWidth":1.0,"label":"►","borderRadius":8.0},"buttonType":0,"buttonCode":"11"}],"screenRelativeSize":0.23000000000000004,"internalMargin":0.01},"relativePosition":{"dx":0.13547008547008546,"dy":0.19611111111111107}}'
      )),        
    ]
  );


  static bool isDefault(Controller controller){
    return controller.id?.startsWith('Default')??false;
  }

  static bool isDefaultById(String controllerId){
    return controllerId.startsWith('Default');
  }

  static Controller getDefaultControllerById(String controllerId){
    return switch(controllerId){
      'Default 1' => defaultController,
      
      _ => throw FormatException('No default controller with id $controllerId')
    };
  }
}