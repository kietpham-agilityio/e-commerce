import 'package:flutter/material.dart';

import '../app_shadows.dart';
import '../ec_theme_extension.dart';

/// Icon button widget with customizable colors, size, and optional shadow
class EcIconButton extends StatelessWidget {
  /// The icon to display
  final Widget icon;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// Whether the button is enabled
  final bool enabled;

  /// Custom background color override
  final Color? backgroundColor;

  /// Custom icon color override
  final Color? iconColor;

  /// Button size (width and height)
  final double? size;

  /// Border radius for the button
  final double? borderRadius;

  /// Whether to show shadow
  final bool showShadow;

  /// Custom shadow to use
  final BoxShadow? customShadow;

  /// Padding around the icon
  final EdgeInsetsGeometry? iconPadding;

  /// Tooltip text for accessibility
  final String? tooltip;

  /// Semantic label for accessibility
  final String? semanticsLabel;

  /// Focus node for the button
  final FocusNode? focusNode;

  /// Whether the button should autofocus
  final bool autofocus;

  const EcIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled = true,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.borderRadius,
    this.showShadow = false,
    this.customShadow,
    this.iconPadding,
    this.tooltip,
    this.semanticsLabel,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context).extension<EcThemeExtension>()!;
    final colors = ecTheme.colors;
    final sizing = ecTheme.sizing;

    // Determine button size
    final buttonSize = size ?? sizing.iconButtonBig;

    // Determine colors
    final bgColor = backgroundColor ?? colors.primary;
    final iconColorValue = iconColor ?? colors.onPrimary;

    // Determine border radius
    final radius = borderRadius ?? 25.0; // Default radius from themes.dart

    // Determine shadow
    final shadow = customShadow ?? EcShadows.dropShadowMedium(context);

    Widget buttonWidget = Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: enabled ? bgColor : bgColor.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: showShadow ? [shadow] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: enabled ? onPressed : null,
          focusNode: focusNode,
          autofocus: autofocus,
          child: IconTheme(
            data: IconThemeData(
              color:
                  enabled
                      ? iconColorValue
                      : iconColorValue.withValues(alpha: 0.7),
              size: sizing.icon,
            ),
            child: icon,
          ),
        ),
      ),
    );

    // Wrap with tooltip if provided
    if (tooltip != null) {
      buttonWidget = Tooltip(message: tooltip!, child: buttonWidget);
    }

    // Wrap with semantics if provided
    if (semanticsLabel != null) {
      buttonWidget = Semantics(
        label: semanticsLabel,
        button: true,
        enabled: enabled,
        child: buttonWidget,
      );
    }

    return buttonWidget;
  }
}

/// Predefined icon button sizes for convenience
class EcIconButtonSizes {
  EcIconButtonSizes._();

  /// Small icon button size (36px)
  static const double small = 36;

  /// Medium icon button size (48px)
  static const double medium = 48;

  /// Large icon button size (52px)
  static const double large = 52;
}

/// Predefined border radius values for icon buttons
class EcIconButtonRadius {
  EcIconButtonRadius._();

  /// Small radius (8px)
  static const double small = 8;

  /// Medium radius (16px)
  static const double medium = 16;

  /// Large radius (25px) - default
  static const double large = 25;

  /// Fully rounded (50% of size)
  static double fullyRounded(double size) => size / 2;
}
