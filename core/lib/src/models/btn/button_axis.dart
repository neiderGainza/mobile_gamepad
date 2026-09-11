enum ButtonAxis {
  depth(0),
  horizontal(1),
  vertical(2);

  final int code;
  const ButtonAxis(this.code);


  static ButtonAxis fromCode(int code) {
    for (final b in ButtonAxis.values) {
      if (b.code == code) return b;
    }
    throw ArgumentError('Código axis inválido: $code');
  }

}