import 'package:flutter/material.dart';

import 'dark_palette.dart';
import 'light_palette.dart';

enum ECThemeType { user, admin }

class EcColors {
  static ColorScheme light(ECThemeType app) => switch (app) {
    ECThemeType.user => ColorScheme(
      brightness: Brightness.light,
      primary: EcLightPalette.ecRed,
      onPrimary: EcLightPalette.ecWhite,
      secondary: EcLightPalette.ecBlack,
      onSecondary: EcLightPalette.ecWhite,
      error: EcLightPalette.ecError,
      onError: EcLightPalette.ecWhite,
      surface: EcLightPalette.ecGrey,
      onSurface: EcLightPalette.ecWhite,
      outline: EcLightPalette.ecGrey,
      primaryContainer: EcLightPalette.ecWhite,
      onPrimaryContainer: EcLightPalette.ecBlack,
      surfaceDim: EcLightPalette.ecGrey[50]!,
      tertiary: EcLightPalette.ecBlack[900]!,
    ),
    ECThemeType.admin => ColorScheme(
      brightness: Brightness.light,
      primary: EcLightPalette.ecOrange,
      onPrimary: EcLightPalette.ecWhite,
      secondary: EcLightPalette.ecBlack,
      onSecondary: EcLightPalette.ecWhite,
      error: EcLightPalette.ecError,
      onError: EcLightPalette.ecWhite,
      surface: EcLightPalette.ecGrey,
      onSurface: EcLightPalette.ecWhite,
      outline: EcLightPalette.ecGrey,
      primaryContainer: EcLightPalette.ecWhite,
      onPrimaryContainer: EcLightPalette.ecBlack,
      surfaceDim: EcLightPalette.ecGrey[50]!,
      tertiary: EcLightPalette.ecBlack[900]!,
    ),
  };

  static ColorScheme dark(ECThemeType app) => switch (app) {
    ECThemeType.user => ColorScheme(
      brightness: Brightness.dark,
      primary: EcDarkPalette.ecRed,
      onPrimary: EcDarkPalette.ecWhite,
      secondary: EcDarkPalette.ecBlack,
      onSecondary: EcDarkPalette.ecWhite,
      error: EcDarkPalette.ecError,
      onError: EcDarkPalette.ecWhite,
      surface: EcDarkPalette.ecGrey,
      onSurface: EcDarkPalette.ecWhite,
      outline: EcDarkPalette.ecGrey,
      primaryContainer: EcDarkPalette.ecWhite,
      onPrimaryContainer: EcLightPalette.ecBlack,
      surfaceDim: EcLightPalette.ecGrey[700]!,
      tertiary: EcLightPalette.ecWhite[900]!,
    ),
    ECThemeType.admin => ColorScheme(
      brightness: Brightness.dark,
      primary: EcDarkPalette.ecOrange,
      onPrimary: EcDarkPalette.ecWhite,
      secondary: EcDarkPalette.ecBlack,
      onSecondary: EcDarkPalette.ecWhite,
      error: EcDarkPalette.ecError,
      onError: EcDarkPalette.ecWhite,
      surface: EcDarkPalette.ecGrey,
      onSurface: EcDarkPalette.ecWhite,
      outline: EcDarkPalette.ecGrey,
      primaryContainer: EcDarkPalette.ecWhite,
      onPrimaryContainer: EcLightPalette.ecBlack,
      surfaceDim: EcLightPalette.ecGrey[700]!,
      tertiary: EcLightPalette.ecWhite[900]!,
    ),
  };
}

extension EcColorScheme on ColorScheme {
  /// Success background color
  Color get success =>
      brightness == Brightness.light
          ? EcLightPalette.ecGreen
          : EcDarkPalette.ecGreen;

  /// Text/icon color on top of success background
  Color get onSuccess =>
      brightness == Brightness.light
          ? EcLightPalette.ecWhite
          : EcDarkPalette.ecWhite;
}
