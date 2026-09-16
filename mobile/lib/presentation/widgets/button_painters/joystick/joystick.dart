import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_joystick_customisable/flutter_joystick_customisable.dart';
import 'package:google_fonts/google_fonts.dart';


/// Copy of JoystickWidget from [flutter_joystick_customisable] 
/// to change some paramenters not allowed from the interface
/// 
class Joystick extends StatefulWidget {
  /// Size of the stick/ball to occupy the screen with the rest of the controls
  final double stickSize;

  /// Frequency of calling [dragCallback] from the moment the stick is dragged.
  final Duration timeFrequency;

  /// Widget that renders joystick base, by default [DragPad] will take care of this part and the size of this widget will be varied based on the stick/ball size.
  final Widget? draggableContainer;

  /// Specifies the color of the [DragPad].
  final Color dragPadColor;

  /// Controller allows to control joystick events outside the widget.
  final StickController? stickController;

  /// Callback, which is called when the stick starts dragging.
  final Function? onDragStart;

  /// Callback, which is called when the stick released.
  final Function? onDragEnd;

  /// Callback, which is called with [timeFrequency] when the stick is dragged.
  final StickDragCallback dragCallback;

  /// Enable the button controls at out side of the drag pad
  final bool enableButtonControls;

  /// Specifies the button color
  final Color stickColor;
  final Color fontColor;
  final Color borderColor;

  final String label;

  const Joystick(
      {super.key,
      this.draggableContainer,
      required this.dragCallback,
      this.stickController,
      this.onDragStart,
      this.onDragEnd,
      this.dragPadColor = Colors.purple,
      this.borderColor = Colors.purple,    
      this.timeFrequency = const Duration(milliseconds: 10),

      /// Size of the stick/ball is by default 100 pixel.
      this.stickSize = 100,
      this.enableButtonControls = false,
      required this.stickColor,
      required this.fontColor,
      required this.label
      });

  @override
  State<Joystick> createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  final GlobalKey _baseKey = GlobalKey();

  Offset _stickOffset = Offset.zero;
  Timer? _callbackTimer;
  Offset _startDragStickPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    widget.stickController?.onStickDragStart =
        (globalPosition) => _stickDragStart(globalPosition);
    widget.stickController?.onStickDragUpdate =
        (globalPosition) => _stickDragUpdate(globalPosition);
    widget.stickController?.onStickDragEnd = () => _stickDragEnd();
  }

  @override
  Widget build(BuildContext context) {
    var draggableContainerSize = widget.stickSize * 2.5;
    var borderContainerSize    = draggableContainerSize * 1.03;

    return GestureDetector(
      onPanStart: (details) => _stickDragStart(details.globalPosition),
      onPanUpdate: (details) => _stickDragUpdate(details.globalPosition),
      onPanEnd: (details) => _stickDragEnd(),
              
      child: Stack(
        alignment: Alignment.center, 
        children: [
          IgnorePointer(
            child: Container(
              width: borderContainerSize,
              height: borderContainerSize,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(draggableContainerSize / 2),
                  border: Border.all(color: widget.borderColor, width: 4)),
          )),
      
        Stack(
          alignment: Alignment(_stickOffset.dx, _stickOffset.dy), 
          children: [
          Container(
            key: _baseKey,
            child: widget.draggableContainer ??
                DragPad(size: draggableContainerSize, color: widget.dragPadColor),
          ),
          GestureDetector(
              child: StickBall(
                size: widget.stickSize,
                color: widget.stickColor,
                label: widget.label,
                fontColor: widget.fontColor,
              )),
        ])
      ]),
    );
  }

  void _stickDragStart(Offset globalPosition) {
    _runCallback();
    _startDragStickPosition = globalPosition;
    widget.onDragStart?.call();
  }

  void _stickDragUpdate(Offset globalPosition) {
    final baseRenderBox =
        _baseKey.currentContext!.findRenderObject()! as RenderBox;

    final stickOffset = StickOffsetHandler.calculate(
      startDragStickPosition: _startDragStickPosition,
      currentDragStickPosition: globalPosition,
      baseSize: baseRenderBox.size,
    );

    setState(() {
      _stickOffset = stickOffset;
    });
  }

  void _stickDragEnd() {
    setState(() {
      _stickOffset = Offset.zero;
    });

    _callbackTimer?.cancel();
    //send zero offset when the stick is released
    widget.dragCallback(DragInfo(_stickOffset.dx, _stickOffset.dy));
    _startDragStickPosition = Offset.zero;
    widget.onDragEnd?.call();
  }

  void _runCallback() {
    _callbackTimer = Timer.periodic(widget.timeFrequency, (timer) {
      widget.dragCallback(DragInfo(_stickOffset.dx, _stickOffset.dy));
    });
  }

  @override
  void dispose() {
    _callbackTimer?.cancel();
    super.dispose();
  }
}




class StickOffsetHandler {
  const StickOffsetHandler();

  static Offset calculate({
    required Offset startDragStickPosition,
    required Offset currentDragStickPosition,
    required Size baseSize,
  }) {
    double x = currentDragStickPosition.dx - startDragStickPosition.dx;
    double y = currentDragStickPosition.dy - startDragStickPosition.dy;
    final radius = baseSize.width / 2;

    final isPointInCircle = x * x + y * y < radius * radius;

    if (!isPointInCircle) {
      final multiply = sqrt(radius * radius / (y * y + x * x));
      x *= multiply;
      y *= multiply;
    }

    final xOffset = x / radius;
    final yOffset = y / radius;

    return Offset(xOffset, yOffset);
  }
}



/// Draggable ball of the Joystick
class StickBall extends StatelessWidget {
  final double size;
  final Color color;
  final String label;
  final Color fontColor;

  const StickBall({
    required this.size,
    required this.color,
    required this.label,
    required this.fontColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
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
            style: GoogleFonts.nunito(
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