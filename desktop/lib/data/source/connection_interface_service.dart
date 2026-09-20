import 'dart:async';
import 'dart:io';

import 'package:core/src/models/network/server_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/subjects.dart';

//----------------------- Provider ------------------------------
final connectionInterfaceServiceProvider 
  = Provider<ConnectionInterfaceService>((ref){
    final service = ConnectionInterfaceServiceImpl();
    ref.onDispose(service.stop);
    return service;
  });



// ---------------------- Interface ---------------------------
abstract class ConnectionInterfaceService {
  Stream<List<ServerInterface>> get interfacesStream;

  List<ServerInterface> get interfaces;

  void start();
  void stop();
}


// ------------------------- Implementation ---------------------
class ConnectionInterfaceServiceImpl implements ConnectionInterfaceService{

  ConnectionInterfaceServiceImpl(){
    start();
  }

  final BehaviorSubject<List<ServerInterface>> _interfaceSubject
    = .seeded([]);

  Timer ? _checkForInterfaces;

  /// --------------------------- Server Interface -------------------------
  @override
  Stream<List<ServerInterface>> get interfacesStream 
    => _interfaceSubject.stream;

  @override
  List<ServerInterface> get interfaces
    => _interfaceSubject.value; 

  /// ------------------------------ Mehtods ------------------------------
  @override
  void start() {
    _updateInterfaces();
    _checkForInterfaces?.cancel();
    _checkForInterfaces = Timer.periodic(
      Duration(seconds: 3), 
      (_) async {
        await _updateInterfaces();
      }
    );
  }


  @override
  void stop() {
    _checkForInterfaces?.cancel();
    _checkForInterfaces = null;

    _interfaceSubject.drain();
  }

  /// Helpers 
  Future<void> _updateInterfaces() async{
    final newInterfaces  = await _getServerInterfaces();
    final oldInterfaces = interfaces;
    
    if(newInterfaces.length != oldInterfaces.length){
      _interfaceSubject.add(newInterfaces);
      return;
    }

    bool isThereChange = false;

    for(final interface in oldInterfaces){
      if(!newInterfaces.any((i) => i.ip == interface.ip)){
        isThereChange = true;
        break;
      }
    }

    if(isThereChange){
      _interfaceSubject.add(newInterfaces);
    }
  }


  Future<List<ServerInterface>> _getServerInterfaces() async {
    final rawInterfaces = await NetworkInterface.list(
      includeLoopback: false,
      includeLinkLocal: false
    );
    final List<ServerInterface> newInterfaces   = [];

    for(final rawInterface in rawInterfaces){
      ServerInterface ? newInterface;
      
      if(rawInterface.name.startsWith('wl')){
        newInterface =ServerInterface(
          interfaceName: 'Wifi', 
          ip: rawInterface.addresses.first.address
        );
      }
      if(rawInterface.name.startsWith('enp') || rawInterface.name.startsWith('eth')){
        newInterface =ServerInterface(
          interfaceName: 'Cable', 
          ip: rawInterface.addresses.first.address
        );
      }
      if(rawInterface.name.startsWith('bnep')){
        newInterface =ServerInterface(
          interfaceName: 'Bluetooth', 
          ip: rawInterface.addresses.first.address
        );
      }
      if(newInterface != null) newInterfaces.add(newInterface);
    }

    return newInterfaces;
  }
}

