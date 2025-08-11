export 'icons.dart';

import 'package:flutter/material.dart';

/// Design system themes for the e-commerce app
class EcDesignTheme {
  EcDesignTheme._();

  /// Light theme for the e-commerce app
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6750A4),
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      fontFamily: 'e_commerce_icon',
    );
  }

  /// Dark theme for the e-commerce app
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6750A4),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      fontFamily: 'e_commerce_icon',
    );
  }
}
