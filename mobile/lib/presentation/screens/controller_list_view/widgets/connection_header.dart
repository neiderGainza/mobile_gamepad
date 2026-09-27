import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/data/repositories/player_settings_repository_impl.dart';
import 'package:game_controller/presentation/providers/connection_status_provider.dart';
import 'package:game_controller/presentation/providers/player_provider.dart';
import 'package:game_controller/presentation/screens/controller_list_view/widgets/scan_address_btn.dart';
import 'package:game_controller/presentation/utils/dialog_collection.dart';
import 'package:game_controller/presentation/utils/snackbar_collection.dart';
import 'package:game_controller/presentation/widgets/connection_status_indicator.dart';
import 'package:game_controller/presentation/widgets/ping_indicator.dart';
import 'package:game_controller/presentation/widgets/player_info_sync_indicator.dart';
import 'package:game_controller/presentation/widgets/player_name.dart';
import 'package:go_router/go_router.dart';


class ConnectionHeader extends ConsumerWidget {
  const ConnectionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: .all(8),
      margin : .all(8),
      decoration: BoxDecoration(
        borderRadius: .circular(12),
        border: Border.all( width: 2, color: cs.secondary ),
        color: cs.surfaceContainer
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: .start,
        children: [
          
          /// Connected -------- Ping 4 ms
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,0),
            
            child: Row(
              mainAxisAlignment: .spaceBetween,
              mainAxisSize: .max,
              children: [
                ConnectionStatusIndicator(
                  defaultStyle: tt.headlineMedium?.copyWith(color: cs.secondary),
                  connectedStyle: tt.headlineMedium?.copyWith(color: Colors.green),
                  disconnectedStyle: tt.headlineMedium?.copyWith(color: Colors.red),
                  connectingStyle: tt.headlineMedium?.copyWith(color: Colors.orange),
                ),
            
                PingIndicator(
                  style: null,
                )
              ],
            ),
          ),         

          /// Sync PlayerName: PlayerName ------- edit
          Row(
            mainAxisSize: .max,
            children: [
              IconButton(
                onPressed: () => editName(context, ref), 
                icon: Icon(Icons.edit_outlined)
              ),

              Expanded(
                child: FittedBox(
                  alignment: .centerStart,
                  fit: .scaleDown,
                  
                  child: PlayerName(
                    style: tt.bodyLarge,
                  ),
                ),
              ),

              const PlayerInfoSyncIndicator(),
              const SizedBox(width: 8,)
            ],
          ),
          const SizedBox(height: 8,),

          Container(
            clipBehavior: .antiAlias,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: .circular(10),
            ),
            child: ListTile(
              title: Text(l10n.howToUseTitle),
              trailing: Icon(Icons.question_mark_rounded),
              onTap: () => context.push('how_to'),
            ),
          ),
          
          const SizedBox(height: 8,),
          const ActionsTile()
        ],
      ),
    );
  }

  Future<void> editName(
    BuildContext context, 
    WidgetRef ref,
  ) async {
    final newUserName = await DialogCollection.simplePopUpForm(
      context,
      title: AppLocalizations.of(context)!.editUsername,
      initValue: ref.read(playerProvider).value?.name
    );

    if(newUserName != null){
      try{
        await ref.read(playerSettingsRepositoryProvider).updatePlayerName(
          newUserName
        );
      }catch(e){ SnackbarCollection.errorSnackbar(context, e.toString());}
    }
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
          title: AppLocalizations.of(context)!.serverAddressPort,
          initValue: ref.read(connectionRepositoryProvider).lastServerAddress,
          keyboardType: .number
        );
    
        if(address != null){
          try{
            final parts = address.split(':');
            ref.read(connectionRepositoryProvider).connect(
              parts[0], 
              int.parse(parts[1])
            );
          }catch(e){
            SnackbarCollection.errorSnackbar(context, AppLocalizations.of(context)!.connectionFailed);
          }
        }
      }, 
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: .circular(10)
        )
      ),
      child     : Text(AppLocalizations.of(context)!.typeAddress)
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
              AppLocalizations.of(context)!.disconnect,
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
