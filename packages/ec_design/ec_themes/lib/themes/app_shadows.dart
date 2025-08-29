import 'package:flutter/material.dart';
import 'light_palette.dart';
import 'dark_palette.dart';

/// Common shadows for the e-commerce app design system
/// Note: Behind transparent areas == BTA (Behind Transparent Areas)
class EcShadows {
  EcShadows._();

  // ===== DROP SHADOWS =====

  /// Drop shadow: X=0, Y=-4, Blur=20, Spread=0, BTA=true, opacity #000000 6%
  static BoxShadow dropShadowUp(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark
            ? EcDarkPalette.ecBlack[0]!.withValues(alpha: 0.06)
            : EcLightPalette.ecBlack[0]!.withValues(alpha: 0.06);

    return BoxShadow(
      offset: const Offset(0, -4),
      blurRadius: 20,
      spreadRadius: 0,
      color: color,
    );
  }

  /// Drop shadow: X=0, Y=1, Blur=8, Spread=0, BTA=true, opacity #000000 5%
  static BoxShadow dropShadowSubtle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark
            ? EcDarkPalette.ecBlack[0]!.withValues(alpha: 0.05)
            : EcLightPalette.ecBlack[0]!.withValues(alpha: 0.05);

    return BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 8,
      spreadRadius: 0,
      color: color,
    );
  }

  /// Drop shadow: X=0, Y=1, Blur=25, Spread=0, BTA=true, opacity #000000 8%
  static BoxShadow dropShadowSoft(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark
            ? EcDarkPalette.ecBlack[0]!.withValues(alpha: 0.08)
            : EcLightPalette.ecBlack[0]!.withValues(alpha: 0.08);

    return BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 25,
      spreadRadius: 0,
      color: color,
    );
  }

  /// Drop shadow: X=0, Y=4, Blur=12, Spread=0, BTA=true, opacity #000000 12%
  static BoxShadow dropShadowMedium(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark
            ? EcDarkPalette.ecBlack[0]!.withValues(alpha: 0.12)
            : EcLightPalette.ecBlack[0]!.withValues(alpha: 0.12);

    return BoxShadow(
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: color,
    );
  }

  /// Drop shadow: X=0, Y=4, Blur=8, Spread=0, BTA=true, opacity #D32626 25%
  static BoxShadow dropShadowRed(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark
            ? EcDarkPalette.ecRed[500]!.withValues(alpha: 0.25)
            : EcLightPalette.ecRed[500]!.withValues(alpha: 0.25);

    return BoxShadow(
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
      color: color,
    );
  }

  /// Drop shadow: X=0, Y=4, Blur=4, Spread=0, BTA=true, opacity #D32626 16%
  static BoxShadow dropShadowRedSubtle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark
            ? EcDarkPalette.ecRed[500]!.withValues(alpha: 0.16)
            : EcLightPalette.ecRed[500]!.withValues(alpha: 0.16);

    return BoxShadow(
      offset: const Offset(0, 4),
      blurRadius: 4,
      spreadRadius: 0,
      color: color,
    );
  }

  // ===== INNER SHADOW =====

  /// Inner shadow: X=0, Y=2, Blur=2, Spread=0, opacity #000000 5%
  static BoxShadow innerShadow(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        isDark
            ? EcDarkPalette.ecBlack[0]!.withValues(alpha: 0.05)
            : EcLightPalette.ecBlack[0]!.withValues(alpha: 0.05);

    return BoxShadow(
      offset: const Offset(0, 2),
      blurRadius: 2,
      spreadRadius: 0,
      color: color,
    );
  }

  /// Custom shadow with palette colors
  static BoxShadow customShadow(
    BuildContext context, {
    Offset offset = const Offset(0, 4),
    double blurRadius = 4,
    double spreadRadius = 0,
    Color? color,
    bool inset = false,
    double opacity = 0.25,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shadowColor =
        color ??
        (isDark
            ? EcDarkPalette.ecBlack[0]!.withValues(alpha: opacity)
            : EcLightPalette.ecBlack[0]!.withValues(alpha: opacity));

    return BoxShadow(
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      color: shadowColor,
    );
  }
}
