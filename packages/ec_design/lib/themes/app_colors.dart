import 'package:flutter/material.dart';

import 'dark_palette.dart';
import 'light_palette.dart';

enum ECThemeType { user, admin }

class EcColors {
  static ColorScheme light(ECThemeType app) => switch (app) {
        ECThemeType.user => const ColorScheme(
            brightness: Brightness.light,
            primary: EcLightPalette.ecUserPrimary,
            onPrimary: EcLightPalette.ecWhite,
            secondary: EcLightPalette.ecBlack,
            onSecondary: EcLightPalette.ecWhite,
            error: EcLightPalette.ecError,
            onError: EcLightPalette.ecWhite,
            surface: EcLightPalette.ecGrey,
            onSurface: EcLightPalette.ecWhite,
            outline: EcLightPalette.ecGrey,
            primaryContainer: EcLightPalette.ecWhite,
          ),
        ECThemeType.admin => const ColorScheme(
            brightness: Brightness.light,
            primary: EcLightPalette.ecAdminPrimary,
            onPrimary: EcLightPalette.ecWhite,
            secondary: EcLightPalette.ecBlack,
            onSecondary: EcLightPalette.ecWhite,
            error: EcLightPalette.ecError,
            onError: EcLightPalette.ecWhite,
            surface: EcLightPalette.ecGrey,
            onSurface: EcLightPalette.ecWhite,
            outline: EcLightPalette.ecGrey,
            primaryContainer: EcLightPalette.ecWhite,
          ),
      };

  static ColorScheme dark(ECThemeType app) => switch (app) {
        ECThemeType.user => const ColorScheme(
            brightness: Brightness.dark,
            primary: EcDarkPalette.ecUserPrimary,
            onPrimary: EcDarkPalette.ecWhite,
            secondary: EcDarkPalette.ecBlack,
            onSecondary: EcDarkPalette.ecWhite,
            error: EcDarkPalette.ecError,
            onError: EcDarkPalette.ecWhite,
            surface: EcDarkPalette.ecGrey,
            onSurface: EcDarkPalette.ecWhite,
            outline: EcDarkPalette.ecGrey,
            primaryContainer: EcDarkPalette.ecWhite,
          ),
        ECThemeType.admin => const ColorScheme(
            brightness: Brightness.dark,
            primary: EcDarkPalette.ecAdminPrimary,
            onPrimary: EcDarkPalette.ecWhite,
            secondary: EcDarkPalette.ecBlack,
            onSecondary: EcDarkPalette.ecWhite,
            error: EcDarkPalette.ecError,
            onError: EcDarkPalette.ecWhite,
            surface: EcDarkPalette.ecGrey,
            onSurface: EcDarkPalette.ecWhite,
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
            ? EcLightPalette.ecUserPrimary.shade700
            : EcDarkPalette.ecError.shade400;
      case ECThemeType.admin:
        return brightness == Brightness.light
            ? EcLightPalette.ecAdminPrimary.shade700
            : EcDarkPalette.ecAdminPrimary.shade400;
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
