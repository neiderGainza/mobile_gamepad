import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop/presentation/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class NavigationFrame extends StatelessWidget{
  const NavigationFrame({
    super.key,
    required this.pageBuilder
  });

  final WidgetBuilder pageBuilder;

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
      child: Scaffold(
        appBar: const TitleBar(),
        body: pageBuilder(context),
      ),
    );
  }
}