import 'package:core/core.dart';

abstract class ConnectionRepository {
  Stream<ServerEvent> get serverEventStream; 

  Stream<PlayerConnectionStatus> get connectionStatusStream;
  PlayerConnectionStatus get connectionStatus;

  Stream<Duration?> get pingStream;
  Duration ? get ping;


  void connect(String serverAddress, int port);

  void disconnect();

  void send(ButtonPlayerEvent pbe);
}