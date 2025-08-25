import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography scale for the e-commerce design system
///
/// This class defines the typography scale with consistent sizing,
/// line heights, and font weights for different text styles.
class EcTypography {
  EcTypography._();

  // Font families
  static const String fontFamily = 'Metropolis';

  // Default colors - using EcColors
  static Color get _defaultTextColor => EcColors.light(ECThemeType.user).secondary;
  static Color get _defaultSecondaryTextColor => EcColors.light(ECThemeType.user).outline;

  // Font weights - Metropolis font weights
  static const FontWeight regular = FontWeight.w400; // Metropolis-Regular.otf
  static const FontWeight medium =
      FontWeight.w500; // Metropolis-Medium.otf (normal/default)
  static const FontWeight semiBold = FontWeight.w600; // Metropolis-SemiBold.otf
  static const FontWeight bold = FontWeight.w700; // Metropolis-Bold.otf

  // Font sizes
  static const double xs = 10.0;
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
  static const double tightHeight = 1.25;
  static const double normalHeight = 1.5;
  static const double relaxedHeight = 1.75;

  // Letter spacing
  static const double tightSpacing = -0.5;
  static const double normalSpacing = 0.0;
  static const double wideSpacing = 0.5;

  /// Display large text style - for hero titles
  static TextStyle get displayLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: massive,
    fontWeight: bold,
    height: tightHeight,
    letterSpacing: tightSpacing,
    color: _defaultTextColor,
  );

  /// Display medium text style - for section headers
  static TextStyle get displayMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: giant,
    fontWeight: bold,
    height: tightHeight,
    letterSpacing: tightSpacing,
    color: _defaultTextColor,
  );

  /// Display small text style - for subsection headers
  static TextStyle get displaySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: huge,
    fontWeight: semiBold,
    height: tightHeight,
    letterSpacing: tightSpacing,
    color: _defaultTextColor,
  );

  /// Headline large text style - for main page titles
  static TextStyle get headlineLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: xxxl,
    fontWeight: semiBold,
    height: tightHeight,
    letterSpacing: normalSpacing,
    color: _defaultTextColor,
  );

  /// Headline medium text style - for page titles
  static TextStyle get headlineMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: xxl,
    fontWeight: semiBold,
    height: tightHeight,
    letterSpacing: normalSpacing,
    color: _defaultTextColor,
  );

  /// Headline small text style - for section titles
  static TextStyle get headlineSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: xl,
    fontWeight: semiBold,
    height: tightHeight,
    letterSpacing: normalSpacing,
    color: _defaultTextColor,
  );

  /// Title large text style - for card titles
  static TextStyle get titleLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: lg,
    fontWeight: medium,
    height: normalHeight,
    letterSpacing: normalSpacing,
    color: _defaultTextColor,
  );

  /// Title medium text style - for list item titles
  static TextStyle get titleMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: base,
    fontWeight: medium,
    height: normalHeight,
    letterSpacing: normalSpacing,
    color: _defaultTextColor,
  );

  /// Title small text style - for small titles
  static TextStyle get titleSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: sm,
    fontWeight: medium,
    height: normalHeight,
    letterSpacing: wideSpacing,
    color: _defaultTextColor,
  );

  /// Body large text style - for main content
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: lg,
    fontWeight: regular,
    height: relaxedHeight,
    letterSpacing: normalSpacing,
    color: _defaultTextColor,
  );

  /// Body medium text style - for regular content
  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: base,
    fontWeight: regular,
    height: relaxedHeight,
    letterSpacing: normalSpacing,
    color: _defaultTextColor,
  );

  /// Body small text style - for secondary content
  static TextStyle get bodySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: sm,
    fontWeight: regular,
    height: relaxedHeight,
    letterSpacing: wideSpacing,
    color: _defaultSecondaryTextColor,
  );

  /// Label large text style - for form labels
  static TextStyle get labelLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: base,
    fontWeight: medium,
    height: normalHeight,
    letterSpacing: wideSpacing,
    color: _defaultTextColor,
  );

  /// Label medium text style - for small labels
  static TextStyle get labelMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: base,
    fontWeight: medium,
    height: normalHeight,
    letterSpacing: wideSpacing,
    color: _defaultTextColor,
  );

  /// Label small text style - for tiny labels
  static TextStyle get labelSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: xs,
    fontWeight: medium,
    height: normalHeight,
    letterSpacing: wideSpacing,
    color: _defaultTextColor,
  );

  /// Caption text style - for captions and metadata
  static TextStyle get caption => TextStyle(
    fontFamily: fontFamily,
    fontSize: xs,
    fontWeight: regular,
    height: normalHeight,
    letterSpacing: wideSpacing,
    color: _defaultSecondaryTextColor,
  );

  /// Overline text style - for overlines and small text
  static TextStyle get overline => TextStyle(
    fontFamily: fontFamily,
    fontSize: xs,
    fontWeight: medium,
    height: normalHeight,
    letterSpacing: wideSpacing,
    color: _defaultSecondaryTextColor,
  );

  /// Button text style - for button labels
  static TextStyle get button => TextStyle(
    fontFamily: fontFamily,
    fontSize: base,
    fontWeight: medium,
    height: normalHeight,
    letterSpacing: wideSpacing,
    color: _defaultTextColor,
  );

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
  
  // Theme-aware typography methods using EcColors
  static TextStyle getDisplayLarge(ECThemeType themeType, bool isDark) {
    final colors = isDark 
        ? EcColors.dark(themeType) 
        : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: massive,
      fontWeight: bold,
      height: tightHeight,
      letterSpacing: tightSpacing,
      color: colors.secondary,
    );
  }
  
  static TextStyle getBodyMedium(ECThemeType themeType, bool isDark) {
    final colors = isDark 
        ? EcColors.dark(themeType) 
        : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: base,
      fontWeight: regular,
      height: relaxedHeight,
      letterSpacing: normalSpacing,
      color: colors.secondary,
    );
  }
  
  static TextStyle getCaption(ECThemeType themeType, bool isDark) {
    final colors = isDark 
        ? EcColors.dark(themeType) 
        : EcColors.light(themeType);
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: xs,
      fontWeight: regular,
      height: normalHeight,
      letterSpacing: wideSpacing,
      color: colors.outline,
    );
  }
}
