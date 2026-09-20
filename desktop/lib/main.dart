import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop/core/theme/theme_provider.dart';
import 'package:desktop/presentation/screens/home/home_view.dart';
import 'package:desktop/presentation/widgets/navigation_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: DesktopGamePadClient()));

  doWhenWindowReady(() {
    const initialSize = Size(500, 700);
    appWindow.minSize   = initialSize;
    appWindow.size      = initialSize;
    appWindow.maxSize   = initialSize;
    
    appWindow.alignment = Alignment.center;
    appWindow.title     = 'GamePad Server';
    appWindow.show();
  });
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

      home: NavigationFrame(
        pageBuilder: (context) => HomeView()
      ),
    );   
  }
}