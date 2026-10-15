// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_rotation_sensor/flutter_rotation_sensor.dart';
// import 'package:game_controller/domain/model/button.dart';

// enum Orient { vertical, horizontal }

// class GravityButton extends StatefulWidget {
//   const GravityButton({
//     super.key,
//     required this.orientation,
//     required this.button,
//     required this.callBackFreequency,
//     required this.onUpdated,
//     required this.onStop,
//   });

//   final Button button;
//   final Orient orientation;
//   final Duration callBackFreequency;

//   final Function(double value) onUpdated;
//   final Function() onStop;

//   @override
//   State<GravityButton> createState() => _GravityButtonPainterState();
// }

// class _GravityButtonPainterState extends State<GravityButton> {
//   static const double _maxTiltAngle = pi / 4;
//   late final StreamSubscription<OrientationEvent> _orientationSubscription;

//   double position = 0;
//   bool _isLocked = false;

//   @override
//   void initState() {
//     super.initState();

//     RotationSensor.samplingPeriod = SensorInterval.gameInterval;
//     RotationSensor.referenceFrame = ReferenceFrame.arbitrary;
//     _orientationSubscription = RotationSensor.orientationStream.listen(
//       (event) {
//         if (_isLocked) return;

//         final angle = widget.orientation == Orient.vertical
//             ? event.eulerAngles.pitch
//             : event.eulerAngles.roll;
//         final nextPosition = (angle / _maxTiltAngle)
//             .clamp(-1.0, 1.0)
//             .toDouble();

//         if (!mounted) return;
//         setState(() => position = nextPosition);
//         widget.onUpdated(nextPosition);
//       },
//       onError: (Object error, StackTrace stackTrace) {
//         debugPrint('No se pudo leer la orientación del teléfono: $error');
//         widget.onStop();
//       },
//       cancelOnError: true,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final btnData = widget.button.buttonData;

//     return Stack(
//       children: [
//         Center(
//           child: Transform.rotate(
//             angle: widget.orientation == Orient.horizontal ? 0 : pi / 2,
//             child: FractionallySizedBox(
//               heightFactor: 0.2,
//               child: Container(
//                 width: double.infinity,
//                 height: 16,
//                 padding: const EdgeInsets.all(3),
//                 decoration: BoxDecoration(
//                   color: btnData.backgroundColor,
//                   border: Border.all(
//                     width: btnData.borderWidth,
//                     color: btnData.borderColor,
//                   ),
//                   borderRadius: BorderRadius.circular(btnData.borderRadius),
//                 ),
//                 child: Align(
//                   alignment: Alignment(position, 0),
//                   child: FractionallySizedBox(
//                     widthFactor: 0.2,
//                     child: AspectRatio(
//                       aspectRatio: 1,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           shape: .circle,
//                           color: btnData.color,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 0,
//           right: 0,
//           child: IconButton(
//             key: const ValueKey('gravity_lock_button'),
//             tooltip: _isLocked ? 'Desbloquear posición' : 'Bloquear posición',
//             visualDensity: VisualDensity.compact,
//             constraints: const BoxConstraints.tightFor(width: 32, height: 32),
//             padding: EdgeInsets.zero,
//             onPressed: () => setState(() => _isLocked = !_isLocked),
//             icon: Icon(
//               _isLocked ? Icons.lock : Icons.lock_open,
//               size: 18,
//               color: btnData.borderColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _orientationSubscription.cancel();
//     widget.onStop();
//     super.dispose();
//   }
// }
