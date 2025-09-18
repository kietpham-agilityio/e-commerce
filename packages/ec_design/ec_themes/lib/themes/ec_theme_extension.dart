import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizing.dart';

/// Extension for ThemeData that provides access to EC-specific theme properties
@immutable
class EcThemeExtension extends ThemeExtension<EcThemeExtension> {
  const EcThemeExtension({required this.themeType, required this.isDark});

  /// The theme type (user or admin)
  final ECThemeType themeType;

  /// Whether the theme is dark mode
  final bool isDark;

  /// Get the colors for the current theme
  ColorScheme get colors =>
      isDark ? EcColors.dark(themeType) : EcColors.light(themeType);

  /// Get the sizing for the current theme
  AppSizing get sizing => AppSizing(themeType);

  @override
  EcThemeExtension copyWith({ECThemeType? themeType, bool? isDark}) {
    return EcThemeExtension(
      themeType: themeType ?? this.themeType,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  EcThemeExtension lerp(ThemeExtension<EcThemeExtension>? other, double t) {
    if (other is! EcThemeExtension) {
      return this;
    }
    return EcThemeExtension(
      themeType: t < 0.5 ? themeType : other.themeType,
      isDark: t < 0.5 ? isDark : other.isDark,
    );
  }
}
