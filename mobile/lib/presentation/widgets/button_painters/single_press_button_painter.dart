import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:google_fonts/google_fonts.dart';

class SinglePressButtonPainter extends ConsumerWidget{
  const SinglePressButtonPainter({
    super.key,
    required this.button
  });

  final Button button;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionRepo = ref.watch(connectionRepositoryProvider);
    final buttonData = button.buttonData;


    return Material(
      color: Colors.transparent,
      clipBehavior: .hardEdge,
      elevation   : button.buttonData.elevation.toDouble(),
      shape: button.buttonData.shape == .circle
        ? CircleBorder()
        : RoundedRectangleBorder(
            borderRadius: .circular( button.buttonData.borderRadius),
          ),

      child: InkWell(
        onTapDown: (details) {
          HapticFeedback.vibrate();
          connectionRepo.send(ButtonPlayerEvent(
            btn: button.buttonCode, 
            axis: .depth, 
            value: 1
          ));
        },
        onTapCancel: () {
          connectionRepo.send(ButtonPlayerEvent(
            btn: button.buttonCode, 
            axis: .depth, 
            value: 0
          ));
        },
        onTapUp: (details) {
          connectionRepo.send(ButtonPlayerEvent(
            btn: button.buttonCode, 
            axis: .depth, 
            value: 0
          ));
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
                style: GoogleFonts.nunito(
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
}