import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:game_controller/domain/model/button.dart';

class TactilPanel extends StatefulWidget{
  const TactilPanel({
    super.key,
    required this.button,
    required this.callBackFreequency,
    required this.onStop,
    required this.onUpdated
  });

  final Button button;
  
  final Duration callBackFreequency;
  final Function(double xv, double yv) onUpdated;
  final Function() onStop;

  @override
  State<TactilPanel> createState() => _TactilPanelState();
}

class _TactilPanelState extends State<TactilPanel> {
  static const double _beta = 0.8;
  late final double _decayVelocity;
  late final double _stdFactor;

  Timer ? _callbackTimer;  
  
  Offset _lastPosition = .zero;
  Offset _currentPosition = .zero;
  Offset _momentum1 = .zero;
  
  double _steps = 0;


  @override
  void initState() {
    _decayVelocity = widget.callBackFreequency.inMilliseconds / 2000;
    _stdFactor     = 1 / (widget.callBackFreequency.inMilliseconds * 8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor : 1,
      heightFactor: 1,
      child: Stack(
        children: [
          GestureDetector(
            onPanStart : (details) => _onPanStart(details.globalPosition),
            onPanUpdate: (details) => _onPanUpdated(details.globalPosition),
            onPanEnd   : (details) => _onPanStop(),

            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: .circular(widget.button.buttonData.borderRadius),
                border: .all(
                  width: widget.button.buttonData.borderWidth,
                  color: widget.button.buttonData.borderColor
                ),
                color: widget.button.buttonData.backgroundColor.withAlpha(100)
              ),
            ),
          ),

          Positioned(
            top: 8,
            left: 12,
            child: Text(AppLocalizations.of(context)!.tactilePanel, style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: widget.button.buttonData.borderColor,
            ),),
          )
        ],
      ),
    );
  }


  void _onPanStart(Offset gPosition){
    _lastPosition = gPosition;
    _currentPosition = gPosition;
    _steps = 0;
    _runCallback();
  }

  void _onPanUpdated(Offset gPosition){
    _currentPosition = gPosition;
  }

  void _onPanStop(){
    _callbackTimer?.cancel();
    _lastPosition = .zero;
    _currentPosition = .zero;
    _momentum1 = .zero;
    _steps = 0;
    widget.onStop();
  }

  void _runCallback(){
    _callbackTimer?.cancel();
    _callbackTimer = Timer.periodic(
      widget.callBackFreequency,
      (_) {
        final director  = _currentPosition - _lastPosition;  
        
        /// no tenemos un maximo de velocidad existente en el movimiento de un 
        /// dedo , asi q utilizaremos este factor experimental para 
        /// estandarizar los valores de movimiento
        final stdDirector = Offset(
          (director.dx * _stdFactor).clamp(-1, 1),
          (director.dy * _stdFactor).clamp(-1, 1),
        );
        
        if(_momentum1 != .zero){
          _momentum1 = _momentum1 * _beta  + stdDirector * (1 - _beta);
        }else{
          _momentum1 = stdDirector;
        }
        
        if(_momentum1.distance > 0.05){  
          widget.onUpdated( _momentum1.dx, _momentum1.dy);
        }

        _lastPosition += Offset.fromDirection(
          director.direction,  
          director.distance * _decayVelocity  
        );
      }, 
    );
  }

  @override
  void dispose() {
    _callbackTimer?.cancel();
    super.dispose();
  }
}
