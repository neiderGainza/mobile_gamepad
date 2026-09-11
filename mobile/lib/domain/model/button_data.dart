import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'button_data.freezed.dart';
part 'button_data.g.dart';


/// Encargado de definir la manera en la que el boton se dibuja en pantalla
@freezed
@JsonSerializable()
class ButtonData with _$ButtonData{  
  final BoxShape shape;
  
  final int ? backgroundColorValue;
  final int ? borderColorValue;
  final int ? colorValue;

  final int elevation;
  final double ? borderWidth;
  final String label;
  final int ? borderRadius;

  const ButtonData({
    required this.label,
    this.shape = .circle,
    this.backgroundColorValue,
    this.borderColorValue,
    this.colorValue,
    this.borderWidth,
    this.borderRadius,
    this.elevation = 0,
  });

  Color ? get backgroundColor => backgroundColorValue != null 
    ? Color(backgroundColorValue!) 
    : null;

  Color ? get borderColor => borderColorValue != null 
    ? Color(borderColorValue!)
    : null;

  Color ? get color => colorValue != null 
    ? Color(colorValue!)
    : null;


  static ButtonData fromJson(Map json) => _$ButtonDataFromJson(
    Map<String,dynamic>.from(json)
  );
  Map<String, dynamic> toJson() => _$ButtonDataToJson(this);
}

