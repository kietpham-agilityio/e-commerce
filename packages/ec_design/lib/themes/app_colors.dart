import 'package:flutter/material.dart';

import 'dark_palette.dart';
import 'light_palette.dart';

enum ECThemeType { user, admin }

class EcColors {
  static ColorScheme light(ECThemeType app) => switch (app) {
        ECThemeType.user => ColorScheme(
            brightness: Brightness.light,
            primary: EcLightPalette.ecRed.shade500,
            onPrimary: EcLightPalette.ecWhite.shade500,
            secondary: EcLightPalette.ecBlack.shade900,
            onSecondary: EcLightPalette.ecWhite.shade500,
            error: EcLightPalette.ecRed.shade700,
            onError: EcLightPalette.ecWhite.shade500,
            surface: EcLightPalette.ecGrey.shade500,
            onSurface: EcLightPalette.ecWhite.shade500,
            outline: EcLightPalette.ecGrey.shade500,
            primaryContainer: EcLightPalette.ecWhite.shade500,
          ),
        ECThemeType.admin => ColorScheme(
            brightness: Brightness.light,
            primary: EcLightPalette.ecOrange.shade500,
            onPrimary: EcLightPalette.ecWhite.shade500,
            secondary: EcLightPalette.ecBlack.shade900,
            onSecondary: EcLightPalette.ecWhite.shade500,
            error: EcLightPalette.ecRed.shade700,
            onError: EcLightPalette.ecWhite.shade500,
            surface: EcLightPalette.ecGrey.shade500,
            onSurface: EcLightPalette.ecWhite.shade500,
            outline: EcLightPalette.ecGrey.shade500,
            primaryContainer: EcLightPalette.ecWhite.shade500,
          ),
      };

  static ColorScheme dark(ECThemeType app) => switch (app) {
        ECThemeType.user => ColorScheme(
            brightness: Brightness.dark,
            primary: EcDarkPalette.ecRed.shade500,
            onPrimary: EcDarkPalette.ecWhite.shade900,
            secondary: EcDarkPalette.ecBlack.shade50,
            onSecondary: EcDarkPalette.ecWhite.shade900,
            error: EcDarkPalette.ecRed.shade200,
            onError: EcDarkPalette.ecWhite.shade900,
            surface: EcDarkPalette.ecGrey.shade50,
            onSurface: EcDarkPalette.ecWhite.shade900,
            outline: EcDarkPalette.ecGrey.shade500,
            primaryContainer: EcDarkPalette.ecWhite.shade100,
          ),
        ECThemeType.admin => ColorScheme(
            brightness: Brightness.dark,
            primary: EcDarkPalette.ecOrange.shade500,
            onPrimary: EcDarkPalette.ecWhite.shade900,
            secondary: EcDarkPalette.ecBlack.shade50,
            onSecondary: EcDarkPalette.ecWhite.shade900,
            error: EcDarkPalette.ecRed.shade200,
            onError: EcDarkPalette.ecWhite.shade900,
            surface: EcDarkPalette.ecGrey.shade50,
            onSurface: EcDarkPalette.ecWhite.shade900,
            outline: EcDarkPalette.ecGrey.shade500,
            primaryContainer: EcDarkPalette.ecWhite.shade100,
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
