import 'package:virtual_device/src/models/virtual_device_button.dart';
import 'package:virtual_device/src/uinput/uinput_bridge.dart';
import 'package:virtual_device/src/uinput/uinput_xbox.dart';
import 'package:virtual_device/virtual_device.dart';

void main() async {
  print("Started");
  UinputXbox uinput = UinputXbox();
  await uinput.start(1);

  for(int i =0; i < 5; i++){
    uinput.proccessEvent([
      VirtualDeviceInput(
        button: VirtualDeviceSinglePressButton(code: BTN_A, i10nKey: 'btnA'), 
        axis: .depth, 
        value: 1
      )
    ]);

    await Future.delayed(Duration(seconds: 1));

    uinput.proccessEvent([
      VirtualDeviceInput(
        button: VirtualDeviceSinglePressButton(code: BTN_A, i10nKey: 'btnA'), 
        axis: .depth, 
        value: 0
      )
    ]);
  }

  
  await Future.delayed( Duration(seconds: 3), () => uinput.close());
  print("Ended");
}
