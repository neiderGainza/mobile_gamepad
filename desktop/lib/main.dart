import 'package:desktop/core/nav/navigation.dart';
import 'package:desktop/core/theme/theme_provider.dart';
import 'package:desktop/data/source/shared_preferences_singleton.dart';
import 'package:desktop/data/source/vigem_bus_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await VigemBusService.checkInstalled();
  await SharedPreferencesSingleton.load();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(500, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: DesktopGamePadClient()));
}

class DesktopGamePadClient extends ConsumerWidget {
  const DesktopGamePadClient({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final router = ref.watch(navigationProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      theme: ref.read(themeProvider.notifier).lightTheme,
      darkTheme: ref.read(themeProvider.notifier).darkTheme,
      themeMode: theme.themeMode,

      routerConfig: router,
    );
  }
}
