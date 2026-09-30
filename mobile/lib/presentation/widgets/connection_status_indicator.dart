import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:game_controller/presentation/providers/connection_status_provider.dart';

class ConnectionStatusIndicator extends ConsumerWidget{
  const ConnectionStatusIndicator({
    super.key,
    this.defaultStyle,
    this.connectedStyle,
    this.connectingStyle,
    this.disconnectedStyle,

    this.connectedDotColor = Colors.green,
    this.disconnectedDotColor = Colors.red,
    this.connectingDotColor = Colors.orange,

    this.showLabel = true,
    this.showDot = true
  });

  final TextStyle ? defaultStyle;
  final TextStyle ? connectedStyle;
  final TextStyle ? disconnectedStyle;
  final TextStyle ? connectingStyle;
  
  final Color connectedDotColor;
  final Color disconnectedDotColor;
  final Color connectingDotColor;

  final bool showLabel;
  final bool showDot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionStatus = ref.watch(connectionStatusProvider);
    
    return switch(connectionStatus.value){
      .connected => _connected(context),
      .disconnected => _disconnected(context),
      .connecting => _connecting(context),

      _ => _connecting(context)
    };
  }

  Widget _connected(BuildContext context){
    return Row(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        if(showDot)
        BlinkingDot(color: connectedDotColor),
        if(showDot && showLabel)
        const SizedBox(width: 8,),
        if(showLabel)
        Text(AppLocalizations.of(context)!.connected, style: connectedStyle ?? defaultStyle)
      ],
    );
  }

  Widget _disconnected(BuildContext context){
    return Row(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        if(showDot)
        BlinkingDot(color: disconnectedDotColor),
        if(showDot && showLabel)
        const SizedBox(width: 8,),
        if(showLabel)
        Text(AppLocalizations.of(context)!.disconnected, style: disconnectedStyle ?? defaultStyle)
      ],
    );
  }

  Widget _connecting(BuildContext context){
    return Row(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        if(showDot)
        BlinkingDot(color: connectingDotColor),
        if(showDot && showLabel)
        const SizedBox(width: 8,),
        if(showLabel)
        Text(AppLocalizations.of(context)!.connecting, style: connectingStyle ?? defaultStyle)
      ],
    );
  }

  
}


class BlinkingDot extends StatelessWidget{
  const BlinkingDot({
    super.key,
    required this.color
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: .circle,
        color: color
      ),
      width: 16,
      height: 16,
    ).animate(
      onPlay: (controller) => controller.repeat(reverse: true),
    )
    .fade(
      duration: 800.ms,      
      begin: 1.0,            
      end: 0.2,              
      curve: Curves.easeInOut, 
    );
  }
}