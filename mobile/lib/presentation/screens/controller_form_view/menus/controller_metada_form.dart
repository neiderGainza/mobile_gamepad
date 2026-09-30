import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      contentPadding: .symmetric(horizontal: 16, vertical: 8),
      actionsPadding: .only(left: 16, right: 16, bottom: 6),
      scrollable: true,
      content: FormBuilder(
        key: _formKey,

        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(l10n.controllerNameTitle, style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: 8,),

            FormBuilderTextField(
              name: "controllerName",
              initialValue: widget.initValue,
              decoration: InputDecoration(
                hintText: l10n.name
              ),
              validator: (value){
                if(value == null || value.isEmpty) return l10n.fieldRequired;
                return null;
              },
            ),

          
          ],
        )
      ),

      actions: [
        TextButton(onPressed: (){
          context.pop(false);
        }, child: Text(l10n.cancel)),
        
        TextButton(onPressed: (){
          processForm(context);
        }, child: Text(l10n.accept)), 
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
        context.pop(values['controllerName']);
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(context));
      }
    }
  }

  SnackBar errorSnackBar(BuildContext context) => SnackBar(
    content: Text(AppLocalizations.of(context)!.saveChangesError));
}





