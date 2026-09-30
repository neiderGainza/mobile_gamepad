import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/screens/startup/startup_provider.dart';
import 'package:game_controller/presentation/screens/startup/widgets/error_widget.dart';

class StartupWidget extends ConsumerWidget{
  const StartupWidget({
    super.key,
    required this.builder,
  }); 

  final WidgetBuilder builder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStart = ref.watch(startupProvider);    
    
    return asyncStart.when(
      data: (_) => builder(context), 
      error: (error, trace) => MyErrorWidget(
        error: error, 
        retry: ref.watch(startupProvider.notifier).retry
      ),
      loading: () => SizedBox.shrink()
    );
  }
}