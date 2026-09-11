import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/presentation/screens/startup/startup_provider.dart';

class StartupWidget extends ConsumerWidget{
  const StartupWidget({
    super.key,
    required this.builder,
    required this.onLoad,
    required this.onError
  }); 

  final WidgetBuilder builder;
  final AsyncCallback onLoad;
  final Future<void> Function(Object error) onError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStart = ref.watch(startupProvider(onLoad));    
    
    return asyncStart.when(
      data: (_) => builder(context), 
      error: (error, trace) => SizedBox.shrink(), 
      loading: () => SizedBox.shrink()
    );
  }
}