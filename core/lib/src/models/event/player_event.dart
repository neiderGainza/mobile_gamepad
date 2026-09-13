import 'dart:convert';
import 'dart:typed_data';
import 'package:core/core.dart';
import 'package:core/src/models/event/_event.dart';
import 'package:core/src/models/event/_event_code.dart';


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

  double get value {
    if (_val < 0) return _val / 32768.0;
    return _val / 32767.0;
  }

  ButtonPlayerEvent({
    required this.btn,
    required this.axis,
    required double value,
  }) : _val = (value.clamp(-1.0, 1.0) * (value < 0 ? 32768 : 32767)).round();

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


class UpdateInfoPlayerEvent extends PlayerEvent implements IdentiafiableEvent{
  /// this can grow 
  final Player player;
  final int id; // int8

  const UpdateInfoPlayerEvent({
    required this.player,
    required this.id
  });

  factory UpdateInfoPlayerEvent.decode(Uint8List data) {  

    final String playerSource = utf8.decode(data.sublist(1))
      .replaceAll('\uFEFF', '')
      .replaceAll('\x00', '')
      .trim();
      
    return UpdateInfoPlayerEvent( 
      id: data[0],
      player: Player.fromJson(jsonDecode(playerSource)),
    );
  }

  @override
  Uint8List encode() {
    final playerSource = utf8.encode(jsonEncode(player.toJson()));
    final result = Uint8List(3 + playerSource.length);
    final bd = ByteData.sublistView(result);

    bd.setInt8(0, eventCode.code); // eventCode
    bd.setInt8(1, 1);   // subEventCode
    bd.setInt8(2, id); // id

    result.setRange(3, result.length, playerSource);
    return result;
  }
}


class DisconnectPlayerEvent extends PlayerEvent {
  @override
  Uint8List encode() => Uint8List.fromList([eventCode.code, 2]);
}


