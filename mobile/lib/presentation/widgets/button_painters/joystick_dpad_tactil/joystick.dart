import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


/// Copy of JoystickWidget from [flutter_joystick_customisable] 
/// to change some paramenters not allowed from the interface
/// 
class Joystick extends StatefulWidget {
  final double size;
  final Duration timeFrequency;

  final Function? onDragStart;
  final Function? onDragEnd;
  final Function(DragInfo dragInfo) onDragUpdated;

  /// Specifies the button color
  final Color  stickColor;
  final Color  fontColor;
  final Color  borderColor;
  final double borderWidth;
  final String label;

  const Joystick(
      {super.key,
      required this.onDragUpdated,
      required this.size,
      this.onDragStart,
      this.onDragEnd,
      this.borderColor = Colors.purple,    
      this.timeFrequency = const Duration(milliseconds: 10),
      
      /// Size of the stick/ball is by default 100 pixel.
      required this.stickColor,
      required this.fontColor,
      required this.label,
      this.borderWidth = 2
      });

  @override
  State<Joystick> createState() => _JoystickState();
}


class _JoystickState extends State<Joystick> {
  final GlobalKey _baseKey = GlobalKey();
  
  Timer? _callbackTimer;
  /// between -1 a 1 
  Offset _stickOffset    = Offset.zero;
  /// global position
  Offset _updateCenterPosition = Offset.zero;
  /// first touch center
  Offset _firstCenterPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {

    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: _updateCenterPosition, end: _updateCenterPosition),
      duration: Duration(milliseconds: 0),

      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset,
          child: child
        );
      },

      child: GestureDetector(
        onPanStart:  (details) => _stickDragStart(details.globalPosition),
        onPanUpdate: (details) => _stickDragUpdate(details.globalPosition),
        onPanEnd:    (details) => _stickDragEnd(),
                
        child: Stack(
          alignment: Alignment.center, 
          children: [
            Container(
              key: _baseKey,
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: .circle,
                border: Border.all(color: widget.borderColor, width: widget.borderWidth)
              ),
            ),
        
            Align(
              alignment: Alignment(_stickOffset.dx, _stickOffset.dy), 
              child: FractionallySizedBox(
                widthFactor: 0.4,
                heightFactor: 0.4,
                child: StickBall(
                  color: widget.stickColor,
                  label: widget.label,
                  fontColor: widget.fontColor,
                ),
              ),
            )
          
          ]
        ),
      ),
    );
  }

  void _stickDragStart(Offset globalPosition) {
    HapticFeedback.vibrate();
    _runCallback();
    _firstCenterPosition  = _getCenter();
    _updateCenterPosition = globalPosition - _firstCenterPosition;
    widget.onDragStart?.call();
    setState(() {});
  }


  void _stickDragUpdate(Offset globalPosition) {
    final baseRenderBox =
        _baseKey.currentContext!.findRenderObject()! as RenderBox;

    final boxRadius   = baseRenderBox.size.width / 2;
    final touchV      = globalPosition - (
      _firstCenterPosition + _updateCenterPosition
    ); 
    
    // si el toque esta fuera de la caja mueve la caja
    if(touchV.distance > boxRadius){
      final outBox = Offset.fromDirection(
        touchV.direction,
        touchV.distance - boxRadius
      );

      _updateCenterPosition += outBox;
    }

    final touchVFromCurrentCenter = globalPosition - _getCenter();
    final stickV = Offset.fromDirection(
      touchVFromCurrentCenter.direction, 
      (touchVFromCurrentCenter.distance / boxRadius).clamp(0, 1)
    ); 

    setState(() {
      _stickOffset  = stickV;  
    });
  }

  void _stickDragEnd() {
    setState(() {
      _stickOffset = Offset.zero;
      _updateCenterPosition = Offset.zero;
    });

    _callbackTimer?.cancel();
    widget.onDragUpdated(DragInfo(_stickOffset.dx, _stickOffset.dy));
    widget.onDragEnd?.call();
  }

  void _runCallback() {
    _callbackTimer = Timer.periodic(widget.timeFrequency, (timer) {
      widget.onDragUpdated(DragInfo(_stickOffset.dx, _stickOffset.dy));
    });
  }

  Offset _getCenter(){
    final baseRenderBox =
      _baseKey.currentContext!.findRenderObject()! as RenderBox;
   
    return baseRenderBox.localToGlobal(baseRenderBox.paintBounds.center);
  }

  @override
  void dispose() {
    _callbackTimer?.cancel();
    super.dispose();
  }
}



/// Draggable ball of the Joystick
class StickBall extends StatelessWidget {
  final Color color;
  final String label;
  final Color fontColor;

  const StickBall({
    required this.color,
    required this.label,
    required this.fontColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            spreadRadius: 6,
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
        color: color
      ),
      child: FractionallySizedBox(
        widthFactor: 0.3,
        heightFactor: 0.4,
        child: FittedBox(
          fit: .fill,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: .bold,
              color: fontColor
            ) ,
            textAlign: .center,
          )
        ),
      ),
    );
  }
}


class DragInfo{
  final double x , y;
  const DragInfo(this.x , this.y);
}