
import 'package:desktop/data/repository/connection_repository.dart';
import 'package:core/src/models/network/server_address.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';


final serverAddressProvider = StreamProvider<List<ServerAddress>>((ref){
  final repo = ref.read(connectionRepositoryProvider);
  
  return ConcatStream([
    Stream.fromFuture(.value(repo.serverAddress)),
    repo.serverAddressStream
  ]);
});