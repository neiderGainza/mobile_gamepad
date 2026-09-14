import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/providers/connection_ping_provider.dart';

class PingIndicator extends ConsumerWidget{
  const PingIndicator({
    super.key,
    this.style
  });

  final TextStyle ? style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ping = ref.watch(connectionPingProvider);
        
    return ping.value == null
      ? SizedBox.shrink()
      : Text(
        'Ping: ${ping.value?.inMilliseconds} ms',
        style: style,
      );
  }
}