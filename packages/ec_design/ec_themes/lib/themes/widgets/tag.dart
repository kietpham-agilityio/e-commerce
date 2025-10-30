import 'package:flutter/material.dart';

import '../ec_theme_extension.dart';
import '../typography.dart';

/// Different styles for the EcTag widget
enum EcTagStyle {
  /// Pair 1 - Unselected state: Rounded rectangular with corner radius 8, filled color is primaryContainer,
  /// border color is outline with 0.4 stroke width, text is 14px font size,
  /// width is 100, height is 40
  outlinedUnselected,

  /// Pair 1 - Selected state: Same as outlinedUnselected but with primary color for filled & onPrimary color for text & no border
  outlinedSelected,

  /// Pair 2 - Unselected state: Rounded rectangular with corner radius 29, filled color is surface,
  /// text color is onSurface, no border, text is 14px font size, width is 100, height is 30
  roundedUnselected,

  /// Pair 2 - Selected state: Same as roundedUnselected but filled color is secondary & text color is onSecondary
  roundedSelected,
}

/// A customizable tag widget that supports multiple selection for filtering purposes.
///
/// The EcTag widget provides 4 different styles organized in 2 pairs:
///
/// **Pair 1 - Outlined Style:**
/// - [EcTagStyle.outlinedUnselected]: Unselected outlined style with border
/// - [EcTagStyle.outlinedSelected]: Selected outlined style with primary colors
///
/// **Pair 2 - Rounded Style:**
/// - [EcTagStyle.roundedUnselected]: Unselected rounded style with surface colors
/// - [EcTagStyle.roundedSelected]: Selected rounded style with secondary colors
class EcTag extends StatelessWidget {
  /// The text to display in the tag
  final String text;

  /// The style of the tag
  final EcTagStyle style;

  /// Whether the tag is selected
  final bool isSelected;

  /// Callback when the tag is tapped
  final VoidCallback? onTap;

  /// Whether the tag is enabled (can be tapped)
  final bool enabled;

  /// Custom width override (optional)
  final double? width;

  /// Custom height override (optional)
  final double? height;

  /// Custom border radius override (optional)
  final double? borderRadius;

  /// Custom background color override (optional)
  final Color? backgroundColor;

  /// Custom text color override (optional)
  final Color? textColor;

  /// Custom border color override (optional)
  final Color? borderColor;

  /// Custom border width override (optional)
  final double? borderWidth;

  const EcTag({
    super.key,
    required this.text,
    this.style = EcTagStyle.outlinedUnselected,
    this.isSelected = false,
    this.onTap,
    this.enabled = true,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context).extension<EcThemeExtension>()!;
    final colors = ecTheme.colors;

    // Get style-specific properties
    final styleProperties = _getStyleProperties(colors);

    // Apply overrides if provided
    final effectiveWidth = width ?? styleProperties.width;
    final effectiveHeight = height ?? styleProperties.height;
    final effectiveBorderRadius = borderRadius ?? styleProperties.borderRadius;
    final effectiveBackgroundColor =
        backgroundColor ?? styleProperties.backgroundColor;
    final effectiveTextColor = textColor ?? styleProperties.textColor;
    final effectiveBorderColor = borderColor ?? styleProperties.borderColor;
    final effectiveBorderWidth = borderWidth ?? styleProperties.borderWidth;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: effectiveWidth,
        height: effectiveHeight,
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          border:
              effectiveBorderWidth > 0
                  ? Border.all(
                    color: effectiveBorderColor,
                    width: effectiveBorderWidth,
                  )
                  : null,
        ),
        child: Center(
          child: Text(
            text,
            style: EcTypography.getUserLabelMedium(
              ecTheme.themeType,
              ecTheme.isDark,
            ).copyWith(color: effectiveTextColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  /// Get style-specific properties based on the current style
  _StyleProperties _getStyleProperties(ColorScheme colors) {
    switch (style) {
      case EcTagStyle.outlinedUnselected:
        return _StyleProperties(
          width: 100,
          height: 40,
          borderRadius: 8,
          backgroundColor: colors.primaryContainer,
          textColor: colors.onPrimaryContainer,
          borderColor: colors.outline,
          borderWidth: 0.4,
        );

      case EcTagStyle.outlinedSelected:
        return _StyleProperties(
          width: 100,
          height: 40,
          borderRadius: 8,
          backgroundColor: colors.primary,
          textColor: colors.onPrimary,
          borderColor: Colors.transparent,
          borderWidth: 0,
        );

      case EcTagStyle.roundedUnselected:
        return _StyleProperties(
          width: 100,
          height: 30,
          borderRadius: 29,
          backgroundColor: colors.outline,
          textColor: colors.onSurface,
          borderColor: Colors.transparent,
          borderWidth: 0,
        );

      case EcTagStyle.roundedSelected:
        return _StyleProperties(
          width: 100,
          height: 30,
          borderRadius: 29,
          backgroundColor: colors.secondary,
          textColor: colors.onSecondary,
          borderColor: Colors.transparent,
          borderWidth: 0,
        );
    }
  }
}

/// Internal class to hold style properties
class _StyleProperties {
  final double width;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderWidth;

  const _StyleProperties({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.borderWidth,
  });
}

/// A widget that displays multiple EcTag widgets in a row with proper spacing
class EcTagRow extends StatelessWidget {
  /// List of tags to display
  final List<EcTag> tags;

  /// Spacing between tags
  final double spacing;

  /// How to align the tags
  final MainAxisAlignment mainAxisAlignment;

  /// How to align tags vertically
  final CrossAxisAlignment crossAxisAlignment;

  const EcTagRow({
    super.key,
    required this.tags,
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
          tags
              .expand((tag) => [tag, SizedBox(width: spacing)])
              .take(tags.length * 2 - 1)
              .toList(),
    );
  }
}

/// A widget that displays multiple EcTag widgets in a column with proper spacing
class EcTagColumn extends StatelessWidget {
  /// List of tags to display
  final List<EcTag> tags;

  /// Spacing between tags
  final double spacing;

  /// How to align the tags
  final MainAxisAlignment mainAxisAlignment;

  /// How to align tags horizontally
  final CrossAxisAlignment crossAxisAlignment;

  const EcTagColumn({
    super.key,
    required this.tags,
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
          tags
              .expand((tag) => [tag, SizedBox(height: spacing)])
              .take(tags.length * 2 - 1)
              .toList(),
    );
  }
}

/// A widget that displays multiple EcTag widgets in a wrap with proper spacing
class EcTagWrap extends StatelessWidget {
  /// List of tags to display
  final List<EcTag> tags;

  /// Spacing between tags horizontally
  final double horizontalSpacing;

  /// Spacing between tags vertically
  final double verticalSpacing;

  /// How to align the tags
  final WrapAlignment alignment;

  /// How to align tags vertically
  final WrapCrossAlignment crossAxisAlignment;

  const EcTagWrap({
    super.key,
    required this.tags,
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
      children: tags,
    );
  }
}
