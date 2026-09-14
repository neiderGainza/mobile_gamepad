import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/player_settings_repository_impl.dart';
import 'package:rxdart/streams.dart';

final playerProvider = StreamProvider<Player>((ref) {
  final repo = ref.watch(playerSettingsRepositoryProvider);
  return ConcatStream([
    Stream.fromFuture(.value(repo.player)),
    repo.playerStream
  ]);
});
