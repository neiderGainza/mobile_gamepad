
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_controller/domain/model/button_group.dart';
import 'package:game_controller/presentation/widgets/button_painters/button_painter.dart';

class ButtonGroupPainter extends StatelessWidget {
  const ButtonGroupPainter({
    super.key, 
    required this.buttonGroup, 
    this.size,

    this.btnBuilder
  });

  final double? size;
  final ButtonGroup buttonGroup;
  
  /// A builder that allows to make things like 
  /// absortPointer from btns and change behaibor
  final Widget Function(Widget child, int btnIndex) ? btnBuilder;

  @override
  Widget build(BuildContext context) {
    double R = (size ?? getWidgetScaleSize(context))/2;
    final btnCount = buttonGroup.buttons.length;
    final r  = getrFor(btnCount, R, buttonGroup.internalMargin);
    final builder  = btnBuilder ?? (child, btnIndex) => child;
    final rotation = (buttonGroup.rotationDegreess ?? 0).toDouble();

    return SizedBox(
      width: 2 * R,
      height: 2 * R,
      
      child: Stack(
        children: [
          for (int i = 0; i < btnCount; i++)
            Positioned(
              left  : getXFor(btnCount, R, r, i, rotation) - r,
              bottom: getYFor(btnCount, R, r, i, rotation) - r,
    
              child: builder( 
                ButtonPainter(
                  button : buttonGroup.buttons[i],
                  size   : 2 * r,
                  margin : buttonGroup.internalMargin,
                ),
                i 
              )
            ),
        ],
      ),
    );
  }

  double getWidgetScaleSize(BuildContext context) {
    final l = MediaQuery.of(context).size.longestSide;
    final a = MediaQuery.of(context).size.shortestSide;

    final displaySize = sqrt(a*a + l*l);
    return displaySize * buttonGroup.screenRelativeSize;
  }

  double getrFor(int btnCount, double R, [double s = 0]){
    final minMargin = 0.00;
    final maxMargin = 0.3;
    final margin    = s * (maxMargin - minMargin) + minMargin; 
    
    if(btnCount == 1) return (1 - margin) * R;
    if(btnCount == 2) return (1 - margin) * R * 0.5  ;
    if(btnCount == 3) return (1 - margin) * R * 0.47 ;
    if(btnCount == 4) return (1 - margin) * R * 0.45 ;
    
    throw UnimplementedError();
  }

  double getRadiantFor(int btnCount, int btnIndex, double rotation){
    if(btnCount == 1){
      return 0;
    }
    if(btnCount == 2){
      return pi*btnIndex + (pi * rotation/180); 
    }
    
    return (pi/2) - (2*pi/btnCount) * btnIndex + (pi * rotation/180) ;
  }

  double getXFor(int btnCount, double R, double r, int i , double rotation){
    if(btnCount == 1) return R;
    
    final cosVal  = cos(getRadiantFor(btnCount, i, rotation));
    // final cosSign = cosVal.sign < 0 ? -1 : 1;
    
    return R + (R - r)* cosVal;
  }

  double getYFor(int btnCount, double R, double r, int i, double rotation){
    if(btnCount == 1) return R;
    
    final sinVal  = sin(getRadiantFor(btnCount, i, rotation));
    // final sinSign = sinVal.sign < 0 ? -1 : 1;
    
    return R + (R - r) * sinVal;
  }

}
