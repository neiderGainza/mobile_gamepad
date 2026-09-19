import 'dart:io';
import 'package:core/core.dart';

/// Singleton para controlar el server
/// cerrar
class ServerController {
  /// Singleton Contructor
  factory ServerController() => ServerController._instance;
  ServerController._();
  static final ServerController _instance = ServerController._(); 

  /// servidor
  HttpServer ? _server;

  /// Settear el server
  /// guarda el address:port en un shareFile
  Future<void> setServer(HttpServer server) async {
    if(_server != null) throw Exception('Server Already inicializate');
    
    await ServerConfigService.upsertServerPort( server.port );
    _server = server;
  }

  /// Closes the server
  Future<void> shoutDown() async {
    await _server?.close(force: true);
  }
}
