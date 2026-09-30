import 'package:game_controller/domain/model/button_group.dart';
import 'package:game_controller/domain/model/controller.dart';

abstract class ControllerRepository {
  /// Controllers
  List<Controller> get localControllers;

  Controller getLocalControllerById(String controllerId); 

  Future<String> upsertController(Controller controller);
  
  Future<void> removeController(String controllerId);

  
  /// Custom buttons
  Stream<List<ButtonGroup>> get customButtonsStream;

  List<ButtonGroup> get customButtons;

  Future<String> upsertCustomButton(ButtonGroup btn);

  Future<void> deleteCustomButton(String id);
}