import 'package:core/core.dart';

sealed class VirtualDeviceButton {
  /// Inputs are double between [-1,1] but virtual devices accept int input
  /// so you have to scale the input
  int scaleInputValue(double input);

  /// Code for internacionlizate displayName
  String get i10nKey;
}

class VirtualDeviceAxisButton implements VirtualDeviceButton{
  final Map<ButtonAxis, int> codeByAxis;
  final int minAllowValue;
  final int maxAllowValue;

  final int buzz; // radio desde el centro donde no hay sensivilidad
  final int flat; // movimientos menores al flat no son aplicados

  @override
  final String i10nKey;

  const VirtualDeviceAxisButton({
    required this.codeByAxis,
    required this.minAllowValue,
    required this.maxAllowValue,
    this.buzz = 128,
    this.flat = 32,
    required this.i10nKey
  });

  @override
  int scaleInputValue(double input) {
    final clampedInput = input.clamp(-1.0, 1.0);

    final scaled = clampedInput < 0
        ? clampedInput * minAllowValue.abs() // clampInput has the signal
        : clampedInput * maxAllowValue.abs(); // por si acaso el abs 

    return scaled.round().clamp(minAllowValue, maxAllowValue);
  }
}

class VirtualDeviceSinglePressButton implements VirtualDeviceButton{
  final int code;
  @override
  final String i10nKey;

  const VirtualDeviceSinglePressButton({
    required this.code,
    required this.i10nKey
  });

  @override
  int scaleInputValue(double input) {
    return input.round().clamp(0, 1);
  }

}
