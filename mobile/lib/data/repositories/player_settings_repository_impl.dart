import 'package:core/src/models/player/player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/sources/player_local_storage_service.dart';
import 'package:game_controller/domain/repository/player_settings_repository.dart';

final playerSettingsRepositoryProvider = Provider((ref){
  return PlayerSettingsRepositoryImpl(
    ref.read(playerLocalStorageProvider).requireValue
  );
});


class PlayerSettingsRepositoryImpl extends PlayerSettingsRepository{
  final PlayerLocalStorageService _plss;

  PlayerSettingsRepositoryImpl(this._plss);

  @override
  Future<Player> get player => _plss.player;

  @override
  Stream<Player> get playerStream => _plss.playerStream;

  @override
  Future<void> updatePlayerName(String playerName) async {
    try{
      await _plss.upsertPlayer(
        (await player).copyWith(name: playerName)
      );
    }catch(e){
      debugPrint("Error updatePlayername-PlayerSettingsRepo $e");
      rethrow;
    }
  }

  @override
  bool isFirstLaunch() {
    try{
      final result = _plss.isFirstLaunch();

      if(result == true){
        _plss.setFirstLaunchToFalse();
      }

      return result;
    }catch(e){
      return false;
    }
  }
}