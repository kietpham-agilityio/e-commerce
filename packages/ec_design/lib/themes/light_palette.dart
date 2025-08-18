import 'package:flutter/material.dart';

class EcLightPalette {
  static const int _redPrimaryColor = 0xFFDB3022;
  static const int _orangePrimaryColor = 0xFFF27D00;
  static const int _errorPrimaryColor = 0xFFf01f0e;
  static const int _whitePrimaryColor = 0xFFFFFFFF;
  static const int _greenPrimaryColor = 0xFF2AA952;
  static const int _grayPrimaryColor = 0xFF9B9B9B;
  static const int _blackPrimaryColor = 0xFF222222;

  static const MaterialColor ecRed = MaterialColor(
    _redPrimaryColor,
    <int, Color>{
      50: Color(0xFFfbeae9),
      100: Color(0xFFf4bfba),
      200: Color(0xFFeea099),
      300: Color(0xFFe7746b),
      400: Color(0xFFe2594e),
      500: Color(_redPrimaryColor),
      600: Color(0xFFc72c1f),
      700: Color(0xFF9b2218),
      800: Color(0xFF781a13),
      900: Color(0xFF5c140e),
    },
  );

  static const MaterialColor ecOrange = MaterialColor(
    _orangePrimaryColor,
    {
      50: Color(0xFFfef2e6),
      100: Color(0xFFfbd7b0),
      200: Color(0xFFf9c38a),
      300: Color(0xFFf6a854),
      400: Color(0xFFf59733),
      500: Color(_orangePrimaryColor),
      600: Color(0xFFdc7200),
      700: Color(0xFFac5900),
      800: Color(0xFF854500),
      900: Color(0xFF663500),
    },
  );

  static const MaterialColor ecError = MaterialColor(
    _errorPrimaryColor,
    {
      50: Color(0xFFfee9e7),
      100: Color(0xFFfabab4),
      200: Color(0xFFf89890),
      300: Color(0xFFf5695e),
      400: Color(0xFFf34c3e),
      500: Color(_errorPrimaryColor),
      600: Color(0xFFda1c0d),
      700: Color(0xFFaa160a),
      800: Color(0xFF841108),
      900: Color(0xFF650d06),
    },
  );

  static const MaterialColor ecWhite = MaterialColor(
    _whitePrimaryColor,
    <int, Color>{
      50: Color(_whitePrimaryColor),
      100: Color(_whitePrimaryColor),
      200: Color(_whitePrimaryColor),
      300: Color(_whitePrimaryColor),
      400: Color(_whitePrimaryColor),
      500: Color(_whitePrimaryColor),
      600: Color(0xFFe8e8e8),
      700: Color(0xFFb5b5b5),
      800: Color(0xFF8c8c8c),
      900: Color(0xFF6b6b6b),
    },
  );

  static const MaterialColor ecGreen = MaterialColor(
    _greenPrimaryColor,
    <int, Color>{
      50: Color(0xFFeaf6ee),
      100: Color(0xFFbde4c9),
      200: Color(0xFF9dd7af),
      300: Color(0xFF70c58b),
      400: Color(0xFF55ba75),
      500: Color(_greenPrimaryColor),
      600: Color(0xFF269a4b),
      700: Color(0xFF1e783a),
      800: Color(0xFF175d2d),
      900: Color(0xFF124722),
    },
  );

  static const MaterialColor ecGrey = MaterialColor(
    _grayPrimaryColor,
    <int, Color>{
      50: Color(0xFFF5F5F5),
      100: Color(0xFFE0E0E0),
      200: Color(0xFFd1d1d1),
      300: Color(0xFFbcbcbc),
      400: Color(0xFFafafaf),
      500: Color(_grayPrimaryColor),
      600: Color(0xFF8d8d8d),
      700: Color(0xFF6e6e6e),
      800: Color(0xFF555555),
      900: Color(0xFF414141),
    },
  );

  static const MaterialColor ecBlack = MaterialColor(
    _blackPrimaryColor,
    <int, Color>{
      50: Color(0xFFe9e9e9),
      100: Color(0xFFbababa),
      200: Color(0xFF999999),
      300: Color(0xFF6b6b6b),
      400: Color(0xFF4e4e4e),
      500: Color(_blackPrimaryColor),
      600: Color(0xFF1f1f1f),
      700: Color(0xFF181818),
      800: Color(0xFF131313),
      900: Color(0xFF0e0e0e),
    },
  );
}
