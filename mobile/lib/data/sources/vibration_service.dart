import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vibrationServiceProvider = Provider<VibrationService>((ref){
  final vibrationService = VibrationServiceImpl();

  return vibrationService;
});


/// Crecera a medida q se necesite
abstract class VibrationService {
  void process(VibrationVDEvent vse);
}


class VibrationServiceImpl extends VibrationService{

  @override
  void process(VibrationVDEvent vse) {
    /// more complex future
    HapticFeedback.vibrate();
  }
}