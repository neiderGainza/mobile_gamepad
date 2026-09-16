enum ButtonAxis {
  depth(0),
  horizontal(1),
  vertical(2);

  final int code; // up to 4 (0 , 1 ,  2 , 3)
  const ButtonAxis(this.code);


  static ButtonAxis fromCode(int code) {
    for (final b in ButtonAxis.values) {
      if (b.code == code) return b;
    }
    throw ArgumentError('Código axis inválido: $code');
  }


}