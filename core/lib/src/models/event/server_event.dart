import 'dart:convert';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core/src/models/event/_event.dart';
import 'package:core/src/models/event/_event_code.dart';

/// eventos generados por el server
sealed class ServerEvent implements Event{
  const ServerEvent();

  @override
  EventCode get eventCode => EventCode.serverEvent;


  factory ServerEvent.decode(dynamic source){
    final data = source as Uint8List;
    final (code, subCode) = Event.getInt4FromInt8(data[0]); 

    return switch (subCode) {
      1 => PlayerInfoRequestServerEvent(),
      2 => PlayerPingUpdated.decode(data),
      3 => PlayerListUpdated.decode(data),

      _ => throw FormatException('Unknown ServerEvent code: $subCode'),
    };
  } 
}


/// Pedir datos al usuario
class PlayerInfoRequestServerEvent extends ServerEvent{
  @override
  Uint8List encode() => Uint8List.fromList([
    Event.getInt8FromInt4(eventCode.code, 1)
  ]);
}


/// eventos al desktop
class PlayerPingUpdated extends ServerEvent{
  final String playerId;
  final int pingOnMs;

  PlayerPingUpdated({
    required this.playerId,
    this.pingOnMs = -1
  });

  @override
  Uint8List encode() {
    final encodedPlayerId = utf8.encode(playerId);
    final result = Uint8List(2 + encodedPlayerId.length);
    result[0]    = Event.getInt8FromInt4(eventCode.code, 2);  
    result[1]    = pingOnMs;
    result.setRange(2, result.length, encodedPlayerId);
    return result;
  }

  factory PlayerPingUpdated.decode(Uint8List data){
    final String playerId = utf8.decode(data.sublist(2))
      .replaceAll('\uFEFF', '')
      .replaceAll('\x00', '')
      .trim();

    return PlayerPingUpdated(
      playerId: playerId,
      pingOnMs: data[1]
    );   
  }
}


/// eventos al desktop
class PlayerListUpdated extends ServerEvent{
  final List<PlayerState> playerList;
  
  PlayerListUpdated({
    required this.playerList
  });

  @override
  Uint8List encode() {
    final playerSource = utf8.encode(
      jsonEncode(playerList.map((i) => i.toJson()).toList())
    );

    final result = Uint8List(1 + playerSource.length);
    result[0] = Event.getInt8FromInt4(eventCode.code, 3);
    result.setRange(1, result.length, playerSource);

    return result;
  }

  factory PlayerListUpdated.decode(Uint8List data){
    final String rawPlayerList = utf8.decode(data.sublist(1))
      .replaceAll('\uFEFF', '')
      .replaceAll('\x00', '')
      .trim();

    final playerList = jsonDecode(rawPlayerList) as List;

    return PlayerListUpdated(
      playerList: playerList.map(
        (i) => PlayerState.fromJson(i)
      ).toList()
    );
  }

}
