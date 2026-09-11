import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/providers/controller_edit_provider.dart';
import 'package:go_router/go_router.dart';

class ControllerMetadaForm extends ConsumerStatefulWidget{
  const ControllerMetadaForm({
    super.key,
    required this.controllerId,
    required this.initValue
  });

  final String ? controllerId;
  final String ? initValue;

  @override
  ConsumerState<ControllerMetadaForm> createState() => _ControllerMetadaFormState();
}

class _ControllerMetadaFormState extends ConsumerState<ControllerMetadaForm> {
  final _formKey = GlobalKey<FormBuilderState>();
 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Controller's name"),
      
      content: FormBuilder(
        key: _formKey,

        child: Column(
          mainAxisSize: .min,

          children: [
            
            FormBuilderTextField(
              name: "controllerName",
              initialValue: widget.initValue,
              decoration: InputDecoration(
                hintText: "Name"
              ),
              validator: (value){
                if(value == null || value.isEmpty) return "Nombre requerido";
                return null;
              },
            ),

          
          ],
        )
      ),

      actions: [
        TextButton(onPressed: (){
          context.pop(false);
        }, child: Text("Cancelar")),
        
        TextButton(onPressed: (){
          processForm(context);
        }, child: Text("Aceptar")), 
      ],
    );
  }


  void processForm(BuildContext context) async {
    if(_formKey.currentState?.saveAndValidate()??false){
      final values = _formKey.currentState!.value;

      ref.read(controllerEditProvider(widget.controllerId).notifier).editController(
        (controller) => controller.copyWith(
          name: values['controllerName'],
        )
      );

      try{
        await ref.read(controllerEditProvider(widget.controllerId).notifier).save();
        context.pop(true);
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    }
  }

  SnackBar get errorSnackBar => SnackBar(
    content: Text('Error saving the changes, please reestar the app'));
}





