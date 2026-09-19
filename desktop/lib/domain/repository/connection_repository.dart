import 'package:core/core.dart';
import 'package:desktop/domain/models/server_address.dart';

abstract class ConnectionRepository {
  Stream<ConnectionStatus> get serverStatusStream;  
  ConnectionStatus get serverStatus;

  Stream<List<PlayerState>> get playersStateStream;
  List<PlayerState> get playersState;

  Stream<List<ServerAddress>> get serverAddressStream;  
  List<ServerAddress> get serverAddress;

  /// Se conecta al server actual
  /// si no hay uno lo inicializa
  Future<void> connect();

  // No cierra el server, solo se desconecta del mismo
  void disconnect();

  // Detener el server Event
  void stopServer();
}
