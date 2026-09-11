import 'package:game_controller/domain/model/controller.dart';

abstract class ControllerRepository {
  List<Controller> get localControllers;

  Controller getLocalControllerById(String controllerId); 

  Future<String> upsertController(Controller controller);
  
  Future<void> removeController(String controllerId);
}