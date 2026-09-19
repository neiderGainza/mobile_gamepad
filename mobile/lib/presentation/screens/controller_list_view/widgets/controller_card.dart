import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/static_collections/default_controller.dart';
import 'package:game_controller/domain/model/controller.dart';
import 'package:game_controller/presentation/providers/controllers_provider.dart';
import 'package:game_controller/presentation/utils/dialog_collection.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago; 

class ControllerCard extends StatelessWidget {
  const ControllerCard({
    super.key,
    required this.controller
  });

  final Controller controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/controller/${controller.id}'),

      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer.withAlpha(100),
        margin: const .symmetric(vertical: 4, horizontal: 8),
        child: ListTile(
          title: Text(controller.name ?? "Unnamed Controller"),
          subtitle: DefaultController.isDefault(controller) 
            ? Text('Defult Controller')
            : Text(timeago.format(controller.lastEdited)),
          trailing: actions(context),
        ),
      ),
    );
  }


  Widget actions(BuildContext context){
    return Row(
      mainAxisSize: .min,
    
      children: [
        if(!DefaultController.isDefault(controller))
        deleteButton(context),

      ],
    );
  } 


  Widget deleteButton(BuildContext context){
    return Consumer(
      builder: (context, ref, _) {
        
        return IconButton(
          onPressed: () async {
            
            final sure = await DialogCollection.areYouSureDialog(
              context,
              'Are you sure about deleting the controller ${controller.name}' 
            );
        
            if(sure == true && controller.id != null){
              ref.read(controllersProvider.notifier).removeController(
                controller.id!
              );
            }
        
          },
          icon: Icon(Icons.delete_outline)
        );
      }
    );
  }

}
