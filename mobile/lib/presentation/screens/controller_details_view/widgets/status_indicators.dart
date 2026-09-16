import 'package:flutter/material.dart';
import 'package:game_controller/presentation/widgets/connection_status_indicator.dart';
import 'package:game_controller/presentation/widgets/ping_indicator.dart';

class StatusIndicators extends StatelessWidget{
  const StatusIndicators({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const .fromLTRB(0, 0, 8, 0),
      constraints: BoxConstraints(
        minHeight: 56,
        minWidth: 60
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: .circular(20)
        ),
        color: Theme.of(context).colorScheme.primaryContainer
      ),

      child: SafeArea(
        left: false,
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          children: [
            const SizedBox(width: 20,),
            ConnectionStatusIndicator( showLabel: false,),
            const SizedBox(width: 8,),
            PingIndicator(),
            const SizedBox(width: 8,),
          ],
        ),
      ),
    );
  }
}