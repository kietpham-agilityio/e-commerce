import 'package:flutter/material.dart';

class EcPalette {
  static const MaterialColor red = MaterialColor(
    0xFFDB3022,
    <int, Color>{
      1: Color(0xFFDB3022),
      2: Color(0xFFF01F0E),
    },
  );

  static const MaterialColor white = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      1: Color(0xFFFFFFFF),
      2: Color(0xFFF9F9F9),
    },
  );

  // Dark mode neutral palette
  static const MaterialColor black = MaterialColor(
    0xFF000000,
    <int, Color>{
      1: Color(0xFF000000),
      2: Color(0xFF121212),
    },
  );

  static const MaterialColor darkGrey = MaterialColor(
    0xFF2C2C2E,
    <int, Color>{
      1: Color(0xFF1E1E1E),
      2: Color(0xFF2C2C2E),
    },
  );

  static const Color genericBlack = Color(0xFF222222);
  static const Color genericGrey = Color(0xFF9B9B9B);
  static const Color genericGreen = Color(0xFF2AA952);
}
