// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class BoxShapeAdapter extends TypeAdapter<BoxShape> {
  @override
  final typeId = 0;

  @override
  BoxShape read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BoxShape.rectangle;
      case 1:
        return BoxShape.circle;
      default:
        return BoxShape.rectangle;
    }
  }

  @override
  void write(BinaryWriter writer, BoxShape obj) {
    switch (obj) {
      case BoxShape.rectangle:
        writer.writeByte(0);
      case BoxShape.circle:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoxShapeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ButtonAdapter extends TypeAdapter<Button> {
  @override
  final typeId = 1;

  @override
  Button read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Button(
      buttonData: fields[0] as ButtonData,
      buttonType: fields[1] == null ? .sinlgePress : fields[1] as ButtonType,
      buttonCode: fields[4] as PlayerButton,
    );
  }

  @override
  void write(BinaryWriter writer, Button obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.buttonData)
      ..writeByte(1)
      ..write(obj.buttonType)
      ..writeByte(4)
      ..write(obj.buttonCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ButtonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayerButtonAdapter extends TypeAdapter<PlayerButton> {
  @override
  final typeId = 2;

  @override
  PlayerButton read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PlayerButton.btnA;
      case 1:
        return PlayerButton.btnB;
      case 2:
        return PlayerButton.btnX;
      case 3:
        return PlayerButton.btnY;
      case 4:
        return PlayerButton.dpad;
      case 5:
        return PlayerButton.lb;
      case 6:
        return PlayerButton.rb;
      case 7:
        return PlayerButton.lt;
      case 8:
        return PlayerButton.rt;
      case 9:
        return PlayerButton.ls;
      case 10:
        return PlayerButton.rs;
      case 11:
        return PlayerButton.view;
      case 12:
        return PlayerButton.menu;
      case 13:
        return PlayerButton.xbox;
      default:
        return PlayerButton.btnA;
    }
  }

  @override
  void write(BinaryWriter writer, PlayerButton obj) {
    switch (obj) {
      case PlayerButton.btnA:
        writer.writeByte(0);
      case PlayerButton.btnB:
        writer.writeByte(1);
      case PlayerButton.btnX:
        writer.writeByte(2);
      case PlayerButton.btnY:
        writer.writeByte(3);
      case PlayerButton.dpad:
        writer.writeByte(4);
      case PlayerButton.lb:
        writer.writeByte(5);
      case PlayerButton.rb:
        writer.writeByte(6);
      case PlayerButton.lt:
        writer.writeByte(7);
      case PlayerButton.rt:
        writer.writeByte(8);
      case PlayerButton.ls:
        writer.writeByte(9);
      case PlayerButton.rs:
        writer.writeByte(10);
      case PlayerButton.view:
        writer.writeByte(11);
      case PlayerButton.menu:
        writer.writeByte(12);
      case PlayerButton.xbox:
        writer.writeByte(13);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerButtonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OffsetAdapter extends TypeAdapter<Offset> {
  @override
  final typeId = 3;

  @override
  Offset read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Offset((fields[0] as num).toDouble(), (fields[1] as num).toDouble());
  }

  @override
  void write(BinaryWriter writer, Offset obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dx)
      ..writeByte(1)
      ..write(obj.dy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OffsetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ControllerAdapter extends TypeAdapter<Controller> {
  @override
  final typeId = 4;

  @override
  Controller read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Controller(
      id: fields[0] as String?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      lastEdited: fields[3] as DateTime?,
      buttonGroups: fields[5] == null
          ? const []
          : (fields[5] as List).cast<PositionedButtonGroup>(),
    );
  }

  @override
  void write(BinaryWriter writer, Controller obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.lastEdited)
      ..writeByte(5)
      ..write(obj.buttonGroups);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ControllerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ButtonGroupAdapter extends TypeAdapter<ButtonGroup> {
  @override
  final typeId = 6;

  @override
  ButtonGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ButtonGroup(
      buttons: (fields[6] as List).cast<Button>(),
      screenRelativeSize: fields[7] == null
          ? 0.23
          : (fields[7] as num).toDouble(),
      internalMargin: fields[8] == null ? 0.01 : (fields[8] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, ButtonGroup obj) {
    writer
      ..writeByte(3)
      ..writeByte(6)
      ..write(obj.buttons)
      ..writeByte(7)
      ..write(obj.screenRelativeSize)
      ..writeByte(8)
      ..write(obj.internalMargin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ButtonGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ButtonDataAdapter extends TypeAdapter<ButtonData> {
  @override
  final typeId = 7;

  @override
  ButtonData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ButtonData(
      label: fields[6] as String,
      shape: fields[0] == null ? .circle : fields[0] as BoxShape,
      backgroundColorValue: (fields[1] as num?)?.toInt(),
      borderColorValue: (fields[2] as num?)?.toInt(),
      colorValue: (fields[3] as num?)?.toInt(),
      borderWidth: fields[5] == null ? 1 : (fields[5] as num).toDouble(),
      borderRadius: fields[7] == null ? 10 : (fields[7] as num).toDouble(),
      elevation: fields[4] == null ? 0 : (fields[4] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ButtonData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.shape)
      ..writeByte(1)
      ..write(obj.backgroundColorValue)
      ..writeByte(2)
      ..write(obj.borderColorValue)
      ..writeByte(3)
      ..write(obj.colorValue)
      ..writeByte(4)
      ..write(obj.elevation)
      ..writeByte(5)
      ..write(obj.borderWidth)
      ..writeByte(6)
      ..write(obj.label)
      ..writeByte(7)
      ..write(obj.borderRadius);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ButtonDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PositionedButtonGroupAdapter extends TypeAdapter<PositionedButtonGroup> {
  @override
  final typeId = 10;

  @override
  PositionedButtonGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionedButtonGroup(
      buttonGroup: fields[0] as ButtonGroup,
      relativePosition: fields[1] == null
          ? const Offset(0.5, 0.5)
          : fields[1] as Offset,
    );
  }

  @override
  void write(BinaryWriter writer, PositionedButtonGroup obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.buttonGroup)
      ..writeByte(1)
      ..write(obj.relativePosition);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionedButtonGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ButtonTypeAdapter extends TypeAdapter<ButtonType> {
  @override
  final typeId = 11;

  @override
  ButtonType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ButtonType.sinlgePress;
      case 1:
        return ButtonType.joystick;
      case 2:
        return ButtonType.tactilPanel;
      default:
        return ButtonType.sinlgePress;
    }
  }

  @override
  void write(BinaryWriter writer, ButtonType obj) {
    switch (obj) {
      case ButtonType.sinlgePress:
        writer.writeByte(0);
      case ButtonType.joystick:
        writer.writeByte(1);
      case ButtonType.tactilPanel:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ButtonTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  final typeId = 12;

  @override
  Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      deviceId: fields[1] as String,
      deviceName: fields[0] as String,
      name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.deviceName)
      ..writeByte(1)
      ..write(obj.deviceId)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
