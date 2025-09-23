import 'package:ec_themes/themes/typography.dart';
import 'package:flutter/material.dart';

/// Base class for all text widgets with common functionality
abstract class BaseEcText extends StatelessWidget {
  const BaseEcText(
    this.text, {
    super.key,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.textDirection,
    this.color,
    this.fontWeight,
    this.height,
    this.letterSpacing,
    this.fontSize,
  });

  /// The text to display
  final String text;

  /// How the text should be aligned horizontally
  final TextAlign? textAlign;

  /// How visual overflow should be handled
  final TextOverflow? overflow;

  /// An optional maximum number of lines for the text to span
  final int? maxLines;

  /// Whether the text should break at soft line breaks
  final bool? softWrap;

  /// The directionality of the text
  final TextDirection? textDirection;

  /// Custom color override
  final Color? color;

  /// Custom font weight override
  final FontWeight? fontWeight;

  /// Custom line height override
  final double? height;

  /// Custom letter spacing override
  final double? letterSpacing;

  final double? fontSize;

  /// Get the base text style for this widget
  TextStyle get baseStyle;

  @override
  Widget build(BuildContext context) {
    // Build the base style
    TextStyle finalStyle = baseStyle;

    // Apply custom overrides
    finalStyle = finalStyle.copyWith(
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      fontSize: fontSize,
    );

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }
}

/// Display large text widget - for hero titles
class EcDisplayLargeText extends BaseEcText {
  const EcDisplayLargeText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.displayLarge;
}

/// Display medium text widget - for section headers
class EcDisplayMediumText extends BaseEcText {
  const EcDisplayMediumText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
    super.fontSize,
  });

  @override
  TextStyle get baseStyle => EcTypography.displayMedium;
}

/// Display small text widget - for subsection headers
class EcDisplaySmallText extends BaseEcText {
  const EcDisplaySmallText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.displaySmall;
}

/// Headline large text widget - for main page titles
class EcHeadlineLargeText extends BaseEcText {
  const EcHeadlineLargeText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.headlineLarge;
}

/// Headline medium text widget - for page titles
class EcHeadlineMediumText extends BaseEcText {
  const EcHeadlineMediumText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.headlineMedium;
}

/// Headline small text widget - for section titles
class EcHeadlineSmallText extends BaseEcText {
  const EcHeadlineSmallText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.headlineSmall;
}

/// Title large text widget - for card titles
class EcTitleLargeText extends BaseEcText {
  const EcTitleLargeText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.titleLarge;
}

/// Title medium text widget - for list item titles
class EcTitleMediumText extends BaseEcText {
  const EcTitleMediumText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.titleMedium;
}

/// Title small text widget - for small titles
class EcTitleSmallText extends BaseEcText {
  const EcTitleSmallText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.titleSmall;
}

/// Body large text widget - for main content
class EcBodyLargeText extends BaseEcText {
  const EcBodyLargeText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.bodyLarge;
}

/// Body medium text widget - for regular content
class EcBodyMediumText extends BaseEcText {
  const EcBodyMediumText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.bodyMedium;
}

/// Body small text widget - for secondary content
class EcBodySmallText extends BaseEcText {
  const EcBodySmallText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.bodySmall;
}

/// Label large text widget - for form labels
class EcLabelLargeText extends BaseEcText {
  const EcLabelLargeText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.labelLarge;
}

/// Label medium text widget - for small labels
class EcLabelMediumText extends BaseEcText {
  const EcLabelMediumText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.labelMedium;
}

/// Label small text widget - for tiny labels
class EcLabelSmallText extends BaseEcText {
  const EcLabelSmallText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });

  @override
  TextStyle get baseStyle => EcTypography.labelSmall;
}

/// Legacy EcText class for backward compatibility
/// @deprecated Use specific text widgets like EcHeadlineLargeText, EcBodyMediumText, etc.
@Deprecated(
  'Use specific text widgets like EcHeadlineLargeText, EcBodyMediumText, etc.',
)
class EcText extends EcBodyMediumText {
  const EcText(
    super.text, {
    super.key,
    super.textAlign,
    super.overflow,
    super.maxLines,
    super.softWrap,
    super.textDirection,
    super.color,
    super.fontWeight,
    super.height,
    super.letterSpacing,
  });
}
