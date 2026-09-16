import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:server/server_cubit.dart';

final _serverCubit = ServerCubit();

Future<Response> onRequest(RequestContext context) async {

  final handler = webSocketHandler(
    (channel, protocol) {
      _serverCubit.handleNewPlayerConnection(channel);    
    },
  );

  return handler(context);
}
