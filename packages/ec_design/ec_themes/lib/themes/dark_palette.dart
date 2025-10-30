import 'package:flutter/material.dart';

class EcDarkPalette {
  static const int _redPrimaryColor = 0xFFef3651;
  static const int _orangePrimaryColor = 0xFFf59733;
  static const int _errorPrimaryColor = 0xFFff2424;
  static const int _whitePrimaryColor = 0xFFf6f6f6;
  static const int _greenPrimaryColor = 0xFF55d85a;
  static const int _grayPrimaryColor = 0xFFabb4bd;
  static const int _blackPrimaryColor = 0xFF2a2c36;
  static const Color backgroundColor = Color(0xff1e1f28);

  static const MaterialColor ecRed =
      MaterialColor(_redPrimaryColor, <int, Color>{
        50: Color(0xFFfdebee),
        100: Color(0xFFfac1c9),
        200: Color(0xFFf8a3af),
        300: Color(0xFFf4788a),
        400: Color(0xFFf25e74),
        500: Color(_redPrimaryColor),
        600: Color(0xFFd9314a),
        700: Color(0xFFaa263a),
        800: Color(0xFF831e2d),
        900: Color(0xFF641722),
      });

  static const MaterialColor ecOrange = MaterialColor(_orangePrimaryColor, {
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
  });

  static const MaterialColor ecError = MaterialColor(_errorPrimaryColor, {
    50: Color(0xFFffe9e9),
    100: Color(0xFFffbbbb),
    200: Color(0xFFff9a9a),
    300: Color(0xFFff6c6c),
    400: Color(0xFFff5050),
    500: Color(_errorPrimaryColor),
    600: Color(0xFFe82121),
    700: Color(0xFFb51a1a),
    800: Color(0xFF8c1414),
    900: Color(0xFF6b0f0f),
  });

  static const MaterialColor ecWhite =
      MaterialColor(_whitePrimaryColor, <int, Color>{
        50: Color(0xfffefefe),
        100: Color(0xFFfcfcfc),
        200: Color(0xFFfbfbfb),
        300: Color(0xFFf9f9f9),
        400: Color(0xfff8f8f8),
        500: Color(0xfff6f6f6),
        600: Color(0xffe0e0e0),
        700: Color(0xffafafaf),
        800: Color(0xff878787),
        900: Color(0xff676767),
      });

  static const MaterialColor ecGreen =
      MaterialColor(_greenPrimaryColor, <int, Color>{
        50: Color(0xFFeefbef),
        100: Color(0xFFcaf3cc),
        200: Color(0xFFb1edb3),
        300: Color(0xFF8de590),
        400: Color(0xFF77e07b),
        500: Color(_greenPrimaryColor),
        600: Color(0xFF4dc552),
        700: Color(0xFF3c9940),
        800: Color(0xFF2f7732),
        900: Color(0xFF245b26),
      });

  static const MaterialColor ecGrey =
      MaterialColor(_grayPrimaryColor, <int, Color>{
        50: Color(0xFFf7f8f8),
        100: Color(0xFFe5e8eb),
        200: Color(0xFFd8dde1),
        300: Color(0xFFc7cdd3),
        400: Color(0xFFbcc3ca),
        500: Color(_grayPrimaryColor),
        600: Color(0xFF9ca4ac),
        700: Color(0xFF798086),
        800: Color(0xFF5e6368),
        900: Color(0xFF484c4f),
      });

  static const MaterialColor ecBlack = MaterialColor(
    _blackPrimaryColor, // default
    <int, Color>{
      50: Color(0xFFeaeaeb),
      100: Color(0xFFbdbec1),
      200: Color(0xFF9d9ea3),
      300: Color(0xFF707278),
      400: Color(0xFF55565e),
      500: Color(_blackPrimaryColor),
      600: Color(0xFF262831),
      700: Color(0xFF1e1f26),
      800: Color(0xFF17181e),
      900: Color(0xFF121217),
    },
  );
}
