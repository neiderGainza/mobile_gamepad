import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:rxdart/streams.dart';

final connectionStatusProvider = StreamProvider<PlayerConnectionStatus>((ref) {
  final connectionRepo = ref.watch(connectionRepositoryProvider);
  return ConcatStream([
    Stream.fromFuture(.value(connectionRepo.connectionStatus)),
    connectionRepo.connectionStatusStream,
  ]);
});
