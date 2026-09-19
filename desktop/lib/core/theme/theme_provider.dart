import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = NotifierProvider(ThemeNotifier.new);

class ThemeNotifier extends Notifier<ThemeState>{
  
  @override
  ThemeState build() => ThemeState(themeMode: .system);


  ThemeData get lightTheme => ThemeData(
    colorScheme: .fromSeed(seedColor: Colors.deepOrange, brightness: .light),
  );

  ThemeData get darkTheme => ThemeData(
    colorScheme: .fromSeed(seedColor: Colors.deepOrange, brightness: .dark),
  );
}

// Can add color change etc
class ThemeState{
  final ThemeMode themeMode;

  const ThemeState({
    required this.themeMode
  });
}