import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';

class OffsetJsonConverter implements JsonConverter<Offset, Map<String, dynamic>> {
  const OffsetJsonConverter();

  @override
  Offset fromJson(Map<String, dynamic> json) {
    return Offset(
      (json['dx'] as num).toDouble(),
      (json['dy'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson(Offset object) {
    return {
      'dx': object.dx,
      'dy': object.dy,
    };
  }
}