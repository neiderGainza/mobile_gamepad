import 'package:game_controller/data/sources/controller_local_storage_service.dart';
import 'package:game_controller/domain/model/button_group.dart';
import 'package:game_controller/domain/model/controller.dart';
import 'package:game_controller/domain/repository/controller_repository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:rxdart/subjects.dart';


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


  /// Controllers
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


  /// CustomButtons
  final BehaviorSubject<List<ButtonGroup>> _customButtonsSubject 
    = .seeded(<ButtonGroup>[]);

  @override
  Stream<List<ButtonGroup>> get customButtonsStream 
    => _customButtonsSubject.stream;

  @override
  List<ButtonGroup> get customButtons {
    if(_customButtonsSubject.value.isEmpty){
      _customButtonsSubject.add(localStorageService.customButtons);
    }
    return  _customButtonsSubject.value;
  }

  @override
  Future<String> upsertCustomButton(ButtonGroup btn) async {
    try{
      final id = await localStorageService.upsertCustomButton(btn);
      _customButtonsSubject.add(localStorageService.customButtons);
      return id;
    } catch(e){
      rethrow;
    }   
  }

  @override
  Future<void> deleteCustomButton(String id) async{
    try{
      await localStorageService.deleteCustomButton(id);
      _customButtonsSubject.add(localStorageService.customButtons);
    }catch(e){
      rethrow;
    }
  }
}

