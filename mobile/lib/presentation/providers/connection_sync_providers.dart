import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:rxdart/streams.dart';


final connectionSyncPlayerProvider = StreamProvider((ref) {
  final repo = ref.watch(connectionRepositoryProvider);
  return ConcatStream([
    .fromFuture(Future.value(repo.playerInfoSyncState)),
    repo.playerInfoSyncStateStream
  ]);
});
