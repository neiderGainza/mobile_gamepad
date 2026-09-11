import 'package:flutter/material.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:google_fonts/google_fonts.dart';

class SinglePressButtonPainter extends StatelessWidget{
  const SinglePressButtonPainter({
    super.key,
    required this.button
  });

  final Button button;

  @override
  Widget build(BuildContext context) {
    final buttonData = button.buttonData;
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        
      },
      onTapCancel: () {
        
      },
      onLongPressStart: (details) {
        
      },
      onLongPressEnd: (details){

      },
      onLongPressCancel: (){
        
      },
      child: Container(
        decoration: BoxDecoration(
          shape: buttonData.shape,
          color: buttonData.backgroundColor ?? cs.primary,   
          borderRadius: buttonData.borderRadius == null 
            ? null
            : .circular(buttonData.borderRadius!.toDouble()) 
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
                color: buttonData.color ?? cs.onPrimary
              ) ,
              textAlign: .center,
            )
          ),
        ),
      ),
    );
  }
}