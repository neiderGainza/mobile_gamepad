import 'package:core/core.dart';

/// Estado del servidor
/// Lista de jugarores [players] con metadatos
class ServerState{
  /// Inicializa el estado a partir de una lista de jugadores
  /// Cada uno inicia sin metadata
  ServerState({
    List<Player> playerList = const []
  }) : players = [
    for(final player in playerList)
    PlayerState(player: player)
  ];   
  
  ServerState._({required this.players});


  /// lista de jugares historica, tantos conectados como desconectados
  final List<PlayerState> players;

  /// Lista de jugaroes conectados
  List<PlayerState> get connectedPlayers => players.where(
    (p) => p.connectionStatus == .connected).toList();
  
  /// Lista de jugadores desconectados
  List<PlayerState> get disconnectedPlayers => players.where(
    (p) => p.connectionStatus == .disconnected).toList();
  
  
  /// inserta o actualiza el player dado
  ServerState upsertPlayer(PlayerState player){
    if(players.contains(player)){
      return ServerState._(players: [
        for(final p in players)
        if(p == player) player
        else p
      ]);
    }else{
      return ServerState._(players: [
        ... players,
        player
      ]);
    }
  }

  /// remueve player de la lista
  ServerState removePlayer(String playerId){
    return ServerState._(players: [
      for(final p in players)
      if(p.player.id != playerId)
      p
    ]);
  }
}
