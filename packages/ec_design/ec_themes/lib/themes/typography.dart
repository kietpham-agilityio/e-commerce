import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Typography scale for the e-commerce design system
///
/// This class defines the typography scale with consistent sizing,
/// line heights, and font weights for different text styles.
/// It provides 2 typography styles for each ECThemeType:
/// - User theme: Clean, modern typography optimized for readability
/// - Admin theme: Professional, structured typography optimized for data display
class EcTypography {
  EcTypography._();

  // Font families
  static const String fontFamily = 'Metropolis';

  // Font weights - Metropolis font weights
  static const FontWeight regular = FontWeight.w400; // Metropolis-Regular.otf
  static const FontWeight medium = FontWeight.w500; // Metropolis-Medium.otf
  static const FontWeight semiBold = FontWeight.w600; // Metropolis-SemiBold.otf
  static const FontWeight bold = FontWeight.w700; // Metropolis-Bold.otf

  // Font sizes
  static const double xs = 11.0;
  static const double sm = 12.0;
  static const double base = 14.0;
  static const double lg = 16.0;
  static const double xl = 18.0;
  static const double xxl = 20.0;
  static const double xxxl = 24.0;
  static const double huge = 30.0;
  static const double giant = 34.0;
  static const double massive = 48.0;

  // Line heights (as multipliers)
  static const double baseHeight = 1;
  static const double tightHeight = 1.25;
  static const double normalHeight = 1.4;
  static const double relaxedHeight = 1.75;

  // Letter spacing
  static const double tightSpacing = -0.5;
  static const double normalSpacing = 0.0;
  static const double wideSpacing = 0.5;

  // ===== USER THEME TYPOGRAPHY =====
  // Clean, modern typography optimized for readability and user experience

  /// User theme - Display large text style - for hero titles
  static TextStyle getUserDisplayLarge(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: massive,
      fontWeight: bold,
      height: baseHeight,
      letterSpacing: tightSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Display medium text style - for section headers
  static TextStyle getUserDisplayMedium(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: giant,
      fontWeight: bold,
      height: baseHeight,
      letterSpacing: tightSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Display small text style - for subsection headers
  static TextStyle getUserDisplaySmall(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: huge,
      fontWeight: semiBold,
      height: baseHeight,
      letterSpacing: tightSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Headline large text style - for main page titles
  static TextStyle getUserHeadlineLarge(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: xxxl,
      fontWeight: semiBold,
      height: baseHeight,
      letterSpacing: normalSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Headline medium text style - for page titles
  static TextStyle getUserHeadlineMedium(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: xxl,
      fontWeight: semiBold,
      height: baseHeight,
      letterSpacing: normalSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Headline small text style - for section titles
  static TextStyle getUserHeadlineSmall(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: xl,
      fontWeight: semiBold,
      height: baseHeight,
      letterSpacing: normalSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Title large text style - for card titles
  static TextStyle getUserTitleLarge(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: lg,
      fontWeight: medium,
      height: baseHeight,
      letterSpacing: normalSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Title medium text style - for list item titles
  static TextStyle getUserTitleMedium(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: base,
      fontWeight: medium,
      height: baseHeight,
      letterSpacing: normalSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Title small text style - for small titles
  static TextStyle getUserTitleSmall(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: sm,
      fontWeight: medium,
      height: baseHeight,
      letterSpacing: wideSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Body large text style - for main content
  static TextStyle getUserBodyLarge(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: lg,
      fontWeight: regular,
      height: 1,
      letterSpacing: normalSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Body medium text style - for regular content
  static TextStyle getUserBodyMedium(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: base,
      fontWeight: regular,
      height: baseHeight,
      letterSpacing: normalSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Body small text style - for secondary content
  static TextStyle getUserBodySmall(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: sm,
      fontWeight: regular,
      height: relaxedHeight,
      letterSpacing: wideSpacing,
      color: colors.outline,
    );
  }

  /// User theme - Label large text style - for form labels
  static TextStyle getUserLabelLarge(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: base,
      fontWeight: medium,
      height: baseHeight,
      letterSpacing: wideSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Label medium text style - for small labels
  static TextStyle getUserLabelMedium(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: base,
      fontWeight: medium,
      height: normalHeight,
      letterSpacing: wideSpacing,
      color: colors.secondary,
    );
  }

  /// User theme - Label small text style - for tiny labels
  static TextStyle getUserLabelSmall(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: xs,
      fontWeight: regular,
      height: baseHeight,
      letterSpacing: wideSpacing,
      color: colors.secondary,
    );
  }

  // ===== ADMIN THEME TYPOGRAPHY =====
  // Professional, structured typography optimized for data display and admin interfaces

  /// Admin theme - Display large text style - for dashboard headers
  static TextStyle getAdminDisplayLarge(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: massive,
      fontWeight: bold,
      height: 1.2, // Tighter for admin
      letterSpacing: -1.0, // Tighter spacing for admin
      color: colors.primary, // Use primary color for admin headers
    );
  }

  /// Admin theme - Display medium text style - for section headers
  static TextStyle getAdminDisplayMedium(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: giant,
      fontWeight: bold,
      height: baseHeight,
      letterSpacing: -0.8,
      color: colors.secondary,
    );
  }

  /// Admin theme - Display small text style - for subsection headers
  static TextStyle getAdminDisplaySmall(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: huge,
      fontWeight: bold, // Bolder for admin
      height: baseHeight,
      letterSpacing: -0.5,
      color: colors.primary,
    );
  }

  /// Admin theme - Headline large text style - for main page titles
  static TextStyle getAdminHeadlineLarge(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: xxxl,
      fontWeight: bold, // Bolder for admin
      height: baseHeight,
      letterSpacing: -0.3,
      color: colors.secondary,
    );
  }

  /// Admin theme - Headline medium text style - for page titles
  static TextStyle getAdminHeadlineMedium(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: xxl,
      fontWeight: bold,
      height: baseHeight,
      letterSpacing: -0.2,
      color: colors.secondary,
    );
  }

  /// Admin theme - Headline small text style - for section titles
  static TextStyle getAdminHeadlineSmall(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: xl,
      fontWeight: bold,
      height: baseHeight,
      letterSpacing: -0.1,
      color: colors.secondary,
    );
  }

  /// Admin theme - Title large text style - for card titles
  static TextStyle getAdminTitleLarge(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: lg,
      fontWeight: semiBold, // Semi-bold for admin
      height: baseHeight,
      letterSpacing: 0.0,
      color: colors.secondary,
    );
  }

  /// Admin theme - Title medium text style - for list item titles
  static TextStyle getAdminTitleMedium(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: base,
      fontWeight: semiBold,
      height: baseHeight,
      letterSpacing: 0.0,
      color: colors.secondary,
    );
  }

  /// Admin theme - Title small text style - for small titles
  static TextStyle getAdminTitleSmall(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: sm,
      fontWeight: semiBold,
      height: baseHeight,
      letterSpacing: 0.1,
      color: colors.secondary,
    );
  }

