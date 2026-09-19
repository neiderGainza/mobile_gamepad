enum EventCode {
  check(0),
  ping(1),
  pong(2),
  serverEvent(3),
  playerEvent(4),
  virtualDevice(5),
  desktopEvent(6);
  
  final int code;
  const EventCode(this.code);
}