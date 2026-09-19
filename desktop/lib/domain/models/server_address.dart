import 'package:desktop/domain/models/server_interface.dart';

class ServerAddress {
  final int port;
  final ServerInterface interface;

  const ServerAddress({
    required this.port,
    required this.interface
  });
}