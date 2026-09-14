
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
    double groupSize = size ?? getWidgetScaleSize(context);
    final btnCount = buttonGroup.buttons.length;
    final btnSize  = getSizeFor(btnCount, groupSize);
    final builder  = btnBuilder ?? (child, btnIndex) => child;


    return SizedBox(
      width: groupSize,
      height: groupSize,

      child: Stack(
        children: [
          for (int i = 0; i < btnCount; i++)
            Align(
              alignment: AlignmentGeometry.xy(
                (btnSize/2) * cos(getRadiantFor(btnCount, i)),
                (btnSize/2) * sin(getRadiantFor(btnCount, i)),
              ),
              
              child: builder(
                ButtonPainter(
                  button : buttonGroup.buttons[i],
                  size   : btnSize,
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

  double getSizeFor(int btnCount, double maxSize, [double s = 0,]){
    final double minSep = maxSize * 0.05;
    final double maxSep = maxSize * 0.3;
    final double separation = (maxSep - minSep) * s + minSep;

    if(btnCount == 1) return maxSize;
    return (maxSize - separation)/btnCount;
  }

  double getRadiantFor(int btnCount, int btnIndex){
    if(btnCount == 0){
      return 0;
    }
    if(btnCount == 2){
      return pi*btnIndex; 
    }

    return (pi/2) + (2*pi/btnCount) * btnIndex;
  }
}
