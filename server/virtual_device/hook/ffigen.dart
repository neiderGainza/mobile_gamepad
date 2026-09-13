import 'dart:io';
import 'package:ffigen/ffigen.dart';

void main() {
  final packageRoot = Platform.script.resolve('../');

  if(Platform.isLinux){
    final functions = {
      'open_device',
      'open_poll_file',
      'close_poll_file',
      'write_poll_file',
      'read_input_event',
      'read_input_or_poll',
      'ioctl_ui_set_evbit',
      'ioctl_ui_set_keybit',
      'ioctl_ui_set_absbit',
      'ioctl_ui_set_relbit',
      'ioctl_ui_set_ffbit',
      'create_device',
      'close_device',
      'press_button',
      'move_axis',
      'sync_device',
    };

    FfiGenerator(
      output: Output(
        dart: DartOutput( path: packageRoot.resolve('lib/src/uinput/uinput_bridge.dart'), ),
      ),
      
      input: Input(
        entryPoints: [packageRoot.resolve('src/uinput_bridge.h')],
      ),

      visitors: [
        Visitor(
          func: (node) {
            node.isIncluded = functions.contains(node.originalName);
          }, 
          macroConstant: (node) {
            final name = node.originalName;
            node.isIncluded = name.startsWith('BTN_') ||
                name.startsWith('EV_') ||
                name.startsWith('ABS_') ||
                name.startsWith('UI_') ||
                name.startsWith('BUS_') ||
                name.startsWith('POLL_');
          }
        ),
      ],
    ).generate();
  }

  if(Platform.isWindows){
    
  }

}
