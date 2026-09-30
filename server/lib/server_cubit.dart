import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:server/controller/server_controller.dart';
import 'package:server/models/server_state.dart';
import 'package:server/controller/desktop_cubit.dart';
import 'package:server/controller/player_cubit.dart';
import 'package:uuid/uuid.dart';


///
class ServerCubit extends Cubit<ServerState>{

  /// Singleton instance constructor
  factory ServerCubit() => _instance;
  ServerCubit._() : super(ServerState());
  static final ServerCubit _instance = ServerCubit._();


  final Map<String, DesktopCubit> _activeDesktopConnections = {};
  final Map<String, (String , PlayerCubit)> _activePlayerConnections = {};


  /// Procesa nuevas conexiones de players websocket
  void handleNewPlayerConnection(WebSocketChannel channel){
    final playerSession = const Uuid().v4();

    PlayerCubit(
      channel,
      playerNumber: _activePlayerConnections.length,

      // player connected
      onPlayerAuth: (playerId, playerCubit) { 
        _activePlayerConnections[playerSession] = (playerId, playerCubit);
      },
      
      onPlayerStateUpdated: (playerState) {
        emit(state.upsertPlayerState(playerState));
      },

      onPlayerPingUpdated: (playerId , ping){},

      onPlayerDisconnect: (playerId){
        _activePlayerConnections.remove(playerSession);
        if(!_activePlayerConnections.values.any((pair) => pair.$1 == playerId)){
          emit(state.removePlayerState(playerId));
        }
      }
    );

  }   

  /// Procesa nuevas conexiones desktop websocket
  void handleNewDesktopConnection(WebSocketChannel channel){
    final clientId = const Uuid().v4();    
    
    final desktopCubit = DesktopCubit(
      channel, 
      desktopClientId: clientId, 
      onDisconnect   : _activeDesktopConnections.remove,
      onShoutDownServer: close,
    )..send(
      PlayerListUpdated(playerList: state.playersState)
    );

    _activeDesktopConnections[clientId] = desktopCubit;
  }

  @override
  void onChange(Change<ServerState> change) {
    _activeDesktopConnections.forEach(
      (_, cubit) => cubit.send(
        PlayerListUpdated(playerList: change.nextState.playersState)
      )
    );
    
    super.onChange(change);
  }

  @override
  Future<void> close() {
    ServerController().shoutDown();    
    for(final playerCubit in _activePlayerConnections.values){
      playerCubit.$2.close();
    }
    for(final desktopCubit in _activeDesktopConnections.values){
      desktopCubit.close();
    }
    _activePlayerConnections.clear();
    _activeDesktopConnections.clear();

    return super.close();
  }
}
