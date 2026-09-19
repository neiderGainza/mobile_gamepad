import 'package:core/core.dart';
import 'package:desktop/data/repository/connection_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final playersStateProvider = StreamProvider<List<PlayerState>>((ref){
  final repo = ref.read(connectionRepositoryProvider);

  return ConcatStream([
    Stream.fromFuture(.value(repo.playersState)),
    repo.playersStateStream
  ]);
});