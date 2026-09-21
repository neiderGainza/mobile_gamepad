import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/domain/model/button.dart';


class SinglePressButtonPainter extends ConsumerStatefulWidget{
  const SinglePressButtonPainter({
    super.key,
    required this.button
  });

  final Button button;

  @override
  ConsumerState<SinglePressButtonPainter> createState() => _SinglePressButtonPainterState();
}

class _SinglePressButtonPainterState extends ConsumerState<SinglePressButtonPainter> {
  Timer ? releaseTimer;

  @override
  Widget build(BuildContext context) {
    final connectionRepo = ref.watch(connectionRepositoryProvider);
    final buttonData = widget.button.buttonData;

    return Material(
      color: Colors.transparent,
      clipBehavior: .hardEdge,
      elevation   : widget.button.buttonData.elevation.toDouble(),
      shape: widget.button.buttonData.shape == .circle
        ? CircleBorder()
        : RoundedRectangleBorder(
            borderRadius: .circular( widget.button.buttonData.borderRadius),
          ),

      child: InkWell(
        onTapDown: (details) {
          releaseTimer?.cancel();
          releaseTimer = null;

          HapticFeedback.vibrate();
          connectionRepo.send(ButtonPlayerEvent(
            btn: widget.button.buttonCode, 
            axis: .depth, 
            value: 1
          ));
        },
        onTapCancel: () {
          releaseTimer?.cancel();
          releaseTimer = Timer(Duration(milliseconds: 10), release);
        },
        onTapUp: (details) {
          releaseTimer?.cancel();
          releaseTimer = Timer(Duration(milliseconds: 10), release);
        },
        child: Container(
          margin: .all(8),
          decoration: BoxDecoration(
            shape: buttonData.shape,
            color: buttonData.backgroundColor,   
            borderRadius: buttonData.shape == .circle 
              ? null 
              : .circular(buttonData.borderRadius),
            border: .all(
              width: buttonData.borderWidth,
              color: buttonData.borderColor
            )
          ),
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.7,
            child: FittedBox(
              fit: .fill,
              child: Text(
                buttonData.label,
                style: TextStyle(
                  fontWeight: .bold,
                  color: buttonData.color,
                ) ,
                textAlign: .center,
              )
            ),
          ),
        ),
      ),
    );
  }

  void release(){
    final connectionRepo = ref.watch(connectionRepositoryProvider);
    
    connectionRepo.send(ButtonPlayerEvent(
      btn: widget.button.buttonCode, 
      axis: .depth, 
      value: 0
    ));
  }
}