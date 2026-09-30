import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/static_collections/local_storage_keys.dart';
import 'package:game_controller/domain/model/button_group.dart';
import 'package:game_controller/domain/model/controller.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:uuid/uuid.dart';


// ---------------------- Provider -------------------------
final controllerLocalStorageProvider = FutureProvider((ref) async {
  final service = ControllerLocalStorageServiceImpl(
    localStorage: await Hive.openBox(LocalStorageKeys.cacheKey),
  ); 

  return service;
});

// ---------------------- Interface -------------------------
abstract interface class ControllerLocalStorageService {
  // controller
  List<Controller> get controllers;
  
  Future<String> upsertController(Controller controller);
  
  Future<void> removeController(String controllerId);

  Controller getControllerById(String controllerId);

  // Custom buttons
  List<ButtonGroup> get customButtons;

  Future<String> upsertCustomButton(ButtonGroup btn);

  Future<void> deleteCustomButton(String id);
}


// ---------------------- Implementation -------------------------
class ControllerLocalStorageServiceImpl implements ControllerLocalStorageService{
  
  ControllerLocalStorageServiceImpl({
    required this.localStorage,
  });

  final Box localStorage;


  /// ---------------------- Controllers ---------------------------
  @override
  List<Controller> get controllers => [
    for(final controllerId in _controllerIds)
    localStorage.get(controllerId, defaultValue: null)
  ].whereType<Controller>().toList();

  @override
  Future<void> removeController(String controllerId) async {
    try{
      await localStorage.delete(controllerId);
      await localStorage.put(
        LocalStorageKeys.controllerIdsKey, 
        _controllerIds..remove(controllerId)
      );
    }catch(e){
      debugPrint("Error deleting a controller");
      rethrow;
    }
  }

  @override
  Future<String> upsertController(Controller controller) async {
    try{
      final controllerId = controller.id ?? _generateSecureControllerId();
      await _addNewControllerId(controllerId);
      await localStorage.put(
        controllerId, 
        controller.copyWith(id: controllerId)
      );
      return controllerId;
    }catch(e){
      debugPrint("Error upserting controller (id: ${controller.id}): $e");
      rethrow;
    }
  }

  @override
  Controller getControllerById(String controllerId) {
    try{
      return localStorage.get(controllerId);
    }catch(e){
      debugPrint("Error getting controller");
      rethrow;
    }
  }


  /// ------------------ Custom buttons -----------------------
  @override
  List<ButtonGroup> get customButtons => [
    ...localStorage.get(LocalStorageKeys.customButtonsKey, defaultValue: [])
  ].whereType<ButtonGroup>().toList();
  

  @override
  Future<String> upsertCustomButton(ButtonGroup btn) async {
    try{
      final id = btn.id ?? Uuid().v4();
      
      List<ButtonGroup> updatedCustomButtons = []; 
      if(btn.id == null){
        updatedCustomButtons = [
          ...customButtons,
          btn.copyWith(id: id)
        ];
      }else{
        updatedCustomButtons = [
          for(final customButton in customButtons)
          if(customButton.id != btn.id) customButton
          else btn
        ];
      }
      
      await localStorage.put(
        LocalStorageKeys.customButtonsKey,
        updatedCustomButtons
      );

      return id;
    }catch(e){
      debugPrint("Error upserting customButton (id: ${btn.id}): $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteCustomButton(String id) async {
    try{
      List<ButtonGroup> updatedCustomButtons = [
        for(final customButton in customButtons)
        if(customButton.id != id) customButton
      ]; 
      
      await localStorage.put(
        LocalStorageKeys.customButtonsKey,
        updatedCustomButtons
      );
    
    }catch(e){
      debugPrint("Error deleting customButton (id: $id): $e");
      rethrow;
    }
  }


  /// -------------------- Helpers, exhageracion jjj ------------
  Set<String> get _controllerIds {
    try{
      final controllerIds = localStorage.get(
        LocalStorageKeys.controllerIdsKey, 
        defaultValue: <String>{}
      ) as Set<String>;

      return controllerIds;
    }catch(e){
      debugPrint("Error getting controllerIds $e");
      rethrow;
    }
  }

  String _generateSecureControllerId(){
    try{
      String saveControllerId = Uuid().v7();
      while(_controllerIds.contains(saveControllerId)){
        saveControllerId = Uuid().v7();
      }
      return saveControllerId;
    } catch(e){
      debugPrint("Error generating secure controllerId: $e");
      rethrow;
    }   
  }

  Future<void> _addNewControllerId(String controllerId) async {
    try{
      final controllerIds = localStorage.get(
        LocalStorageKeys.controllerIdsKey, 
        defaultValue: <String>{}
      ) as Set<String>;

      await localStorage.put(
        LocalStorageKeys.controllerIdsKey, 
        { ...controllerIds, controllerId }
      );

    } catch(e){
      debugPrint("Error adding new secure controllerId: $e");
      rethrow;
    }   
  }

}