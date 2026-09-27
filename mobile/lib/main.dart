import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/core/init/init.dart';
import 'package:game_controller/core/l10n/app_localizations.dart';
import 'package:game_controller/core/navigation/navigation.dart';
import 'package:game_controller/core/theme/theme_provider.dart';
import 'package:game_controller/data/sources/controller_local_storage_service.dart';
import 'package:game_controller/data/sources/player_local_storage_service.dart';
import 'package:game_controller/data/static_collections/local_storage_keys.dart';
import 'package:game_controller/presentation/screens/startup/startup_widget.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp( const ProviderScope(child: GameController()) );
}


class GameController extends ConsumerWidget {
  const GameController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final router = ref.watch(navigationProvider);
    final theme  = ref.watch(themeProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      debugShowCheckedModeBanner: false,
      
      theme    : ref.read(themeProvider.notifier).lightTheme,
      darkTheme: ref.read(themeProvider.notifier).darkTheme,
      themeMode: theme.themeMode,

      localizationsDelegates: [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      
      
      routerConfig: router,
      builder: (context, child) => StartupWidget(
        builder: (_)=>child!
      ) 
    );
  }

}
