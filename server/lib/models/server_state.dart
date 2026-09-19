import 'package:core/core.dart';
import 'package:core/src/models/player/player_state.dart';

/// Estado del servidor
/// Lista de jugarores [players] con metadatos
class ServerState{
  /// Inicializa el estado a partir de una lista de jugadores
  /// Cada uno inicia sin metadata
  ServerState({
    List<Player> playerList = const []
  }) : playersState = [
    for(final player in playerList)
    PlayerState(player: player)
  ];   
  
  ServerState._({required this.playersState});


  /// lista de jugares historica, tantos conectados como desconectados
  final List<PlayerState> playersState;

  /// Lista de jugaroes conectados
  List<PlayerState> get connectedPlayersState => playersState.where(
    (p) => p.connectionStatus == .connected).toList();
  
  /// Lista de jugadores desconectados
  List<PlayerState> get disconnectedPlayersState => playersState.where(
    (p) => p.connectionStatus == .disconnected).toList();
  
  
  /// inserta o actualiza el player dado
  ServerState upsertPlayerState(PlayerState playerState){
    
    if(playersState.any(
      (ps) => ps.player == playerState.player )
    ){
      return ServerState._(playersState: [
        for(final p in playersState)
        if(p.player == playerState.player) playerState
        else p
      ]);
    }else{
      return ServerState._(playersState: [
        ... playersState,
        playerState
      ]);
    }
  }

  /// remueve player de la lista
  ServerState removePlayerState(String playerId){
    return ServerState._(playersState: [
      for(final ps in playersState)
      if(ps.player.id != playerId)
      ps
    ]);
  }
}
