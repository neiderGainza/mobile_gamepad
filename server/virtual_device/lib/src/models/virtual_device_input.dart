import 'package:core/core.dart';
import 'virtual_device_button.dart';

/// Describe una accion de un virtual device
class VirtualDeviceInput {
  final VirtualDeviceButton button;
  final ButtonAxis axis;  
  final double value;

  const VirtualDeviceInput({
    required this.button,
    required this.axis,
    required this.value
  });
}
