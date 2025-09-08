import 'package:flutter/material.dart';
import '../app_shadows.dart';

/// Base class for all button widgets with common functionality
abstract class BaseEcButton extends StatelessWidget {
  const BaseEcButton({
    super.key,
    required this.text,
    this.onPressed,
    this.focusNode,
    this.child,
    this.icon,
    this.padding,
  });

  /// The text to display on the button
  final String text;

  /// Callback that is called when the button is tapped
  final VoidCallback? onPressed;

  /// Focus node for the button
  final FocusNode? focusNode;

  /// The content below the button
  final Widget? child;

  /// The icon to display on the button
  final Widget? icon;

  /// Padding around the button content
  final EdgeInsetsGeometry? padding;

  /// Get the button type for this widget
  ButtonType get buttonType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Build the appropriate button based on type
    switch (buttonType) {
      case ButtonType.elevated:
        return Container(
          decoration: BoxDecoration(
            boxShadow: [EcShadows.dropShadowMedium(context)],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            focusNode: focusNode,
            style: theme.elevatedButtonTheme.style,
            child: _buildButtonContent(),
          ),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          focusNode: focusNode,
          style: theme.outlinedButtonTheme.style,
          child: _buildButtonContent(),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          focusNode: focusNode,
          style: theme.textButtonTheme.style,
          child: _buildButtonContent(),
        );
    }
  }

  /// Build the button content (text and/or icon)
  Widget _buildButtonContent() {
    if (child != null) return child!;

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          const SizedBox(width: 4),
          Flexible(child: Text(text)),
        ],
      );
    }

    return Text(text);
  }
}

/// Button type enumeration
enum ButtonType { elevated, outlined, text }

/// Elevated button widget with design system integration
class EcElevatedButton extends BaseEcButton {
  const EcElevatedButton({
    super.key,
    required super.text,
    super.onPressed,
    super.focusNode,
    super.child,
    super.icon,
    super.padding,
  });

  @override
  ButtonType get buttonType => ButtonType.elevated;
}

/// Outlined button widget with design system integration
class EcOutlinedButton extends BaseEcButton {
  const EcOutlinedButton({
    super.key,
    required super.text,
    super.onPressed,
    super.focusNode,
    super.child,
    super.icon,
    super.padding,
  });

  @override
  ButtonType get buttonType => ButtonType.outlined;
}

/// Text button widget with design system integration
class EcTextButton extends BaseEcButton {
  const EcTextButton({
    super.key,
    required super.text,
    super.onPressed,
    super.focusNode,
    super.child,
    super.icon,
    super.padding,
  });

  @override
  ButtonType get buttonType => ButtonType.text;
}
