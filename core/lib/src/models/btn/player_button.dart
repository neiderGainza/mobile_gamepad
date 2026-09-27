enum PlayerButton {
  btnA(0, "A"),
  btnB(1, "B"),
  btnX(2, "C"),
  btnY(3, "D"),

  dpad(4, "Dpad", hasAxis: true),

  lb(5, "LB"),
  rb(6, "RB"),

  lt(7, "LT"),
  rt(8, "RT"),

  ls(9, "LJ", hasAxis: true), 
  rs(10,"RJ", hasAxis: true),

  view(11, "View", isMenu: true), 
  menu(12, "Menu", isMenu: true), 
  xbox(13, "Xbox", isMenu: true);

  final int code; // up to 64 (int6)
  final bool hasAxis;
  final bool isMenu;
  final String i10n;
  const PlayerButton(this.code, this.i10n, {
    this.hasAxis = false,
    this.isMenu = false
  });

  static PlayerButton fromCode(int code) {
    for (final b in PlayerButton.values) {
      if (b.code == code) return b;
    }
    throw ArgumentError('Código de botón inválido: $code');
  }

}
