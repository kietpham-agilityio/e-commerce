import 'package:flutter/material.dart';

import 'app_palette.dart';

class EcColors {
  static ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: EcPalette.red[1]!,
    onPrimary: EcPalette.white[1]!,
    secondary: EcPalette.genericBlack,
    onSecondary: EcPalette.white[1]!,
    error: EcPalette.red[2]!,
    onError: EcPalette.white[1]!,
    surface: EcPalette.genericGrey,
    onSurface: EcPalette.white[1]!,
  );

  static ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: EcPalette.red[1]!,
    onPrimary: EcPalette.white[1]!,
    secondary: EcPalette.white[2]!,
    onSecondary: EcPalette.genericBlack,
    error: EcPalette.red[2]!,
    onError: EcPalette.white[1]!,
    surface: EcPalette.black[2]!,
    onSurface: EcPalette.white[1]!,
  );
}
