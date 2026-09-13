sealed class VirtualDeviceEvent {
  const VirtualDeviceEvent();
}


class VibrationVDEvent extends VirtualDeviceEvent{
  final int value; // if 0 stops if more repetitions
  final int id;

  const VibrationVDEvent({
    required this.id,
    required this.value
  });
}