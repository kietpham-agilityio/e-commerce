import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

/// Different styles for the EcLabel widget
enum EcLabelStyle {
  /// Primary style - filled with primary color and onPrimary text
  primary,

  /// Secondary style - filled with secondary color and onSecondary text
  secondary,
}

/// A customizable label widget for displaying promotional text like "-20%", "new", or "hot".
///
/// The EcLabel widget provides a rounded rectangular container with:
/// - Padding of 7 pixels on all sides
/// - Corner radius of 29 pixels
/// - Primary or secondary color scheme
/// - Appropriate text styling using EcTypography
class EcLabel extends StatelessWidget {
  /// The text to display in the label
  final String text;

  /// The style of the label
  final EcLabelStyle style;

  /// Custom padding override (optional)
  final EdgeInsets? padding;

  /// Custom border radius override (optional)
  final double? borderRadius;

  /// Custom background color override (optional)
  final Color? backgroundColor;

  /// Custom text color override (optional)
  final Color? textColor;

  /// Custom font size override (optional)
  final double? fontSize;

  /// Custom font weight override (optional)
  final FontWeight? fontWeight;

  const EcLabel({
    super.key,
    required this.text,
    this.style = EcLabelStyle.primary,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context).extension<EcThemeExtension>()!;
    final colors = ecTheme.colors;

    // Get style-specific properties
    final styleProperties = _getStyleProperties(colors);

    // Apply overrides if provided
    final effectivePadding = padding ?? const EdgeInsets.all(7.0);
    final effectiveBorderRadius = borderRadius ?? 29.0;
    final effectiveBackgroundColor =
        backgroundColor ?? styleProperties.backgroundColor;
    final effectiveTextColor = textColor ?? styleProperties.textColor;

    return Container(
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
      ),
      child: EcLabelSmallText(text, color: effectiveTextColor),
    );
  }

  /// Get style-specific properties based on the current style
  _StyleProperties _getStyleProperties(ColorScheme colors) {
    switch (style) {
      case EcLabelStyle.primary:
        return _StyleProperties(
          backgroundColor: colors.primary,
          textColor: colors.onPrimary,
        );

      case EcLabelStyle.secondary:
        return _StyleProperties(
          backgroundColor: colors.secondary,
          textColor: colors.onSecondary,
        );
    }
  }
}

/// Internal class to hold style properties
class _StyleProperties {
  final Color backgroundColor;
  final Color textColor;

  const _StyleProperties({
    required this.backgroundColor,
    required this.textColor,
  });
}

/// A widget that displays multiple EcLabel widgets in a row with proper spacing
class EcLabelRow extends StatelessWidget {
  /// List of labels to display
  final List<EcLabel> labels;

  /// Spacing between labels
  final double spacing;

  /// How to align the labels
  final MainAxisAlignment mainAxisAlignment;

  /// How to align labels vertically
  final CrossAxisAlignment crossAxisAlignment;

  const EcLabelRow({
    super.key,
    required this.labels,
    this.spacing = 8.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children:
          labels
              .expand((label) => [label, SizedBox(width: spacing)])
              .take(labels.length * 2 - 1)
              .toList(),
    );
  }
}

/// A widget that displays multiple EcLabel widgets in a column with proper spacing
class EcLabelColumn extends StatelessWidget {
  /// List of labels to display
  final List<EcLabel> labels;

  /// Spacing between labels
  final double spacing;

  /// How to align the labels
  final MainAxisAlignment mainAxisAlignment;

  /// How to align labels horizontally
  final CrossAxisAlignment crossAxisAlignment;

  const EcLabelColumn({
    super.key,
    required this.labels,
    this.spacing = 8.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children:
          labels
              .expand((label) => [label, SizedBox(height: spacing)])
              .take(labels.length * 2 - 1)
              .toList(),
    );
  }
}

/// A widget that displays multiple EcLabel widgets in a wrap with proper spacing
class EcLabelWrap extends StatelessWidget {
  /// List of labels to display
  final List<EcLabel> labels;

  /// Spacing between labels horizontally
  final double horizontalSpacing;

  /// Spacing between labels vertically
  final double verticalSpacing;

  /// How to align the labels
  final WrapAlignment alignment;

  /// How to align labels vertically
  final WrapCrossAlignment crossAxisAlignment;

  const EcLabelWrap({
    super.key,
    required this.labels,
    this.horizontalSpacing = 8.0,
    this.verticalSpacing = 8.0,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: horizontalSpacing,
      runSpacing: verticalSpacing,
      alignment: alignment,
      crossAxisAlignment: crossAxisAlignment,
      children: labels,
    );
  }
}
