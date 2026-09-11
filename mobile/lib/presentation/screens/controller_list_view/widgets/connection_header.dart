import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/presentation/providers/conection_status_provider.dart';
import 'package:game_controller/presentation/screens/controller_list_view/widgets/connection_tile.dart';
import 'package:game_controller/presentation/screens/controller_list_view/widgets/user_name_tile.dart';
import 'package:game_controller/presentation/utils/dialog_collection.dart';
import 'package:game_controller/presentation/utils/snackbar_collection.dart';


class ConnectionHeader extends StatelessWidget {
  const ConnectionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(8),
      margin: .all(8),
      decoration: BoxDecoration(
        borderRadius: .circular(12),
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.secondary
        ),
        color: Theme.of(context).colorScheme.surfaceContainer
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: .start,
        children: [
          const ConnectionTile(),
          const UserNameTile(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(AppLocalizations.of(context)?.howToUse??''),
          ),

          const ActionsTile()
        ],
      ),
    );
  }
}


class ActionsTile extends ConsumerWidget {
  const ActionsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(connectionStatusProvider);
    
    return status.when(
      data: (s){

        if(s == .disconnected || s == .connecting){

          return const Row(
            children: [
              Expanded(child: TypeAddressBtn()),
              SizedBox(width: 8,),              
              Expanded(child: ScanAddressBtn()),
            ],
          );
        }else{
          return DisconnectionBtn();
        }
      }, 
      error: (e, t) => SizedBox.shrink(), 
      
      loading: () => Container(
        height: 32,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: .circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.secondaryContainer),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
      )

    );

        
  }
}


class ScanAddressBtn extends StatelessWidget {
  const ScanAddressBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed : (){}, 
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: .circular(10)
        )
      ),
      child     : Text("Scan QR") 
    );
  }
}


class TypeAddressBtn extends ConsumerWidget {
  const TypeAddressBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return FilledButton.tonal(
      onPressed : () async {
        final address = await DialogCollection.simplePopUpForm(
          context, 
          title: 'ServerAddress:ServerPort',
        );
    
        if(address != null){
          try{
            final parts = address.split(':');
            ref.read(connectionRepositoryProvider).connect(
              parts[0], 
              int.parse(parts[1])
            );
          }catch(e){
            SnackbarCollection.connectionFailedSnackbar(context);
          }
        }
      }, 
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: .circular(10)
        )
      ),
      child     : Text("Type address") 
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
        // const SizedBox(width: 8,),
        Expanded(
          child: FilledButton(
            onPressed : () async {
              ref.read(connectionRepositoryProvider).disconnect();
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: .circular(10),
              )
            ),
            child : Text(
              "Disconnect" ,
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
