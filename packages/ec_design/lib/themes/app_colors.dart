import 'package:flutter/material.dart';

import 'dark_palette.dart';
import 'light_palette.dart';

enum ECThemeType { user, admin }

class EcColors {
  static ColorScheme light(ECThemeType app) => switch (app) {
        ECThemeType.user => ColorScheme(
            brightness: Brightness.light,
            primary: EcLightPalette.ecRed[500]!,
            onPrimary: EcLightPalette.ecWhite[500]!,
            secondary: EcLightPalette.ecBlack[900]!,
            onSecondary: EcLightPalette.ecWhite,
            error: EcLightPalette.ecRed[700]!,
            onError: EcLightPalette.ecWhite[500]!,
            surface: EcLightPalette.ecGrey[500]!,
            onSurface: EcLightPalette.ecWhite[500]!,
            outline: EcLightPalette.ecGrey[500],
            primaryContainer: EcLightPalette.ecWhite[500]!,
          ),
        ECThemeType.admin => ColorScheme(
            brightness: Brightness.light,
            primary: EcLightPalette.ecOrange[500]!,
            onPrimary: EcLightPalette.ecWhite[500]!,
            secondary: EcLightPalette.ecBlack[900]!,
            onSecondary: EcLightPalette.ecWhite,
            error: EcLightPalette.ecRed[700]!,
            onError: EcLightPalette.ecWhite[500]!,
            surface: EcLightPalette.ecGrey[500]!,
            onSurface: EcLightPalette.ecWhite[500]!,
            outline: EcLightPalette.ecGrey[500],
            primaryContainer: EcLightPalette.ecWhite[500]!,
          ),
      };

  static ColorScheme dark(ECThemeType app) => switch (app) {
        ECThemeType.user => ColorScheme(
            brightness: Brightness.dark,
            primary: EcDarkPalette.ecRed[500]!,
            onPrimary: EcDarkPalette.ecWhite[900]!,
            secondary: EcDarkPalette.ecBlack[50]!,
            onSecondary: EcDarkPalette.ecWhite[900]!,
            error: EcDarkPalette.ecRed[200]!,
            onError: EcDarkPalette.ecWhite[900]!,
            surface: EcDarkPalette.ecGrey[50]!,
            onSurface: EcDarkPalette.ecWhite[900]!,
            outline: EcDarkPalette.ecGrey[500]!,
            primaryContainer: EcDarkPalette.ecWhite[100]!,
          ),
        ECThemeType.admin => ColorScheme(
            brightness: Brightness.dark,
            primary: EcDarkPalette.ecOrange[500]!,
            onPrimary: EcDarkPalette.ecWhite[900]!,
            secondary: EcDarkPalette.ecBlack[50]!,
            onSecondary: EcDarkPalette.ecWhite[900]!,
            error: EcDarkPalette.ecRed[200]!,
            onError: EcDarkPalette.ecWhite[900]!,
            surface: EcDarkPalette.ecGrey[50]!,
            onSurface: EcDarkPalette.ecWhite[900]!,
            outline: EcDarkPalette.ecGrey[500]!,
            primaryContainer: EcDarkPalette.ecWhite[100]!,
          ),
      };
}

extension CustomShadows on ColorScheme {
  Color shadowPrimary(ECThemeType app) {
    switch (app) {
      case ECThemeType.user:
        return brightness == Brightness.light
            ? EcLightPalette.ecRed[700]!
            : EcDarkPalette.ecRed[400]!;
      case ECThemeType.admin:
        return brightness == Brightness.light
            ? EcLightPalette.ecOrange[700]!
            : EcDarkPalette.ecOrange[400]!;
    }
  }

  Color shadowPrimaryContainer(ECThemeType app) {
    switch (app) {
      case ECThemeType.user:
        return brightness == Brightness.light
            ? EcLightPalette.ecWhite[900]!
            : EcDarkPalette.ecWhite[900]!;
      case ECThemeType.admin:
        return brightness == Brightness.light
            ? EcLightPalette.ecWhite[900]!
            : EcDarkPalette.ecWhite[900]!;
    }
  }
}
