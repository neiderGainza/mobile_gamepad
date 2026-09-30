import 'dart:convert';
import 'dart:typed_data';
import 'package:core/core.dart';
import 'package:core/src/models/event/_event_code.dart';


/// eventos generados por el player
sealed class PlayerEvent implements Event{
  const PlayerEvent();

  @override
  EventCode get eventCode => EventCode.playerEvent;

  factory PlayerEvent.decode(dynamic source) {
    final data = source as Uint8List;
    final (code, subCode) = Event.getInt4FromInt8(data[0]); 


    return switch (subCode) {
      0 => ButtonPlayerEvent.decode(data),
      1 => UpdateInfoPlayerEvent.decode(data),
      2 => DisconnectPlayerEvent(),
      3 => MultiButtonPlayerEvent.decode(data),

      _ => throw FormatException('Unknown PlayerEvent code: $subCode'),
    };
  }
}


class ButtonPlayerEvent extends PlayerEvent {
  final PlayerButton btn; 
  final ButtonAxis axis; 
  final int _val; // int8 -128<=_val<=127

  double get value {
    if (_val < 0) return _val / 128.0;
    return _val / 127.0;
  }

  ButtonPlayerEvent({
    required this.btn,
    required this.axis,
    required double value,
  }) : _val = (value.clamp(-1.0, 1.0) * (value < 0 ? 128 : 127)).round();

  ButtonPlayerEvent._(
    this.btn,
    this.axis,
    this._val,
  );

  factory ButtonPlayerEvent.decode(Uint8List data) {
    final (axis, btn) = getAxisAndBtnFromInt8(data[1]);
    final bd = ByteData.sublistView(data);
    return ButtonPlayerEvent._(
      btn, axis, bd.getInt8(2),
    );
  }

  @override
  Uint8List encode() {
    final result = Uint8List(3); 
    result[0] = Event.getInt8FromInt4(eventCode.code, 0);
    result[1] = getInt8FromAxisAndBtn(axis, btn);
    result[2] = _val;
    return result;
  }
    
  static (ButtonAxis , PlayerButton) getAxisAndBtnFromInt8(int source){
    int axisCode = 0, btnCode = 0;

    for(int bit = 0; bit < 6; bit++){
      btnCode = btnCode | (source & (1 << bit));
    }
    for(int bit = 6; bit < 8; bit ++){
      axisCode = axisCode | (source & (1 << bit));
    }

    return (
      ButtonAxis.fromCode(axisCode >> 6),
      PlayerButton.fromCode(btnCode)
    );
  }

  static int getInt8FromAxisAndBtn(ButtonAxis axis, PlayerButton btn){
    return btn.code | (axis.code<<6);
  }

}


class MultiButtonPlayerEvent extends PlayerEvent{
  final List<ButtonPlayerEvent> buttonPlayerEvents;

  const MultiButtonPlayerEvent({
    required this.buttonPlayerEvents
  });


  @override
  Uint8List encode() {
    final result = Uint8List(1 + 2 * buttonPlayerEvents.length);
    result[0] = Event.getInt8FromInt4(eventCode.code, 3);

    for(int i =0; i < buttonPlayerEvents.length; i++){
      final encodedEvent = buttonPlayerEvents[i].encode();

      result.setRange(
        1 + i * 2, 
        3 + i * 2,
        encodedEvent.sublist(1)
      );
    }

    return result;
  }


  factory MultiButtonPlayerEvent.decode(Uint8List data){
    return MultiButtonPlayerEvent(
      buttonPlayerEvents: [
        for(int i = 0 ; i < (data.length / 2).toInt() ; i++ )
        ButtonPlayerEvent.decode(
          Uint8List.fromList([0 , data[1 + i*2] , data[2 + i*2]])
        )
      ]
    );
  }
}


class UpdateInfoPlayerEvent extends PlayerEvent implements IdentiafiableEvent{
  final Player player;
  final int id; // int8

  const UpdateInfoPlayerEvent({
    required this.player,
    required this.id
  });

  factory UpdateInfoPlayerEvent.decode(Uint8List data) {  

    final String playerSource = utf8.decode(data.sublist(2))
      .replaceAll('\uFEFF', '')
      .replaceAll('\x00', '')
      .trim();
      
    return UpdateInfoPlayerEvent( 
      id: data[1],
      player: Player.fromJson(jsonDecode(playerSource)),
    );
  }

  @override
  Uint8List encode() {
    final playerSource = utf8.encode(jsonEncode(player.toJson()));
    final result = Uint8List(2 + playerSource.length);
    final bd = ByteData.sublistView(result);

    bd.setInt8(0, Event.getInt8FromInt4(eventCode.code, 1));
    bd.setInt8(1, id); // id

    result.setRange(2, result.length, playerSource);
    return result;
  }
}


class DisconnectPlayerEvent extends PlayerEvent {
  @override
  Uint8List encode() => Uint8List.fromList([
    Event.getInt8FromInt4(eventCode.code, 2)
  ]);
}


