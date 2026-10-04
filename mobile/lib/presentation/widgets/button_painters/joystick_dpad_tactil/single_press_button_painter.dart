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
  // Timer  ? releaseTimer;

  @override
  Widget build(BuildContext context) {
    final buttonData = widget.button.buttonData;

    return Material(
      color: Colors.transparent,
      clipBehavior: .hardEdge,
      elevation   : widget.button.buttonData.elevation.toDouble(),
      shape: widget.button.buttonData.shape != .rectangle
        ? CircleBorder()
        : RoundedRectangleBorder(
            borderRadius: .circular( widget.button.buttonData.borderRadius),
          ),

      child: InkWell(
        onTapDown: (_) => send(),

        onTapCancel: () {
          release();
        },
        onTapUp: (details) {
          release();
        },
        child: Container(
          margin: .all(8),
          decoration: BoxDecoration(
            shape: buttonData.shape ?? .circle,
            color: buttonData.backgroundColor,   
            borderRadius: buttonData.shape != .rectangle 
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
              fit: .contain,
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
    if(widget.button.buttonCodes.length == 1){
      connectionRepo.send(ButtonPlayerEvent(
          btn: widget.button.buttonCodes.first, 
          axis: .depth, 
          value: 0
      ));
      return;
    }
    
    connectionRepo.send(MultiButtonPlayerEvent(
      buttonPlayerEvents: [
        for(final code in widget.button.buttonCodes)
        ButtonPlayerEvent(
          btn: code, 
          axis: .depth, 
          value: 0
        )
      ]
    ));
  }

  void send(){
    HapticFeedback.vibrate();

    if(widget.button.buttonCodes.length == 1){
      ref.read(connectionRepositoryProvider).send(ButtonPlayerEvent(
        btn: widget.button.buttonCodes.first, 
        axis: .depth, 
        value: 1
      ));
      return;
    }

    ref.read(connectionRepositoryProvider).send(MultiButtonPlayerEvent(
      buttonPlayerEvents: [
        for(final code in widget.button.buttonCodes)
        ButtonPlayerEvent(
          btn: code, 
          axis: .depth, 
          value: 1
        )
      ]
    ));
  }
}