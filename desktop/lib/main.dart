import 'package:desktop/core/theme/theme_provider.dart';
import 'package:desktop/presentation/screens/home/home_view.dart';
import 'package:desktop/presentation/widgets/title_bar_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(600, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: DesktopGamePadClient()));
}


class DesktopGamePadClient extends ConsumerWidget{
  const DesktopGamePadClient({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme  = ref.watch(themeProvider);


    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme    : ref.read(themeProvider.notifier).lightTheme,
      darkTheme: ref.read(themeProvider.notifier).darkTheme,
      themeMode: theme.themeMode,

      home: const TitleBarFrame(
        child: HomeView(),
      )
    );   
  }
}