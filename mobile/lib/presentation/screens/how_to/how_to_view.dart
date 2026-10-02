import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HowToView extends StatelessWidget{
  const HowToView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(AppLocalizations.of(context)!.howToUseTitle),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          
          children: [
            const HowToUse(),
            const SizedBox(height: 8,),
            const HowManyUserCanIConnect(),
            const SizedBox(height: 8,),
            const HowToConnectoThroughtBluetooth(),
            const SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}

class HowToTile extends StatelessWidget{
  const HowToTile({
    super.key,
    required this.title,
    required this.steps,
    this.initialyExpanded = false,
  });

  final bool initialyExpanded;
  final String title;
  final List<Widget> steps;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Material(
      textStyle: tt.titleMedium,

      child: ExpansionTile(
        title: Text(title),
        backgroundColor: cs.surfaceContainerHighest,
        collapsedBackgroundColor: cs.surfaceContainer,
        initiallyExpanded: initialyExpanded,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(10)
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: .circular(10)
        ),
        expandedCrossAxisAlignment: .start,
        expandedAlignment: .topLeft,
        childrenPadding: .fromLTRB(16,0,16,8),
        children: steps
      ),
    );
  }

}



class HowToUse extends StatelessWidget {
  const HowToUse({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;    

    return HowToTile(
      initialyExpanded: true,
      title: AppLocalizations.of(context)!.howToUse, 
      steps: [
        RichText(
          text: TextSpan(
            text: AppLocalizations.of(context)!.howToUseStep1,
            style: tt.bodyMedium,
            children: [
              TextSpan(
                text: AppLocalizations.of(context)!.downloadPage,
                style: tt.bodyMedium?.copyWith(
                  decoration: .underline,
                  color: cs.tertiary
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final url  = Uri.parse('https://neidergainza.github.io/gamepad_releases/#downloads');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  }
              ), 
              TextSpan( text:'.'),
            ]
          ),
        ),
        Text(AppLocalizations.of(context)!.howToUseStep2),
        Text(AppLocalizations.of(context)!.howToUseStep3),
      ]
    );
  }
}


class HowManyUserCanIConnect extends StatelessWidget {
  const HowManyUserCanIConnect({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    // final cs = Theme.of(context).colorScheme;
    // final tt = Theme.of(context).textTheme;

    return HowToTile(
      title: AppLocalizations.of(context)!.howManyUsers, 
      steps: [
        Text(AppLocalizations.of(context)!.howManyUsersStep1),
      ]
    );

  }
}


class HowToConnectoThroughtBluetooth extends StatelessWidget {
  const HowToConnectoThroughtBluetooth ({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return HowToTile(
      title: AppLocalizations.of(context)!.howConnectThroughtBluetooth,
      steps: [
        Text(AppLocalizations.of(context)!.howConnectThroughtBluetoothStep1),
        Text(AppLocalizations.of(context)!.howConnectThroughtBluetoothStep2),
        Text(AppLocalizations.of(context)!.howConnectThroughtBluetoothStep3),
      ]
    );
  }
}