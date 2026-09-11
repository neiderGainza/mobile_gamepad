import 'package:game_controller/data/sources/controller_local_storage_service.dart';
import 'package:game_controller/domain/model/controller.dart';
import 'package:game_controller/domain/repository/controller_repository.dart';
import 'package:riverpod/riverpod.dart';


final controllerRepositoryProvider = Provider((ref){
  return ControllerRepositoryImpl(
    localStorageService: ref.read(controllerLocalStorageProvider)
                            .requireValue
  );
});


class ControllerRepositoryImpl extends ControllerRepository{
  final ControllerLocalStorageService localStorageService;

  ControllerRepositoryImpl({
    required this.localStorageService
  });

  @override
  Controller getLocalControllerById(String controllerId)
    => localStorageService.getControllerById(controllerId);

  @override
  List<Controller> get localControllers 
    => localStorageService.controllers;

  @override
  Future<void> removeController(String controllerId) 
    => localStorageService.removeController(controllerId);

  @override
  Future<String> upsertController(Controller controller) 
    => localStorageService.upsertController(controller);
}