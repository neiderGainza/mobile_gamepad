import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/static_collections/default_controller.dart';
import 'package:game_controller/domain/model/controller.dart';
import 'package:game_controller/presentation/providers/controller_edit_provider.dart';
import 'package:go_router/go_router.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.controller
  });

  final Controller controller;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const .symmetric(vertical: 4, horizontal: 8),
      constraints: BoxConstraints(
        minHeight: 56,
        minWidth: 120
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: .circular(20)
        ),
        color: Theme.of(context).colorScheme.primaryContainer
      
      ),
      
      child: Row(
        mainAxisSize: .min,
        children: [

          myBackButton(context),  
          const SizedBox(width: 8,),
 
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 100
            ),
            child: FittedBox(
              fit: .fitWidth,
              child: Text( 
                DefaultController.isDefault(controller)
                  ? 'Default Controller'
                  :  controller.name ?? 'Unnamed Controller', 
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer
                ),
              ),
            ),
          ),

          const SizedBox(width: 8,),
          editButton(context)
        ],
      ),
    );
  }


  Widget myBackButton(BuildContext context){
    return BackButton(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      onPressed: () {
        if(context.canPop()){ context.pop(); }
        else { context.go('/controllers'); }
    },);   
  }

  Widget editButton(BuildContext context){
    return Consumer(
      builder: (context, ref, child) {
        return IconButton(
          onPressed: (){
            if(DefaultController.isDefault(controller)){
              ref.read(controllerEditProvider(null).notifier).editController(
                (_) => Controller(
                  buttonGroups: controller.buttonGroups
                )
              );
        
              context.push('/controller/form', extra: null);
              return;
            }
        
            context.push('/controller/form', extra: controller.id); 
          },
          icon: Icon(Icons.edit_outlined, 
            color: Theme.of(context).colorScheme.onPrimaryContainer,)
        );
      }
    );
  }
}