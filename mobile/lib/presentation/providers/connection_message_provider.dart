import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_controller/data/repositories/connection_repository_impl.dart';
import 'package:game_controller/domain/model/connection_message.dart';

final connectionMessageProvider = StreamProvider<ConnectionMessage>((ref){
  final repo = ref.watch(connectionRepositoryProvider);
  return repo.infoStream;
});