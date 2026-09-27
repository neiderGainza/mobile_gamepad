import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/controller_repository_impl.dart';
import 'package:game_controller/domain/model/button_group.dart';
import 'package:rxdart/streams.dart';


final customButtonProvider = StreamProvider<List<ButtonGroup>>((ref) {
  final repo = ref.watch(controllerRepositoryProvider);
  return ConcatStream([
    .fromFuture(Future.value(repo.customButtons)),
    repo.customButtonsStream
  ]);
});
