import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class DialogCollection {
  static Future<bool?> areYouSureDialog(BuildContext context, String message) 
    => showDialog<bool>(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Are you sure?"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: (){ context.pop(false); }, 
            child: Text("Cancel")
          ),
          TextButton(
            onPressed: (){ context.pop(true); }, 
            child: Text("Accept")
          ),
        ],
      )
    );

  static Future<String?> simplePopUpForm(
    BuildContext context, 
    {
      String ? initValue,
      String ? title,
      TextInputType keyboardType = .text
    }
  ){
    final formKey = GlobalKey<FormBuilderState>();

    return showDialog<String>(
      context: context, 
      builder: (context) => AlertDialog(
        
        title  : title == null? null : Text(title),
      
        content: FormBuilder(
          key: formKey,
          child: FormBuilderTextField(
            name: 'field' ,
            initialValue: initValue,
            keyboardType: keyboardType,
            validator: (value) {
              if(value == null || value.isEmpty) return "Field requried";
              return null;
            },
          )
        ),

        actions: [
          TextButton(
            onPressed: (){ context.pop(); }, 
            child: Text("Cancel")
          ),
          TextButton(
            onPressed: (){ 
              if(formKey.currentState?.saveAndValidate()??false){
                context.pop(formKey.currentState?.value['field']); 
              }  
            }, 
            child: Text("Save")
          ),
        ],
      )
    );
  }

  static Future<ServerAddress?> pickServerAddress(
    BuildContext context, List<ServerAddress> addresses) async {
      
      final result = await showDialog<ServerAddress>(
        context: context, 
        builder: (context) => AlertDialog(
          contentPadding: .symmetric(horizontal: 16, vertical: 8),
          title  : Text("Pick a network interface"),

          content: Column(
            mainAxisSize: .min,
            children: [
              for(final address in addresses)
              ...[
                ListTile(
                  onTap: () => Navigator.of(context).pop(address),
                  tileColor: Theme.of(context).colorScheme.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: .circular(10)
                  ),
                  title: Text(address.interface.interfaceName),
                  subtitle: Text(address.interface.ip),
                ),
                const SizedBox(height: 4,),
              ],

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ' You must be already connected by the selected network interface, or the connection proccess will failed.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error
                  ),
                  textAlign: .center,
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: (){ Navigator.of(context).pop(); }, 
              child: Text("Cancel")
            ),
          ],
        )
      );

      return result;
    }

}