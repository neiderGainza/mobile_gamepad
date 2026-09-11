import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ------------------------ Provider --------------------------
final deviceInfoProvider = Provider((ref){
  final service = DeviceInfoServiceImpl();

  return service;
});


// -------------------------Interface ------------------------------
abstract class DeviceInfoService {
  Future<String> get deviceName;

}


// ---------------------- Implementation -------------------------
class DeviceInfoServiceImpl implements DeviceInfoService{
  DeviceInfoServiceImpl() 
    : deviceInfoPlugin = DeviceInfoPlugin();
  
  final DeviceInfoPlugin deviceInfoPlugin;

  @override
  Future<String> get deviceName async {
    if(Platform.isAndroid){
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      return deviceInfo.name;
    }

    return 'UnsuportedClientDevice';
  }

}
