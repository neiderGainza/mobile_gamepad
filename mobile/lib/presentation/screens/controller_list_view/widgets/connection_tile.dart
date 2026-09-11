import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/providers/conection_status_provider.dart';
import 'package:game_controller/presentation/providers/connection_ping_provider.dart';

class ConnectionTile extends StatelessWidget {
  const ConnectionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return ListTile(
      contentPadding: .all(4),
      title: Consumer(
        builder: (context, ref, child) {
          final connectionStatus = ref.watch(connectionStatusProvider);
      
          return connectionStatus.when(
            data: (status) => switch(status){
              .connected    => connected(context),
              .disconnected => disconnected(context),
              .connecting   => connecting(context)
            }, 
            error: (e,t) => SizedBox.shrink(), 
            loading: ( ) => SizedBox.shrink()
          );  
        },
      ),

      trailing: Consumer(
        builder: (context, ref, child) {
          final ping = ref.watch(connectionPingProvider);

          return ping.when(
            data: (pingDuration){
              return pingDuration == null
                ? SizedBox.shrink() 
                : Text(
                  'Ping: ${pingDuration.inMilliseconds} ms',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error
                  ),
                );
            }, 
            error: (e,t) => SizedBox.shrink(), 
            loading: ( ) => SizedBox.shrink()
          );
        },
      ),
    );
  }

  Widget connected(BuildContext context){
    return Text(
      "Connected", 
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary
      ),
    );
  }

  Widget disconnected(BuildContext context){
    return Text(
      "Disconnected", 
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.error
      ),
    );
  }
  
  Widget connecting(BuildContext context){
    return Text(
      "Connecting...", 
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.error
      ),
    );
  }
}
