import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/player_settings_repository_impl.dart';
import 'package:game_controller/presentation/providers/connection_player_provider.dart';
import 'package:game_controller/presentation/utils/dialog_collection.dart';


class UserNameTile extends ConsumerWidget {
  const UserNameTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(connectionPlayerProvider);
    final playerName = player.whenData((p) => p.name);
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
    
          Expanded(
            child: FittedBox(
              fit: .scaleDown,
              alignment: .centerStart,
              child: Text(
                "UserName: ${playerName.value ?? '-----'}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          
          IconButton(
            onPressed: () {
              editName(context, ref, playerName.value);
            }, 
            icon: Icon(Icons.edit_outlined)
          )
        ],
      ),
    );
  }

  Future<void> editName(
    BuildContext context, 
    WidgetRef ref, 
    String ? name
  ) async {
    final newUserName = await DialogCollection.simplePopUpForm(
      context,
      title: 'Edit Name Form',
      initValue: name
    );

    if(newUserName != null){
      try{
        await ref.read(playerSettingsRepositoryProvider).updatePlayerName(
          newUserName
        );
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(errorSnackbar(e));
      }
    }
  }


  SnackBar errorSnackbar(Object error) 
    => SnackBar(content: Text(error.toString()));

}
