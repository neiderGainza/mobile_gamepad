import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick_dpad_tactil/gravity_button.dart';

class GravityButtonPainter extends ConsumerStatefulWidget {
  const GravityButtonPainter({
    super.key,
    required this.button,
    required this.orietation,
  });

  final Orient orietation;
  final Button button;

  @override
  ConsumerState<GravityButtonPainter> createState() =>
      _GravityButtonPainterState();
}

class _GravityButtonPainterState extends ConsumerState<GravityButtonPainter> {
  static const double _minChangeToSend = 0.05;

  double _lastSentValue = 0;

  @override
  Widget build(BuildContext context) {
    final connectionRepo = ref.watch(connectionRepositoryProvider);

    return GravityButton(
      button: widget.button,
      orientation: widget.orietation,
      callBackFreequency: const Duration(milliseconds: 5),
      onStop: () {
        connectionRepo.send(ButtonPlayerEvent(
          btn: widget.button.buttonCodes.first,
          axis: widget.orietation == .horizontal ? .horizontal : .vertical,
          value: 0,
        ));
        _lastSentValue = 0;
      },
      onUpdated: (value) {
        if ((value - _lastSentValue).abs() <= _minChangeToSend) return;

        connectionRepo.send(ButtonPlayerEvent(
          btn: widget.button.buttonCodes.first,
          axis: widget.orietation == .horizontal ? .horizontal : .vertical,
          value: value,
        ));
        _lastSentValue = value;
      },
    );
  }
}
