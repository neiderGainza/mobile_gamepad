import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/controller_repository_impl.dart';
import 'package:game_controller/domain/model/controller.dart';

final controllersProvider = NotifierProvider(ControllersProvider.new);


class ControllersProvider extends Notifier<IList<Controller>>{
  @override
  IList<Controller> build() {
    final controllerRepository = ref.read(controllerRepositoryProvider);
    return controllerRepository.localControllers.toIList();
  }

  Future<void> updateController(Controller controller) async {
    await ref.read(controllerRepositoryProvider).upsertController(controller);

    state = <Controller>[
      for(final c in state)
      if(c.id == controller.id) controller
      else c
    ].toIList();
  }

  Future<void> insertController(Controller controller) async {
    final controllerId = await ref.read(controllerRepositoryProvider)
                                  .upsertController(controller);

    state = <Controller>[
      controller.copyWith(id: controllerId),
      ...state
    ].toIList();
  }

  Future<void> removeController(String controllerId) async {
    await ref.read(controllerRepositoryProvider)
      .removeController(controllerId);
    
    state = <Controller>[
      for (final c in state)
      if(c.id != controllerId)
      c
    ].toIList();
  }
}
