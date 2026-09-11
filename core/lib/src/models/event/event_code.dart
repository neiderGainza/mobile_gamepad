enum EventCode {
  ping(1),
  pong(2),
  serverEvent(3),
  playerEvent(4);

  final int code;
  const EventCode(this.code);
}