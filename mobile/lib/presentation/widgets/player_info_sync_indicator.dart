import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/presentation/providers/connection_sync_providers.dart';

class PlayerInfoSyncIndicator extends ConsumerWidget{
  const PlayerInfoSyncIndicator({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncPlayer = ref.watch(connectionSyncPlayerProvider);

    return syncPlayer.when(
      data: (data) => switch(data){
        .none    => SizedBox.shrink(),
        .progres => CircularProgressIndicator(),
        .success => SizedBox.shrink(),
        .failed  => IconButton(
          onPressed: (){
            ref.read(connectionRepositoryProvider).syncPlayerData();
          }, 
          icon: Icon(Icons.sync, color: Theme.of(context).colorScheme.error,)
        ),
      },
      error: (e,t) => SizedBox.shrink(),
      loading: () => SizedBox.shrink()
    );
  }
}