import 'dart:typed_data';

import 'package:core/src/models/event/event_code.dart';

abstract interface class Event {
  EventCode get eventCode;
  Uint8List encode();
}