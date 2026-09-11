import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inputThemeProvider = Provider((ref){
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  );
  
  return InputDecorationTheme(
    border: border,
  );
});