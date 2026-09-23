import 'package:core/core.dart';
import 'package:game_controller/domain/enums/player_info_sync_state.dart';
import 'package:game_controller/domain/model/connection_message.dart';

abstract class ConnectionRepository {
  // canal de informacion
  Stream<ConnectionMessage> get infoStream;

  // connection Status
  Stream<ConnectionStatus> get connectionStatusStream;
  ConnectionStatus get connectionStatus;

  // ping
  Stream<Duration?> get pingStream;
  Duration ? get ping;

  // playerInfoSyncState
  Stream<PlayerInfoSyncState> get playerInfoSyncStateStream;
  PlayerInfoSyncState get playerInfoSyncState; 

  
  /// ---------------------- Methods -------------------------
  void connect(String serverAddress, int port);

  void disconnect();

  void send(Event event);

  /// los intentos de sincronizacion son automaticos
  /// pero esto los fuerza (util en caso de fallo de 
  /// sincronizacion automatica).
  ///  
  /// la data del player sera obtenida del [PlayerLocalStorage]
  Future<void> syncPlayerData();

  String ? get lastServerAddress;
}