  /// Admin theme - Body large text style - for main content
  static TextStyle getAdminBodyLarge(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: lg,
      fontWeight: medium, // Medium for admin readability
      height: baseHeight,
      letterSpacing: 0.0,
      color: colors.secondary,
    );
  }

  /// Admin theme - Body medium text style - for regular content
  static TextStyle getAdminBodyMedium(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: base,
      fontWeight: medium,
      height: baseHeight,
      letterSpacing: 0.0,
      color: colors.secondary,
    );
  }

  /// Admin theme - Body small text style - for secondary content
  static TextStyle getAdminBodySmall(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: sm,
      fontWeight: medium,
      height: baseHeight,
      letterSpacing: 0.1,
      color: colors.outline,
    );
  }

  /// Admin theme - Label large text style - for form labels
  static TextStyle getAdminLabelLarge(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: base,
      fontWeight: semiBold, // Semi-bold for admin labels
      height: baseHeight,
      letterSpacing: 0.1,
      color: colors.secondary,
    );
  }

  /// Admin theme - Label medium text style - for small labels
  static TextStyle getAdminLabelMedium(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: base,
      fontWeight: semiBold,
      height: baseHeight,
      letterSpacing: 0.1,
      color: colors.secondary,
    );
  }

  /// Admin theme - Label small text style - for tiny labels
  static TextStyle getAdminLabelSmall(ECThemeType themeType, bool isDark) {
    final colors =
        isDark ? EcColors.dark(themeType) : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: xs,
      fontWeight: semiBold,
      height: baseHeight,
      letterSpacing: 0.2,
      color: colors.secondary,
    );
  }

  // ===== LEGACY SUPPORT =====
  // Keep existing methods for backward compatibility

  /// Legacy method - returns user typography by default
  static TextStyle get displayLarge =>
      getUserDisplayLarge(ECThemeType.user, true);
  static TextStyle get displayMedium =>
      getUserDisplayMedium(ECThemeType.user, true);
  static TextStyle get displaySmall =>
      getUserDisplaySmall(ECThemeType.user, true);
  static TextStyle get headlineLarge =>
      getUserHeadlineLarge(ECThemeType.user, true);
  static TextStyle get headlineMedium =>
      getUserHeadlineMedium(ECThemeType.user, true);
  static TextStyle get headlineSmall =>
      getUserHeadlineSmall(ECThemeType.user, true);
  static TextStyle get titleLarge => getUserTitleLarge(ECThemeType.user, true);
  static TextStyle get titleMedium =>
      getUserTitleMedium(ECThemeType.user, true);
  static TextStyle get titleSmall => getUserTitleSmall(ECThemeType.user, true);
  static TextStyle get bodyLarge => getUserBodyLarge(ECThemeType.user, true);
  static TextStyle get bodyMedium => getUserBodyMedium(ECThemeType.user, true);
  static TextStyle get bodySmall => getUserBodySmall(ECThemeType.user, true);
  static TextStyle get labelLarge => getUserLabelLarge(ECThemeType.user, true);
  static TextStyle get labelMedium =>
      getUserLabelMedium(ECThemeType.user, true);
  static TextStyle get labelSmall => getUserLabelSmall(ECThemeType.user, true);

  // ===== UTILITY METHODS =====

  /// Get typography with custom color
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Get typography with custom font weight
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Get typography with custom font size
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Get typography with custom line height
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }

  /// Get typography with custom letter spacing
  static TextStyle withLetterSpacing(TextStyle style, double spacing) {
    return style.copyWith(letterSpacing: spacing);
  }

  // ===== THEME-AWARE TYPOGRAPHY METHODS =====

  /// Get display large text style based on theme type and mode
  static TextStyle getDisplayLarge(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminDisplayLarge(themeType, isDark)
        : getUserDisplayLarge(themeType, isDark);
  }

  /// Get display medium text style based on theme type and mode
  static TextStyle getDisplayMedium(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminDisplayMedium(themeType, isDark)
        : getUserDisplayMedium(themeType, isDark);
  }

  /// Get display small text style based on theme type and mode
  static TextStyle getDisplaySmall(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminDisplaySmall(themeType, isDark)
        : getUserDisplaySmall(themeType, isDark);
  }

  /// Get headline large text style based on theme type and mode
  static TextStyle getHeadlineLarge(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminHeadlineLarge(themeType, isDark)
        : getUserHeadlineLarge(themeType, isDark);
  }

  /// Get headline medium text style based on theme type and mode
  static TextStyle getHeadlineMedium(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminHeadlineMedium(themeType, isDark)
        : getUserHeadlineMedium(themeType, isDark);
  }

  /// Get headline small text style based on theme type and mode
  static TextStyle getHeadlineSmall(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminHeadlineSmall(themeType, isDark)
        : getUserHeadlineSmall(themeType, isDark);
  }

  /// Get title large text style based on theme type and mode
  static TextStyle getTitleLarge(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminTitleLarge(themeType, isDark)
        : getUserTitleLarge(themeType, isDark);
  }

  /// Get title medium text style based on theme type and mode
  static TextStyle getTitleMedium(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminTitleMedium(themeType, isDark)
        : getUserTitleMedium(themeType, isDark);
  }

  /// Get title small text style based on theme type and mode
  static TextStyle getTitleSmall(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminTitleSmall(themeType, isDark)
        : getUserTitleSmall(themeType, isDark);
  }

  /// Get body large text style based on theme type and mode
  static TextStyle getBodyLarge(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminBodyLarge(themeType, isDark)
        : getUserBodyLarge(themeType, isDark);
  }

  /// Get body medium text style based on theme type and mode
  static TextStyle getBodyMedium(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminBodyMedium(themeType, isDark)
        : getUserBodyMedium(themeType, isDark);
  }

  /// Get body small text style based on theme type and mode
  static TextStyle getBodySmall(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminBodySmall(themeType, isDark)
        : getUserBodySmall(themeType, isDark);
  }

  /// Get label large text style based on theme type and mode
  static TextStyle getLabelLarge(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminLabelLarge(themeType, isDark)
        : getUserLabelLarge(themeType, isDark);
  }

  /// Get label medium text style based on theme type and mode
  static TextStyle getLabelMedium(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminLabelMedium(themeType, isDark)
        : getUserLabelMedium(themeType, isDark);
  }

  /// Get label small text style based on theme type and mode
  static TextStyle getLabelSmall(ECThemeType themeType, bool isDark) {
    return themeType == ECThemeType.admin
        ? getAdminLabelSmall(themeType, isDark)
        : getUserLabelSmall(themeType, isDark);
  }
}
