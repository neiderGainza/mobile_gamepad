
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

    return SizedBox(
      width: 2 * R,
      height: 2 * R,
      
      child: Stack(
        children: [
          for (int i = 0; i < btnCount; i++)
            Positioned(
              left  : getXFor(btnCount, R, r, i) - r,
              bottom: getYFor(btnCount, R, r, i) - r,

              child: builder(
                ButtonPainter(
                  button : buttonGroup.buttons[i],
                  size   : 2 * r,
                ),
                i 
              )
            ),
        ],
      ),
    );
  }

  double getWidgetScaleSize(BuildContext context) {
    final displaySize = MediaQuery.of(context).size.shortestSide;
    return displaySize * buttonGroup.screenRelativeSize;
  }

  double getrFor(int btnCount, double R, [double s = 0,]){
    final minMargin = 0.05;
    final maxMargin = 0.3;
    final margin    = s * (maxMargin - minMargin) + minMargin; 
    
    if(btnCount == 1) return (1 - margin) * R;
    if(btnCount == 2) return (1 - margin) * R * 0.5  ;
    if(btnCount == 3) return (1 - margin) * R * 0.47 ;
    if(btnCount == 4) return (1 - margin) * R * 0.45 ;
    
    throw UnimplementedError();
  }

  double getRadiantFor(int btnCount, int btnIndex){
    if(btnCount == 1){
      return 0;
    }
    if(btnCount == 2){
      return pi*btnIndex; 
    }
    
    return (pi/2) - (2*pi/btnCount) * btnIndex;
  }

  double getXFor(int btnCount, double R, double r, int i){
    if(btnCount == 1) return R;
    
    final cosVal  = cos(getRadiantFor(btnCount, i));
    // final cosSign = cosVal.sign < 0 ? -1 : 1;
    
    return R + (R - r)* cosVal;
  }

  double getYFor(int btnCount, double R, double r, int i){
    if(btnCount == 1) return R;
    
    final sinVal  = sin(getRadiantFor(btnCount, i));
    // final sinSign = sinVal.sign < 0 ? -1 : 1;
    
    return R + (R - r) * sinVal;
  }

}
