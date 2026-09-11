///
class VirtualDeviceException implements Exception{
  final String ? message;
  VirtualDeviceException(this.message);
}

///
class InitVirtualDeviceException extends VirtualDeviceException{
  InitVirtualDeviceException(super.message);
}


