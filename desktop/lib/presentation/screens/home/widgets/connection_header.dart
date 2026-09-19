import 'package:desktop/data/repository/connection_repository.dart';
import 'package:desktop/presentation/providers/connection_status_provider.dart';
import 'package:desktop/presentation/screens/home/widgets/address_list.dart';
import 'package:desktop/presentation/widgets/connection_status_indicator.dart';
import 'package:desktop/presentation/widgets/qr_address_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ConnectionHeader extends ConsumerWidget {
  const ConnectionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) { 
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    
    return Container(
      padding: .all(8),
      height : 220,
      margin : .all(8),
      decoration: BoxDecoration(
        borderRadius: .circular(12),
        border: Border.all( width: 2, color: cs.secondary ),
        color: cs.surfaceContainer
      ),

      child: Row(
        crossAxisAlignment: .start,
        children: [      
          Expanded(
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: [
                ConnectionStatusIndicator( defaultStyle: tt.headlineMedium),
                Expanded(child: AddressList()),
                const ActionTile()
              ],
            )
          ),

          const QrAddressIndicator(),
        ],
      ),
    );
  }

}



class ActionTile extends ConsumerWidget {
  const ActionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionStatus = ref.watch(connectionStatusProvider);

    return connectionStatus.when(
      data: (status){
        return switch(status){
          .connected => Row(children: [ Expanded(child: DisconnectionBtn())],),
          .connecting => const Center(child: CircularProgressIndicator(),), 
          .disconnected => Row(children: [ Expanded(child: ConnectBtn())],),
          .disconnecting => const Center(child: CircularProgressIndicator(),)
        };
      }, 
      error: (e, t) => const SizedBox.shrink(), 
      loading: ()   => const Center(child: CircularProgressIndicator(),)
    );
  }
}


class DisconnectionBtn extends ConsumerWidget {
  const DisconnectionBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed : () async {
              ref.read(connectionRepositoryProvider).stopServer();
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: .circular(8),
                
              ),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer
            ),
            child : Text(
              "Stop server" ,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer
              ),  
            ) 
          ),
        ),
        // const SizedBox(width: 8,),
      ],
    );
  }
}


class ConnectBtn extends ConsumerWidget {
  const ConnectBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed : () async {
              ref.read(connectionRepositoryProvider).connect();
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: .circular(8),
                
              )
            ),
            child : Text(
              "Start Server" ,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary
              ),  
            ) 
          ),
        ),
        // const SizedBox(width: 8,),
      ],
    );
  }
}
