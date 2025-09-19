import 'package:flutter/material.dart';
import '../ec_theme_extension.dart';
import '../app_sizing.dart';
import 'text.dart';

/// A customizable checkbox widget with text support that follows the design system.
///
/// The EcCheckbox widget provides a consistent checkbox implementation with:
/// - Theme-aware styling using the design system colors
/// - Typography integration using EcTypography
/// - Proper sizing using AppSizing
/// - Text support with customizable styling
/// - Accessibility support
class EcCheckbox extends StatelessWidget {
  /// The current value of the checkbox
  final bool? value;

  /// Callback when the checkbox value changes
  final ValueChanged<bool?>? onChanged;

  /// The text to display next to the checkbox
  final String? text;

  /// Custom text widget (alternative to text)
  final Widget? textWidget;

  /// Whether the checkbox is enabled
  final bool enabled;

  /// Whether the checkbox is in tristate mode (true, false, null)
  final bool tristate;

  /// Custom checkbox size
  final double? size;

  /// Custom spacing between checkbox and text
  final double? spacing;

  /// Custom text color
  final Color? textColor;

  /// Whether to wrap the text
  final bool textWrap;

  /// Maximum lines for text (when textWrap is true)
  final int? maxLines;

  /// Text overflow behavior
  final TextOverflow? textOverflow;

  /// Custom checkbox active color
  final Color? activeColor;

  /// Custom checkbox check color
  final Color? checkColor;

  /// Custom checkbox fill color
  final Color? fillColor;

  /// Custom checkbox side (border)
  final BorderSide? side;

  /// Custom splash radius
  final double? splashRadius;

  /// Custom focus node
  final FocusNode? focusNode;

  /// Whether the checkbox can be focused
  final bool autofocus;

  /// Custom semantics label
  final String? semanticsLabel;

  /// Custom semantics value
  final String? semanticsValue;

  /// Layout direction for checkbox and text
  /// - true: checkbox -> text (default)
  /// - false: text -> checkbox
  final bool checkboxFirst;

  const EcCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.text,
    this.textWidget,
    this.enabled = true,
    this.tristate = false,
    this.size,
    this.spacing,
    this.textColor,
    this.textWrap = false,
    this.maxLines,
    this.textOverflow,
    this.activeColor,
    this.checkColor,
    this.fillColor,
    this.side,
    this.splashRadius,
    this.focusNode,
    this.autofocus = false,
    this.semanticsLabel,
    this.semanticsValue,
    this.checkboxFirst = true,
  }) : assert(
         text == null || textWidget == null,
         'Cannot provide both text and textWidget',
       );

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context).extension<EcThemeExtension>()!;
    final colors = ecTheme.colors;
    final sizing = AppSizing(ecTheme.themeType);

    // Get effective values
    final effectiveSize = size ?? sizing.checkbox;
    final effectiveSpacing = spacing ?? 13.0;

    // Build the checkbox widget
    Widget checkboxWidget = Checkbox(
      value: value,
      onChanged: enabled ? onChanged : null,
      tristate: tristate,
      activeColor: activeColor ?? colors.primary,
      checkColor: checkColor ?? colors.onPrimary,
      fillColor:
          fillColor != null
              ? WidgetStateProperty.all(fillColor)
              : WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colors.primary;
                }
                return Colors.transparent;
              }),
      side: side ?? BorderSide(color: colors.outline, width: 2.0),
      splashRadius: splashRadius ?? effectiveSize * 0.5,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    );

    // If no text is provided, return just the checkbox
    if (text == null && textWidget == null) {
      return checkboxWidget;
    }

    // Build text widget
    Widget textWidgetChild =
        textWidget ??
        EcLabelMediumText(
          text!,
          maxLines: textWrap ? maxLines : 1,
          overflow: textWrap ? textOverflow : TextOverflow.ellipsis,
          color:
              textColor ??
              (checkboxFirst == false && value == true
                  ? colors.primary
                  : colors.secondary),
          fontWeight:
              checkboxFirst == false && value == true
                  ? FontWeight.bold
                  : FontWeight.normal,
        );

    // Build the complete widget
    return Semantics(
      label: semanticsLabel ?? text,
      value:
          semanticsValue ??
          (value == true
              ? 'checked'
              : value == false
              ? 'unchecked'
              : 'indeterminate'),
      child: InkWell(
        onTap: enabled ? () => onChanged?.call(!(value ?? false)) : null,
        borderRadius: BorderRadius.circular(4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment:
                checkboxFirst
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                checkboxFirst
                    ? [
                      checkboxWidget,
                      SizedBox(width: effectiveSpacing),
                      Flexible(child: textWidgetChild),
                    ]
                    : [textWidgetChild, checkboxWidget],
          ),
        ),
      ),
    );
  }
}

/// A widget that displays multiple EcCheckbox widgets in a column with proper spacing
class EcCheckboxColumn extends StatelessWidget {
  /// List of checkbox items to display
  final List<EcCheckboxItem> items;

