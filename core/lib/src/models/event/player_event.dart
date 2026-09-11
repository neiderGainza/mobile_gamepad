import 'dart:convert';
import 'dart:typed_data';
import 'package:core/core.dart';
import 'package:core/src/models/event/event.dart';
import 'package:core/src/models/event/event_code.dart';


/// eventos generados por el player
sealed class PlayerEvent implements Event{
  const PlayerEvent();

  @override
  EventCode get eventCode => EventCode.playerEvent;

  static bool isPlayerEvent(dynamic source){
    if(source is Uint8List){
      return source[0] == EventCode.playerEvent.code;
    }
    return false;
  }

  factory PlayerEvent.decode(dynamic source) {
    if(!isPlayerEvent(source)){
      throw FormatException('Invalid input for PlayerEvent.decode');
    }

    final data = source as Uint8List;
    final eventSubCode = data[1];
    
    return switch (eventSubCode) {
      0 => ButtonPlayerEvent.decode(data.sublist(2)),
      1 => UpdateInfoPlayerEvent.decode(data.sublist(2)),
      2 => DisconnectPlayerEvent(),
      
      _ => throw FormatException('Unknown PlayerEvent code: $eventSubCode'),
    };
  }
}


class ButtonPlayerEvent extends PlayerEvent {
  final PlayerButton btn; 
  final ButtonAxis axis; 
  final int _val; // int32
  double get value => (_val / 32767);

  ButtonPlayerEvent({
    required this.btn,
    required this.axis,
    required double value,
  }) : _val = (value * 32767).round();

  ButtonPlayerEvent._(
    this.btn,
    this.axis,
    this._val,
  );

  factory ButtonPlayerEvent.decode(Uint8List data) {
    final bd = ByteData.sublistView(data);

    return ButtonPlayerEvent._(
      PlayerButton.fromCode(bd.getInt8(0)),
      ButtonAxis.fromCode(bd.getInt8(1)),
      bd.getInt16(2, Endian.big),
    );
  }

  @override
  Uint8List encode() {
    final result = Uint8List(6);
    result[0] = eventCode.code;  // eventCode
    result[1] = 0;  // subEventCode
    result[2] = btn.code; 
    result[3] = axis.code;

    final bd = ByteData.sublistView(result, 4);
    bd.setInt16(0, _val, Endian.big);

    return result;
  }
}


class UpdateInfoPlayerEvent extends PlayerEvent {
  final Player player;

  const UpdateInfoPlayerEvent({required this.player});

  factory UpdateInfoPlayerEvent.decode(Uint8List data) {    
    final String playerSource = utf8.decode(data);
    
    return UpdateInfoPlayerEvent( 
      player: Player.fromJson(jsonDecode(playerSource)),
    );
  }

  @override
  Uint8List encode() {
    final playerSource = utf8.encode(jsonEncode(player.toJson()));
    final result = Uint8List(2 + playerSource.length);
    
    result[0] = eventCode.code; // eventCode
    result[1] = 1; // subEventCode

    result.setRange(2, 2 + playerSource.length, playerSource);
    return result;
  }
}


class DisconnectPlayerEvent extends PlayerEvent {
  @override
  Uint8List encode() => Uint8List.fromList([eventCode.code, 2]);
}


