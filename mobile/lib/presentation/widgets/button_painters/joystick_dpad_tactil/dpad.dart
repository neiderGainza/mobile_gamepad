import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/presentation/widgets/button_painters/custom_button_painters/arrow_button_painter.dart';


class Dpad extends StatefulWidget{
  const Dpad({
    super.key,
    required this.button,
    required this.margin,
    required this.onPress
  });

  final Button button;
  final double margin;
  final Function(List<bool> pressed) onPress;

  @override
  State<Dpad> createState() => _DpadPainterState();
}

class _DpadPainterState extends State<Dpad> {
  final GlobalKey _baseKey = GlobalKey();
  
  // -1 a 1 
  Offset _actualPress          = .zero;
  // global position
  Offset _updateCenterPosition = .zero;
  // global position
  Offset _firstCenterPosition  = .zero;

  // lista the arrows presionadas , up, right, down, left
  final List<bool> _pressArrows = [false,false,false,false];

  @override
  Widget build(BuildContext context) {
    widget.onPress(_pressArrows);
    
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: _updateCenterPosition, end: _updateCenterPosition),
      duration: Duration.zero,

      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset,
          child: child
        );
      },

      child: GestureDetector(
        onPanStart: (details)  => onPressStart(details.globalPosition),
        onPanUpdate: (details) => onPressUpdated(details.globalPosition),
        onPanEnd: (details) => onPressEnded(),

        child: Background(
          key: _baseKey,
          button: widget.button,
          child: Stack(
            children: [
              Arrow(
                button: widget.button, 
                orientation: .up, 
                margin: widget.margin,
                isActive: _pressArrows[2],
              ),
              Arrow(
                button: widget.button, 
                orientation: .right,
                margin: widget.margin,
                  isActive: _pressArrows[1],
              ),
              Arrow(
                button: widget.button, 
                orientation: .down, 
                margin: widget.margin,
                isActive: _pressArrows[0],
              ),
              Arrow(
                button: widget.button, 
                orientation: .left, 
                margin: widget.margin,
                isActive: _pressArrows[3],
              ),
            ],
          ),
        ),
      )
    ); 
  }

  void onPressStart(Offset gPosition){
    _firstCenterPosition  = _getCenter();
    _updateCenterPosition = .zero;
    _tabOnGlobalPosition(gPosition);
    setState(() {});
  }

  void onPressEnded(){
    _firstCenterPosition = .zero;
    _updateCenterPosition = .zero;
    _tabOnGlobalPosition(.zero);
    setState(() {});
  }

  void onPressUpdated(Offset gPosition){
    final baseRenderBox =
      _baseKey.currentContext!.findRenderObject()! as RenderBox;
    
    final boxRadius   = baseRenderBox.size.width / 2;
    final touchV      = gPosition - (
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

    _tabOnGlobalPosition(gPosition);
    setState(() {});
  }

  /// caculate the actualPress
  /// determinates the pressed arrows
  /// does not setState (you must) to apply changes
  void _tabOnGlobalPosition(Offset gPosition){
    final baseRenderBox =
      _baseKey.currentContext!.findRenderObject()! as RenderBox;
    
    final boxRadius = baseRenderBox.size.width;
    final touchV    = gPosition - ( _firstCenterPosition + _updateCenterPosition);
    
    _actualPress = Offset.fromDirection( 
      touchV.direction, 
      (touchV.distance / boxRadius).clamp(0, 1)
    );

    /// actualizar teclas presionadas
    final sensivility = 0.2;
    if(_actualPress.dy > sensivility){
      if(!_pressArrows[0]) HapticFeedback.vibrate();
      _pressArrows[0] = true;
    }else{ _pressArrows[0] = false; }
    
    if(_actualPress.dy < -sensivility){
      if(!_pressArrows[2]) HapticFeedback.vibrate();
      _pressArrows[2] = true;
    }else{ _pressArrows[2] = false; }
    
    if(_actualPress.dx > sensivility){
      if(!_pressArrows[1]) HapticFeedback.vibrate();
      _pressArrows[1] = true;
    }else{ _pressArrows[1] = false; }
    
    if(_actualPress.dx < -sensivility){
      if(!_pressArrows[3]) HapticFeedback.vibrate();
      _pressArrows[3] = true;
    }else{ _pressArrows[3] = false; }
  }


  Offset _getCenter(){
    final baseRenderBox =
      _baseKey.currentContext!.findRenderObject()! as RenderBox;
   
    return baseRenderBox.localToGlobal(baseRenderBox.paintBounds.center);
  }

}

class Background extends StatelessWidget {
  const Background({
    super.key,
    required this.button,
    required this.child
  });

  final Button button;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: .circular(50),
        border: .all(
          color: button.buttonData.borderColor,
          width: 2 * button.buttonData.borderWidth,
        ),
    
      ),
      child: child,
    );
  }
}


class Arrow extends StatelessWidget{
  const Arrow({
    super.key,
    required this.button,
    required this.orientation,
    required this.margin,
    required this.isActive
  });

  final double margin;
  final Button button;
  final ArrowOrientation orientation;
  final bool isActive;


  @override
  Widget build(BuildContext context) {
    final btnData = button.buttonData;
    const f = 20;

    return Align(
      alignment: _getAligment(orientation),
      child: FractionallySizedBox(
        widthFactor: 0.38,
        heightFactor: 0.38,
        child: Container(
          margin: switch(orientation){
            .up   => .fromLTRB(f * margin, 0       , f*margin, f*margin),
            .down => .fromLTRB(f * margin, f*margin, f*margin, 0       ),
            .left => .fromLTRB(0         , f*margin, f*margin, f*margin),
            .right=> .fromLTRB(f * margin, f*margin, 0       , f*margin),
          },
          decoration: BoxDecoration(
            color: isActive 
              ? btnData.backgroundColor.withRed(200)
              : btnData.backgroundColor,
            shape: btnData.shape ?? .circle,
            borderRadius: btnData.shape != .rectangle 
              ? null
              : .circular(btnData.borderRadius),
            border: .all(
              color: btnData.borderColor,
              width: btnData.borderWidth
            ),
          ),
          child: CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: ArrowButtonPainter(
              orientation: orientation,
              fillColor: btnData.color
            ),
          ),
        ),
      )
    );
  }

  Alignment _getAligment(ArrowOrientation orientation){
    return switch(orientation){
      .down => .bottomCenter,
      .up => .topCenter,
      .left => .centerLeft,
      .right => .centerRight
    };
  }
}