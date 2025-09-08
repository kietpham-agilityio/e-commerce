import 'package:flutter/material.dart';

class EcDarkPalette {
  static const int _redPrimaryColor = 0xFFe2594e;
  static const int _orangePrimaryColor = 0xFFf59733;
  static const int _errorPrimaryColor = 0xFFf34c3e;
  static const int _whitePrimaryColor = 0xFFFFFFFF;
  static const int _greenPrimaryColor = 0xFF55ba75;
  static const int _grayPrimaryColor = 0xFFafafaf;
  static const int _blackPrimaryColor = 0xFF4e4e4e;

  static const MaterialColor ecRed = MaterialColor(
    _redPrimaryColor,
    <int, Color>{
      50: Color(0xFF5c140e),
      100: Color(0xFF781a13),
      200: Color(0xFF9b2218),
      300: Color(0xFFc72c1f),
      400: Color(0xFFdb3022),
      500: Color(_redPrimaryColor),
      600: Color(0xFFe7746b),
      700: Color(0xFFeea099),
      800: Color(0xFFf4bfba),
      900: Color(0xFFfbeae9),
    },
  );

  static const MaterialColor ecOrange = MaterialColor(
    _orangePrimaryColor,
    {
      50: Color(0xFF663500),
      100: Color(0xFF854500),
      200: Color(0xFFac5900),
      300: Color(0xFFdc7200),
      400: Color(0xFFf27d00),
      500: Color(_orangePrimaryColor),
      600: Color(0xFFf6a854),
      700: Color(0xFFf9c38a),
      800: Color(0xFFfbd7b0),
      900: Color(0xFFfef2e6),
    },
  );

  static const MaterialColor ecError = MaterialColor(
    _errorPrimaryColor,
    {
      50: Color(0xFF650d06),
      100: Color(0xFF841108),
      200: Color(0xFFaa160a),
      300: Color(0xFFda1c0d),
      400: Color(0xFFf01f0e),
      500: Color(_errorPrimaryColor),
      600: Color(0xFFf5695e),
      700: Color(0xFFf89890),
      800: Color(0xFFfabab4),
      900: Color(0xFFfee9e7),
    },
  );

  static const MaterialColor ecWhite = MaterialColor(
    _whitePrimaryColor,
    <int, Color>{
      50: Color(0xFF6b6b6b),
      100: Color(0xFF8c8c8c),
      200: Color(0xFFb5b5b5),
      300: Color(0xFFe8e8e8),
      400: Color(_whitePrimaryColor),
      500: Color(_whitePrimaryColor),
      600: Color(_whitePrimaryColor),
      700: Color(_whitePrimaryColor),
      800: Color(_whitePrimaryColor),
      900: Color(_whitePrimaryColor),
    },
  );

  static const MaterialColor ecGreen = MaterialColor(
    _greenPrimaryColor,
    <int, Color>{
      50: Color(0xFF124722),
      100: Color(0xFF175d2d),
      200: Color(0xFF1e783a),
      300: Color(0xFF269a4b),
      400: Color(0xFF2aa952),
      500: Color(_greenPrimaryColor),
      600: Color(0xFF70c58b),
      700: Color(0xFF9dd7af),
      800: Color(0xFFbde4c9),
      900: Color(0xFFeaf6ee),
    },
  );

  static const MaterialColor ecGrey = MaterialColor(
    _grayPrimaryColor,
    <int, Color>{
      50: Color(0xFF414141),
      100: Color(0xFF555555),
      200: Color(0xFF6e6e6e),
      300: Color(0xFF8d8d8d),
      400: Color(0xFF9B9B9B),
      500: Color(_grayPrimaryColor),
      600: Color(0xFFbcbcbc),
      700: Color(0xFFd1d1d1),
      800: Color(0xFFE0E0E0),
      900: Color(0xFFF5F5F5),
    },
  );

  static const MaterialColor ecBlack = MaterialColor(
    _blackPrimaryColor, // default
    <int, Color>{
      0: Color(0xFF000000),
      50: Color(0xFF0e0e0e),
      100: Color(0xFF131313),
      200: Color(0xFF181818),
      300: Color(0xFF1f1f1f),
      400: Color(0xFF222222),
      500: Color(_blackPrimaryColor),
      600: Color(0xFF6b6b6b),
      700: Color(0xFF999999),
      800: Color(0xFFbababa),
      900: Color(0xFFe9e9e9),
    },
  );
}
