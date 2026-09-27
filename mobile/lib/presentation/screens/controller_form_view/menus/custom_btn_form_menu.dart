import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:game_controller/domain/model/button.dart';
import 'package:game_controller/domain/model/button_data.dart';
import 'package:game_controller/domain/model/button_group.dart';
import 'package:go_router/go_router.dart';


class CreateBtnFormMenu extends StatefulWidget{
  const CreateBtnFormMenu({
    super.key
  });

  @override
  State<CreateBtnFormMenu> createState() => _CreateBtnFormMenuState();

  static String ? labelValidator(String ? value){
    if(value == null || value.isEmpty) return "Label required";
    if(value.length > 5 ) return "Label must be shorter (5 characters)";
    return null;
  }

  static String ? actionsValidator(List<PlayerButton> ? value){
    if(value == null || value.length <= 1) return "At least 2 actions required"; 
    return null;
  }
}

class _CreateBtnFormMenuState extends State<CreateBtnFormMenu> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return AlertDialog(
      scrollable: true,
      actionsPadding: .fromLTRB(8, 0, 8, 4),
      contentPadding: .symmetric(vertical: 0, horizontal: 8),
      titlePadding: .fromLTRB(8, 8, 8, 4),
      title: Text("Shorcut Creator"),
      content: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const SizedBox(height: 8,),
            Text(" Select your actions", style: tt.titleMedium,),
            const SizedBox(height: 4,),

            FormBuilderField<List<PlayerButton>>(
              builder: (state) => PlayerActionPicker(state: state),
              name   : "buttonActions",
              validator: CreateBtnFormMenu.actionsValidator,
            )

          ], 
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => context.pop(), 
          child: Text('Cancel')
        ),
        TextButton(
          onPressed: (){
            final btnGroup = _createBtnGroup();

            if(btnGroup != null) context.pop(btnGroup);
          }, 
          child: Text("Save")
        )
      ],
    );
  }



  ButtonGroup ? _createBtnGroup(){
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState?.value;
      if(values == null) return null;
      
      final actions = values['buttonActions'] as List<PlayerButton>;

      return ButtonGroup.singleButtonGroup(
        button: Button(
          buttonData : ButtonData(
            label: actions.map((a) => a.i10n).join('+'),
            shape: .rectangle
          ), 
          buttonCodes: actions
        ),
      );
    }

    return null;
  }

}


class PlayerActionPicker extends StatelessWidget{
  const PlayerActionPicker({
    super.key,
    required this.state,
  });

  final FormFieldState<List<PlayerButton>> state;

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: .start,
      children: [
        Wrap(
          spacing: 2,
          children: [
            for(final btn in PlayerButton.values)
            if(!btn.hasAxis && !btn.isMenu)
            FilterChip(
              visualDensity: .compact,
              label: Text(btn.i10n),
              selected: state.value?.contains(btn)??false,
              onSelected: (value){
                state.didChange(
                  value 
                    ? [...?state.value, btn]
                    : [...?state.value?..remove(btn)]
                );
              },
            ),
          ],
        ),

        if(state.errorText != null)
        Text(
          state.errorText!, 
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.error
          ),
        )
      ],
    ); 
  }
}