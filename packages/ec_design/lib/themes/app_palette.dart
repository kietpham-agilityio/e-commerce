import 'package:flutter/material.dart';

enum App { user, admin }

class EcLightPalette {
  static const MaterialColor ecRed = MaterialColor(
    0xFFDB3022, // Base color (shade 500)
    <int, Color>{
      50: Color(0xFFFFEBE9),
      100: Color(0xFFFFCDC9),
      200: Color(0xFFFFACA6),
      300: Color(0xFFFF8A82),
      400: Color(0xFFFF6E65),
      500: Color(0xFFDB3022), // primary
      600: Color(0xFFD32626), // shadow
      700: Color(0xFFF01F0E), // error
      800: Color(0xFFB71C1C),
      900: Color(0xFF8C1818),
    },
  );

  static const MaterialColor ecOrange = MaterialColor(
    0xFFF27D00,
    {
      50: Color(0xFFFFF2E5),
      100: Color(0xFFFFDEB8),
      200: Color(0xFFFFC98A),
      300: Color(0xFFFFB35C),
      400: Color(0xFFFF9E2E),
      500: Color(0xFFF27D00), // default
      600: Color(0xFFD46E00),
      700: Color(0xFFB75F00),
      800: Color(0xFF994F00),
      900: Color(0xFF7C4000),
    },
  );

  static const MaterialColor ecWhite = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFDFDFD),
      200: Color(0xFFFCFCFC),
      300: Color(0xFFFAFAFA),
      400: Color(0xFFF9F9F9), // background
      500: Color(0xFFFFFFFF), // default
      600: Color(0xFFEDEDED),
      700: Color(0xFFDFDFDF),
      800: Color(0xFFD1D1D1),
      900: Color(0xFFB3B3B3),
    },
  );

  static const MaterialColor ecGreen = MaterialColor(
    0xFF2AA952, // shade 500 (base)
    <int, Color>{
      50: Color(0xFFF2FAF4),
      100: Color(0xFFDFF4E4),
      200: Color(0xFFBFF0C9),
      300: Color(0xFF9FEBAE),
      400: Color(0xFF7FE890),
      500: Color(0xFF2AA952),
      600: Color(0xFF249F4C),
      700: Color(0xFF208A42),
      800: Color(0xFF1B7538),
      900: Color(0xFF145A28),
    },
  );

  static const MaterialColor ecGrey = MaterialColor(
    0xFF9B9B9B, // default
    <int, Color>{
      50: Color(0xFFF5F5F5),
      100: Color(0xFFE0E0E0),
      200: Color(0xFFCCCCCC),
      300: Color(0xFFB3B3B3),
      400: Color(0xFFA6A6A6),
      500: Color(0xFF9B9B9B), // default
      600: Color(0xFF8C8C8C),
      700: Color(0xFF7D7D7D),
      800: Color(0xFF5F5F5F),
      900: Color(0xFF424242),
    },
  );

  static const MaterialColor ecBlack = MaterialColor(
    0xFF222222, // default
    <int, Color>{
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF5F5F5),
      200: Color(0xFFEEEEEE),
      300: Color(0xFFE0E0E0),
      400: Color(0xFFBDBDBD),
      500: Color(0xFF9E9E9E),
      600: Color(0xFF616161),
      700: Color(0xFF424242),
      800: Color(0xFF303030),
      900: Color(0xFF222222), // default
    },
  );
}

class EcDarkPalette {
  static const MaterialColor ecRed = MaterialColor(
    0xFFDB3022,
    <int, Color>{
      50: Color(0xFF8C1818),
      100: Color(0xFFB71C1C),
      200: Color(0xFFF01F0E),
      300: Color(0xFFD32626),
      400: Color(0xFFDB3022),
      500: Color(0xFFDB3022), // primary
      600: Color(0xFFFF6E65), // shadow
      700: Color(0xFFFF8A82), // error highlight
      800: Color(0xFFFFACA6),
      900: Color(0xFFFFCDC9),
    },
  );

  static const MaterialColor ecOrange = MaterialColor(
    0xFFF27D00,
    {
      50: Color(0xFF7C4000),
      100: Color(0xFF994F00),
      200: Color(0xFFB75F00),
      300: Color(0xFFD46E00),
      400: Color(0xFFF27D00),
      500: Color(0xFFF27D00),
      600: Color(0xFFFF9E2E),
      700: Color(0xFFFFB35C),
      800: Color(0xFFFFC98A),
      900: Color(0xFFFFDEB8),
    },
  );

  static const MaterialColor ecWhite = MaterialColor(
    0xFF121212, // Dark base background
    <int, Color>{
      50: Color(0xFF121212),
      100: Color(0xFF1E1E1E),
      200: Color(0xFF2C2C2C),
      300: Color(0xFF383838),
      400: Color(0xFF424242), // background
      500: Color(0xFFB3B3B3),
      600: Color(0xFFCFCFCF),
      700: Color(0xFFE5E5E5),
      800: Color(0xFFF5F5F5),
      900: Color(0xFFFFFFFF),
    },
  );

  static const MaterialColor ecGreen = MaterialColor(
    0xFF2AA952,
    <int, Color>{
      50: Color(0xFF145A28),
      100: Color(0xFF1B7538),
      200: Color(0xFF208A42),
      300: Color(0xFF249F4C),
      400: Color(0xFF2AA952),
      500: Color(0xFF2AA952),
      600: Color(0xFF7FE890),
      700: Color(0xFF9FEBAE),
      800: Color(0xFFBFF0C9),
      900: Color(0xFFDFF4E4),
    },
  );

  static const MaterialColor ecGrey = MaterialColor(
    0xFFB3B3B3,
    <int, Color>{
      50: Color(0xFF1C1C1C),
      100: Color(0xFF2C2C2C),
      200: Color(0xFF3D3D3D),
      300: Color(0xFF4E4E4E),
      400: Color(0xFF5F5F5F),
      500: Color(0xFFB3B3B3), // default
      600: Color(0xFFCCCCCC),
      700: Color(0xFFDADADA),
      800: Color(0xFFE8E8E8),
      900: Color(0xFFF5F5F5),
    },
  );

  static const MaterialColor ecBlack = MaterialColor(
    0xFF000000, // default
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF0A0A0A),
      200: Color(0xFF121212),
      300: Color(0xFF1E1E1E),
      400: Color(0xFF2C2C2C),
      500: Color(0xFF383838),
      600: Color(0xFF424242),
      700: Color(0xFF5C5C5C),
      800: Color(0xFF7D7D7D),
      900: Color(0xFF9E9E9E),
    },
  );
}
