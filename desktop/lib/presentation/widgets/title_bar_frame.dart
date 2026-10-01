import 'package:desktop/presentation/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class TitleBarFrame extends StatelessWidget{
  const TitleBarFrame({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        border: .all(
          width: 1,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(100)
        )
      ),
      child: Scaffold(
        appBar: const TitleBar(),
        body: child,
      ),
    );
  }
}