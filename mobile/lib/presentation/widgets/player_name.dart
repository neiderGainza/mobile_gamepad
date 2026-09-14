import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/providers/player_provider.dart';

class PlayerName extends ConsumerWidget{
  const PlayerName({
    super.key,
    this.style
  });

  final TextStyle ? style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player     = ref.watch(playerProvider);
    
    return Text(
      player.value?.name ?? '',
      style: style,
    );
  }
}