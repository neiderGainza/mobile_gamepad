import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:go_router/go_router.dart';


class ScanAddressBtn extends ConsumerWidget {
  const ScanAddressBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return FilledButton.tonal(
      onPressed : () async {
        final selectedServerAddress = await context.push('/scan');

        if(selectedServerAddress is ServerAddress){
          ref.read(connectionRepositoryProvider).connect(
            selectedServerAddress.interface.ip, 
            selectedServerAddress.port
          );
        }
      }, 
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: .circular(10)
        )
      ),
      child : Text(AppLocalizations.of(context)!.scanQr)
    );
  }

}
