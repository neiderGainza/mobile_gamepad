import 'package:json_annotation/json_annotation.dart';

class DurationJsonConverter implements JsonConverter<Duration, int> {
  const DurationJsonConverter();
  
  @override
  Duration fromJson(int source) {
    return Duration(milliseconds: source);
  }

  @override
  int toJson(Duration duration) {
    return duration.inMilliseconds;
  }
}