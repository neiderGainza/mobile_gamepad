enum PlayerButton {
  btnA(0),
  btnB(1),
  btnX(2),
  btnY(3),

  dpad(4),

  lb(5),
  rb(6),

  lt(7),
  rt(8),

  ls(9), 
  rs(10),

  view(11), 
  menu(12), 
  xbox(13);

  final int code; // up to 64 (int6)
  const PlayerButton(this.code);

  static PlayerButton fromCode(int code) {
    for (final b in PlayerButton.values) {
      if (b.code == code) return b;
    }
    throw ArgumentError('Código de botón inválido: $code');
  }

}
