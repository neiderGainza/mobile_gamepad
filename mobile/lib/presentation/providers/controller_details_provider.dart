import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game_controller/data/repositories/controller_repository_impl.dart';
import 'package:game_controller/domain/model/controller.dart';
import 'package:game_controller/presentation/providers/controllers_provider.dart';
import 'package:riverpod/riverpod.dart';

part 'controller_details_provider.freezed.dart';
part 'controller_details_provider.g.dart';

final controllerDetailsProvider = AsyncNotifierProvider
  .family<ControllerDetailsNotifier, ControllerDetailsState, String>(
    ControllerDetailsNotifier.new
  );

class ControllerDetailsNotifier extends AsyncNotifier<ControllerDetailsState>{
  ControllerDetailsNotifier(this.controllerId);

  final String controllerId;

  @override
  FutureOr<ControllerDetailsState> build() async {
    final controllerRepository = ref.read(controllerRepositoryProvider);

    final controller = ref.watch(controllersProvider.select(
      (cs) => cs.firstWhere(
        (c) => c.id == controllerId,
        orElse: () => controllerRepository.getLocalControllerById(controllerId),
      )
    ));
    
    return ControllerDetailsState(controller: controller);
  }
}

@freezed
@JsonSerializable()
class ControllerDetailsState with _$ControllerDetailsState{
  final Controller controller;

  const ControllerDetailsState({
    required this.controller
  });
}