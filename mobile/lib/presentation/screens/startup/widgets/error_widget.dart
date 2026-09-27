import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';

class MyErrorWidget extends StatelessWidget{
  const MyErrorWidget({
    super.key,
    required this.error,
    required this.retry
  });

  final Object error;
  final Function() retry;

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error,),
            const SizedBox(height: 8,),
            Text(error.toString(), textAlign: .center,),
            const SizedBox(height: 8,),
            FilledButton.tonal(
              onPressed: retry, 
              child : Text(AppLocalizations.of(context)!.reload)
            )
          ],
        ),
      ),
    );
  }
}