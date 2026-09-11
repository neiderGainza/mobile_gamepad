import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final startupProvider = AsyncNotifierProvider.family<StartupNotifier, void, AsyncCallback>(
  StartupNotifier.new,
  retry: (retryCount, error) => null, // do not retry
);


class StartupNotifier extends AsyncNotifier<void>{
  StartupNotifier(this.onLoad);

  final AsyncCallback onLoad;

  @override
  Future<void> build() async {
    await onLoad();
  }

  Future<void> retry( Future<void> Function(Object ? error) onRetry ) async{
    final Object ? error = state.error;
    state = AsyncLoading();
    await onRetry(error);
    state = await AsyncValue.guard(build);
  }
}
