import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class DialogCollection {
  static Future<bool?> areYouSureDialog(BuildContext context, String message) 
    => showDialog<bool>(
      context: context, 
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.areYouSure),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: (){ context.pop(false); }, 
              child: Text(l10n.cancel)
            ),
            TextButton(
              onPressed: (){ context.pop(true); }, 
              child: Text(l10n.accept)
            ),
          ],
        );
      }
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
              if(value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.fieldRequired;
              }
              return null;
            },
          )
        ),

        actions: [
          TextButton(
            onPressed: (){ context.pop(); }, 
            child: Text(AppLocalizations.of(context)!.cancel)
          ),
          TextButton(
            onPressed: (){ 
              if(formKey.currentState?.saveAndValidate()??false){
                context.pop(formKey.currentState?.value['field']); 
              }  
            }, 
            child: Text(AppLocalizations.of(context)!.save)
          ),
        ],
      )
    );
  }


  static Future<String?> typeAddressForm(
    BuildContext context, 
    {
      String ? initIp,
      String ? initPort
    }
  ){
    final formKey = GlobalKey<FormBuilderState>();

    return showDialog<String>(
      context: context, 
      builder: (context) => AlertDialog(
        
        title  : Text(AppLocalizations.of(context)?.typeServerAddress??'Server Address'),
      
        content: FormBuilder(
          key: formKey,
          child: Column(
            mainAxisSize: .min,
            children: [
              FormBuilderTextField(
                name: 'ip' ,
                initialValue: initIp,
                keyboardType: .number,
                decoration: InputDecoration(
                  labelText: "Ip" 
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.fieldRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8,),
              FormBuilderTextField(
                name: 'port',
                initialValue: initPort,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.port 
                ),
                keyboardType: .number,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.fieldRequired;
                  }
                  return null;
                },
              ),
            ]
          )
        ),

        actions: [
          TextButton(
            onPressed: (){ context.pop(); }, 
            child: Text(AppLocalizations.of(context)!.cancel)
          ),
          TextButton(
            onPressed: (){ 
              if(formKey.currentState?.saveAndValidate()??false){
                context.pop(
                  '${formKey.currentState?.value['ip']}:'
                  '${formKey.currentState?.value['port']}'
                ); 
              }  
            }, 
            child: Text(AppLocalizations.of(context)!.accept)
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
          title  : Text(AppLocalizations.of(context)!.pickNetworkInterface),

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
                  AppLocalizations.of(context)!.networkInterfaceWarning,
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
              child: Text(AppLocalizations.of(context)!.cancel)
            ),
          ],
        )
      );

      return result;
    }

}