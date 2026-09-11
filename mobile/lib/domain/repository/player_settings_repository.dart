import 'package:core/core.dart';

abstract class PlayerSettingsRepository {
  Stream<Player> get playerStream;
  
  Future<Player> get player;

  Future<void> updatePlayerName(String playerName);
}