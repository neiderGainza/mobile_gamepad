import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_controller/domain/model/button.dart';

class TactilPanel extends StatefulWidget{
  const TactilPanel({
    super.key,
    required this.button,
    required this.callBackFreequency,
    required this.onStop,
    required this.onUpdated
  });

  final Button button;
  
  final Duration callBackFreequency;
  final Function(double xv, double yv) onUpdated;
  final Function() onStop;

  @override
  State<TactilPanel> createState() => _TactilPanelState();
}


class _TactilPanelState extends State<TactilPanel> {
  Timer ? _callbackTimer;  
  
  Offset _lastPosition = .zero;
  Offset _currentPosition = .zero;
  
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.7,
      child: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) => _onPanStart(details.globalPosition),
            onPanUpdate: (details) => _onPanUpdated(details.globalPosition),
            onPanEnd: (details) => _onPanStop(),

            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: .circular(widget.button.buttonData.borderRadius),
                border: .all(
                  width: widget.button.buttonData.borderWidth,
                  color: widget.button.buttonData.borderColor
                ),
                color: widget.button.buttonData.backgroundColor.withAlpha(100)
              ),
            ),
          ),

          Positioned(
            top: 8,
            left: 12,
            child: Text('Tactil Panel (RS)', style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: widget.button.buttonData.borderColor,
            ),),
          )
        ],
      ),
    );
  }


  void _onPanStart(Offset gPosition){
    _lastPosition = gPosition;
    _runCallback();
  }

  void _onPanUpdated(Offset gPosition){
    _currentPosition = gPosition;
  }

  void _onPanStop(){
    _callbackTimer?.cancel();
    _lastPosition = .zero;
    _currentPosition = .zero;
    widget.onStop();
  }

  void _runCallback(){
    _callbackTimer?.cancel();
    _callbackTimer = Timer.periodic(
      widget.callBackFreequency,
      (_) {
        final currentPosition = _currentPosition;
        final vx = (currentPosition.dx - _lastPosition.dx)
                    / widget.callBackFreequency.inMilliseconds;
        final vy = (currentPosition.dy - _lastPosition.dy)
                    / widget.callBackFreequency.inMilliseconds;
        
        final vLimit = 2;

        widget.onUpdated(
          (vx / vLimit).clamp(-1, 1),
          (vy / vLimit).clamp(-1, 1)
        );

        _lastPosition = currentPosition;
      }, 
    );
  }

  @override
  void dispose() {
    _callbackTimer?.cancel();
    super.dispose();
  }
} 