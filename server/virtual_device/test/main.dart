import 'package:virtual_device/src/virtual_device.dart';

void main() async {
  final vd = VirtualDevice.platformDevice()..start(1);
  await Future.delayed(Duration(seconds: 10));
  vd.close();
}