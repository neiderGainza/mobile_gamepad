import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/sources/controller_local_storage_service.dart';
import 'package:game_controller/data/sources/player_local_storage_service.dart';
import 'package:game_controller/data/static_collections/local_storage_keys.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';


final startupProvider = AsyncNotifierProvider<StartupNotifier, void>(
  StartupNotifier.new,
  retry: (retryCount, error) => null, // do not retry
);


class StartupNotifier extends AsyncNotifier<void>{
  
  @override
  Future<void> build() async {
    await ref.watch(controllerLocalStorageProvider.future);
    await ref.watch(playerLocalStorageProvider.future);
  }

  Future<void> retry() async{
    state = AsyncLoading();
    await Hive.deleteBoxFromDisk(LocalStorageKeys.cacheKey);
    state = await AsyncValue.guard(build);
  }
}
