import 'package:desktop/presentation/providers/players_state_provider.dart';
import 'package:desktop/presentation/screens/home/widgets/connection_header.dart';
import 'package:desktop/presentation/widgets/title_bar_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget{
  const HomeView({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersState = ref.watch(playersStateProvider).value;
    
    return TitleBarFrame(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: ConnectionHeader()),
          
          if(playersState != null)
          if(playersState.isNotEmpty)
            SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 8,),
              itemCount: playersState.length,
              itemBuilder: (context, index){
                final playerState = playersState[index];
      
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(12)
                    ),
                    tileColor: Theme.of(context).colorScheme.surfaceContainer,
                    title : Text(playerState.player.name),
                    subtitle: Text(playerState.player.deviceName),
                    trailing: Text(playerState.connectionStatus.name),
                  ),
                );
              }
            )
          
          
        ],
      ),
    );
  }
}