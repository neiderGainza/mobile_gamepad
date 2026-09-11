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
      String ? title
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
}