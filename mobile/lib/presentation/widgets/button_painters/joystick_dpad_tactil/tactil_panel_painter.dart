import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/presentation/widgets/button_painters/joystick_dpad_tactil/tactil_panel.dart';

class TactilPanelPainter extends ConsumerStatefulWidget {
  const TactilPanelPainter({super.key, required this.button});

  final Button button;

  @override
  ConsumerState<TactilPanelPainter> createState() => _TactilPanelPainterState();
}

class _TactilPanelPainterState extends ConsumerState<TactilPanelPainter> {
  static const double _minChangeToSend = 0.05;

  Offset _lastSent = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final connectionRepo = ref.watch(connectionRepositoryProvider);

    return TactilPanel(
      button: widget.button,
      callBackFreequency: const Duration(milliseconds: 5),
      onStop: () {
        connectionRepo.send(
          ButtonPlayerEvent(
            btn: widget.button.buttonCodes.first,
            axis: .vertical,
            value: 0,
          ),
        );
        connectionRepo.send(
          ButtonPlayerEvent(
            btn: widget.button.buttonCodes.first,
            axis: .horizontal,
            value: 0,
          ),
        );
        _lastSent = Offset.zero;
      },
      onUpdated: (vx, vy) {
        final buttonCode = widget.button.buttonCodes.first;

        if ((vx - _lastSent.dx).abs() > _minChangeToSend) {
          connectionRepo.send(
            ButtonPlayerEvent(btn: buttonCode, axis: .horizontal, value: vx),
          );
          _lastSent = Offset(vx, _lastSent.dy);
        }

        if ((vy - _lastSent.dy).abs() > _minChangeToSend) {
          connectionRepo.send(
            ButtonPlayerEvent(btn: buttonCode, axis: .vertical, value: vy),
          );
          _lastSent = Offset(_lastSent.dx, vy);
        }
      },
    );
  }
}
