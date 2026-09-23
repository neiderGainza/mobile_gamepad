import 'package:flutter/material.dart';


class ArrowButtonPainter extends CustomPainter{
  final Color ? fillColor;
  final ArrowOrientation orientation;

  const ArrowButtonPainter({
    this.fillColor,
    required this.orientation
  });


  @override
  void paint(Canvas canvas, Size size) {
    final figurePaint = Paint()
      ..color = fillColor??Colors.deepOrange
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final radius = size.width / 2;
    var path   = Path();
    final center = Offset(size.width/2, size.height/2);   

    var corners = [
      Offset(-0.7, -0.3),
      Offset(0.1 , -0.3),
      Offset(0.1 , -0.7),
      Offset(0.7 ,  0.0),
      Offset(0.1 ,  0.7),
      Offset(0.1 ,  0.3),
      Offset(-0.7,  0.3),
      Offset(-0.7, -0.3),
    ].map(
      (point){
        switch (orientation){
          case .left:
            return Offset(-point.dx, point.dy);
          case .up:
            return Offset(point.dy, -point.dx);
          case .down:
            return Offset(point.dy, point.dx);
          default:
            return point;
        }

      },
    ).map(
      (point) => point.scale(radius, radius) + center
    )
    .toList();
    
    for(int index = 0; index < corners.length; index++){
      final corner = corners[index];

      if(index == 0){
        path.moveTo(corner.dx, corner.dy);
      }else{
        path.lineTo(corner.dx, corner.dy);
      }
    }

    canvas.drawPath(path, figurePaint);
  }

  @override
  bool shouldRepaint(ArrowButtonPainter oldDelegate) => 
    oldDelegate.fillColor != fillColor;
}



enum ArrowOrientation{
  down,
  right,
  left,
  up;
}