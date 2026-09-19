import 'package:desktop/presentation/providers/connection_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      .connected => _connected(),
      .disconnected => _disconnected(),
      .connecting => _connecting(),
      .disconnecting => _disconecting(),

      _ => _connecting()
    };
  }

  Widget _connected(){
    return Row(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        if(showDot)
        BlinkingDot(color: connectedDotColor),
        if(showDot && showLabel)
        const SizedBox(width: 8,),
        if(showLabel)
        Text('Running', style: connectedStyle 
                              ?? defaultStyle?.copyWith(color: connectedDotColor))
      ],
    );
  }

  Widget _disconnected(){
    return Row(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        if(showDot)
        BlinkingDot(color: disconnectedDotColor),
        if(showDot && showLabel)
        const SizedBox(width: 8,),
        if(showLabel)
        Text('Stopped', style: disconnectedStyle 
                                 ?? defaultStyle?.copyWith(color: disconnectedDotColor))
      ],
    );
  }

  Widget _connecting(){
    return Row(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        if(showDot)
        BlinkingDot(color: connectingDotColor),
        if(showDot && showLabel)
        const SizedBox(width: 8,),
        if(showLabel)
        Text('Starting', style: connectingStyle 
                                ?? defaultStyle?.copyWith(color: connectingDotColor))
      ],
    );
  }

  Widget _disconecting(){
    return Row(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        if(showDot)
        BlinkingDot(color: connectingDotColor),
        if(showDot && showLabel)
        const SizedBox(width: 8,),
        if(showLabel)
        Text('Closing', style: connectingStyle 
                                ?? defaultStyle?.copyWith(color: connectingDotColor))
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