import 'package:bloc/bloc.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:server/player_cubit.dart';
import 'package:server/server_state.dart';
import 'package:uuid/uuid.dart';


/// a way to identified in a unique way the controller for the user
/// avoid race conditions
typedef UniqueIdentifier = ({String userId, String uuid});

///
class ServerCubit extends Cubit<ServerState>{
  
  /// Singleton instance constructor
  factory ServerCubit() => _instance;
  ServerCubit._() : super(ServerState());
  static final ServerCubit _instance = ServerCubit._();

  final Map<UniqueIdentifier, PlayerCubit> _activeConnections = {};

  /// Procesa nuevas conexiones websocket
  void handleNewPlayerConnection(WebSocketChannel channel){
    final uuid = Uuid().v4();    
  
    PlayerCubit(
      channel,
      playerNumber: _activeConnections.length,
      onPlayerAuth: (playerId, bloc) { 
        _activeConnections[(userId: playerId, uuid: uuid)] = bloc; 
      },
      
      onPlayerStateUpdated: (playerState) {
        emit(state.upsertPlayer(playerState));  
      },

      /// ActiveConnection Remove
      onPlayerDisconnect: (playerId) {
        _activeConnections.remove( (userId: playerId, uuid: uuid));
      },
    );

  } 

}
