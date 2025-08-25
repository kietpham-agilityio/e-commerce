export 'icons.dart';

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'typography.dart';

/// Design system themes for the e-commerce app
class EcDesignTheme {
  EcDesignTheme._();

  /// Light theme for the e-commerce app
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: EcColors.light(ECThemeType.user),
      useMaterial3: true,
      fontFamily: EcTypography.fontFamily,
      textTheme: _buildTextTheme(ECThemeType.user, false),
    );
  }

  /// Dark theme for the e-commerce app
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: EcColors.dark(ECThemeType.user),
      useMaterial3: true,
      fontFamily: EcTypography.fontFamily,
      textTheme: _buildTextTheme(ECThemeType.user, true),
    );
  }

  /// Builds the text theme based on EcTypography system
  static TextTheme _buildTextTheme(ECThemeType themeType, bool isDark) {
    final colors = isDark 
        ? EcColors.dark(themeType) 
        : EcColors.light(themeType);
    
    return TextTheme(
      // Display styles
      displayLarge: EcTypography.displayLarge.copyWith(color: colors.secondary),
      displayMedium: EcTypography.displayMedium.copyWith(color: colors.secondary),
      displaySmall: EcTypography.displaySmall.copyWith(color: colors.secondary),

      // Headline styles
      headlineLarge: EcTypography.headlineLarge.copyWith(color: colors.secondary),
      headlineMedium: EcTypography.headlineMedium.copyWith(color: colors.secondary),
      headlineSmall: EcTypography.headlineSmall.copyWith(color: colors.secondary),

      // Title styles
      titleLarge: EcTypography.titleLarge.copyWith(color: colors.secondary),
      titleMedium: EcTypography.titleMedium.copyWith(color: colors.secondary),
      titleSmall: EcTypography.titleSmall.copyWith(color: colors.secondary),

      // Body styles
      bodyLarge: EcTypography.bodyLarge.copyWith(color: colors.secondary),
      bodyMedium: EcTypography.bodyMedium.copyWith(color: colors.secondary),
      bodySmall: EcTypography.bodySmall.copyWith(color: colors.outline),

      // Label styles
      labelLarge: EcTypography.labelLarge.copyWith(color: colors.secondary),
      labelMedium: EcTypography.labelMedium.copyWith(color: colors.secondary),
      labelSmall: EcTypography.labelSmall.copyWith(color: colors.secondary),
    );
  }
}