  /// Spacing between checkboxes
  final double spacing;

  /// How to align the checkboxes
  final CrossAxisAlignment crossAxisAlignment;

  /// Whether to enable/disable all checkboxes
  final bool enabled;

  const EcCheckboxColumn({
    super.key,
    required this.items,
    this.spacing = 28.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children:
          items
              .map(
                (item) => Padding(
                  padding: EdgeInsets.only(bottom: spacing),
                  child: item.copyWith(enabled: enabled).toWidget(),
                ),
              )
              .toList(),
    );
  }
}

/// A data class representing a checkbox item with its properties
class EcCheckboxItem {
  /// The current value of the checkbox
  final bool? value;

  /// Callback when the checkbox value changes
  final ValueChanged<bool?>? onChanged;

  /// The text to display next to the checkbox
  final String? text;

  /// Custom text widget (alternative to text)
  final Widget? textWidget;

  /// Whether the checkbox is enabled
  final bool enabled;

  /// Whether the checkbox is in tristate mode
  final bool tristate;

  /// Custom checkbox size
  final double? size;

  /// Custom spacing between checkbox and text
  final double? spacing;

  /// Custom text style
  final TextStyle? textStyle;

  /// Custom text color
  final Color? textColor;

  /// Whether to wrap the text
  final bool textWrap;

  /// Maximum lines for text
  final int? maxLines;

  /// Text overflow behavior
  final TextOverflow? textOverflow;

  /// Custom checkbox active color
  final Color? activeColor;

  /// Custom checkbox check color
  final Color? checkColor;

  /// Custom checkbox fill color
  final Color? fillColor;

  /// Custom checkbox side (border)
  final BorderSide? side;

  /// Custom splash radius
  final double? splashRadius;

  /// Custom focus node
  final FocusNode? focusNode;

  /// Whether the checkbox can be focused
  final bool autofocus;

  /// Custom semantics label
  final String? semanticsLabel;

  /// Custom semantics value
  final String? semanticsValue;

  /// Layout direction for checkbox and text
  /// - true: checkbox -> text (default)
  /// - false: text -> checkbox
  final bool checkboxFirst;

  const EcCheckboxItem({
    required this.value,
    this.onChanged,
    this.text,
    this.textWidget,
    this.enabled = true,
    this.tristate = false,
    this.size,
    this.spacing,
    this.textStyle,
    this.textColor,
    this.textWrap = false,
    this.maxLines,
    this.textOverflow,
    this.activeColor,
    this.checkColor,
    this.fillColor,
    this.side,
    this.splashRadius,
    this.focusNode,
    this.autofocus = false,
    this.semanticsLabel,
    this.semanticsValue,
    this.checkboxFirst = true,
  });

  /// Create a copy of this item with updated properties
  EcCheckboxItem copyWith({
    bool? value,
    ValueChanged<bool?>? onChanged,
    String? text,
    Widget? textWidget,
    bool? enabled,
    bool? tristate,
    double? size,
    double? spacing,
    Color? textColor,
    bool? textWrap,
    int? maxLines,
    TextOverflow? textOverflow,
    Color? activeColor,
    Color? checkColor,
    Color? fillColor,
    BorderSide? side,
    double? splashRadius,
    FocusNode? focusNode,
    bool? autofocus,
    String? semanticsLabel,
    String? semanticsValue,
    bool? checkboxFirst,
  }) {
    return EcCheckboxItem(
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      text: text ?? this.text,
      textWidget: textWidget ?? this.textWidget,
      enabled: enabled ?? this.enabled,
      tristate: tristate ?? this.tristate,
      size: size ?? this.size,
      spacing: spacing ?? this.spacing,
      textColor: textColor ?? this.textColor,
      textWrap: textWrap ?? this.textWrap,
      maxLines: maxLines ?? this.maxLines,
      textOverflow: textOverflow ?? this.textOverflow,
      activeColor: activeColor ?? this.activeColor,
      checkColor: checkColor ?? this.checkColor,
      fillColor: fillColor ?? this.fillColor,
      side: side ?? this.side,
      splashRadius: splashRadius ?? this.splashRadius,
      focusNode: focusNode ?? this.focusNode,
      autofocus: autofocus ?? this.autofocus,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      semanticsValue: semanticsValue ?? this.semanticsValue,
      checkboxFirst: checkboxFirst ?? this.checkboxFirst,
    );
  }

  /// Convert to EcCheckbox widget
  EcCheckbox toWidget() {
    return EcCheckbox(
      value: value,
      onChanged: onChanged,
      text: text,
      textWidget: textWidget,
      enabled: enabled,
      tristate: tristate,
      size: size,
      spacing: spacing,
      textColor: textColor,
      textWrap: textWrap,
      maxLines: maxLines,
      textOverflow: textOverflow,
      activeColor: activeColor,
      checkColor: checkColor,
      fillColor: fillColor,
      side: side,
      splashRadius: splashRadius,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      checkboxFirst: checkboxFirst,
    );
  }
}
