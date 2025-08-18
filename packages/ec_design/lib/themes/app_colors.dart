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
            error: EcLightPalette.ecRed.shade700,
            onError: EcLightPalette.ecWhite,
            surface: EcLightPalette.ecGrey,
            onSurface: EcLightPalette.ecWhite,
            outline: EcLightPalette.ecGrey,
            primaryContainer: EcLightPalette.ecWhite,
          ),
        ECThemeType.admin => ColorScheme(
            brightness: Brightness.light,
            primary: EcLightPalette.ecOrange,
            onPrimary: EcLightPalette.ecWhite,
            secondary: EcLightPalette.ecBlack,
            onSecondary: EcLightPalette.ecWhite,
            error: EcLightPalette.ecRed.shade700,
            onError: EcLightPalette.ecWhite,
            surface: EcLightPalette.ecGrey,
            onSurface: EcLightPalette.ecWhite,
            outline: EcLightPalette.ecGrey,
            primaryContainer: EcLightPalette.ecWhite,
          ),
      };

  static ColorScheme dark(ECThemeType app) => switch (app) {
        ECThemeType.user => ColorScheme(
            brightness: Brightness.dark,
            primary: EcDarkPalette.ecRed,
            onPrimary: EcDarkPalette.ecWhite.shade900,
            secondary: EcDarkPalette.ecBlack,
            onSecondary: EcDarkPalette.ecWhite.shade900,
            error: EcDarkPalette.ecRed.shade200,
            onError: EcDarkPalette.ecWhite.shade900,
            surface: EcDarkPalette.ecGrey.shade50,
            onSurface: EcDarkPalette.ecWhite.shade900,
            outline: EcDarkPalette.ecGrey,
            primaryContainer: EcDarkPalette.ecWhite.shade100,
          ),
        ECThemeType.admin => ColorScheme(
            brightness: Brightness.dark,
            primary: EcDarkPalette.ecOrange,
            onPrimary: EcDarkPalette.ecWhite.shade900,
            secondary: EcDarkPalette.ecBlack,
            onSecondary: EcDarkPalette.ecWhite.shade900,
            error: EcDarkPalette.ecRed.shade200,
            onError: EcDarkPalette.ecWhite.shade900,
            surface: EcDarkPalette.ecGrey.shade50,
            onSurface: EcDarkPalette.ecWhite.shade900,
            outline: EcDarkPalette.ecGrey,
            primaryContainer: EcDarkPalette.ecWhite,
          ),
      };
}

extension CustomShadows on ColorScheme {
  Color shadowPrimary(ECThemeType app) {
    switch (app) {
      case ECThemeType.user:
        return brightness == Brightness.light
            ? EcLightPalette.ecRed.shade700
            : EcDarkPalette.ecRed.shade400;
      case ECThemeType.admin:
        return brightness == Brightness.light
            ? EcLightPalette.ecOrange.shade700
            : EcDarkPalette.ecOrange.shade400;
    }
  }

  Color shadowPrimaryContainer(ECThemeType app) {
    switch (app) {
      case ECThemeType.user:
        return brightness == Brightness.light
            ? EcLightPalette.ecWhite.shade900
            : EcDarkPalette.ecWhite.shade900;
      case ECThemeType.admin:
        return brightness == Brightness.light
            ? EcLightPalette.ecWhite.shade900
            : EcDarkPalette.ecWhite.shade900;
    }
  }
}
