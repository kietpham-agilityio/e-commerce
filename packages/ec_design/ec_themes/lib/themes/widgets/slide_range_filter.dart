import 'package:flutter/material.dart';

import '../ec_theme_extension.dart';
import 'text.dart';

/// A customizable slide range filter widget for selecting a range of values.
///
/// The EcSlideRangeFilter widget provides a range slider with:
/// - Theme-aware styling using the design system colors
/// - Typography integration using EcTypography
/// - Customizable min/max values and step size
/// - Value display with formatting options
/// - Callback for value changes
/// - Accessibility support
class EcSlideRangeFilter extends StatefulWidget {
  /// The minimum value of the range
  final double min;

  /// The maximum value of the range
  final double max;

  /// The current lower value of the range
  final double lowerValue;

  /// The current upper value of the range
  final double upperValue;

  /// Callback when the range values change
  final ValueChanged<RangeValues>? onChanged;

  /// Callback when the user starts changing the range
  final ValueChanged<RangeValues>? onChangeStart;

  /// Callback when the user stops changing the range
  final ValueChanged<RangeValues>? onChangeEnd;

  /// The step size for the slider
  final double? divisions;

  /// Whether the slider is enabled
  final bool enabled;

  /// Custom active color for the slider
  final Color? activeColor;

  /// Custom inactive color for the slider
  final Color? inactiveColor;

  /// Custom thumb color for the slider
  final Color? thumbColor;

  /// Custom overlay color for the slider
  final Color? overlayColor;

  /// Custom height of the slider track
  final double? trackHeight;

  /// Custom height of the slider thumb
  final double? thumbHeight;

  /// Custom width of the slider thumb
  final double? thumbWidth;

  /// Whether to show the current values above the slider
  final bool showValues;

  /// Custom formatter for displaying values
  final String Function(double)? valueFormatter;

  /// Custom label for the range filter
  final String? label;

  /// Custom spacing between elements
  final double? spacing;

  /// Custom padding around the widget
  final EdgeInsets? padding;

  const EcSlideRangeFilter({
    super.key,
    required this.min,
    required this.max,
    required this.lowerValue,
    required this.upperValue,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.divisions,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.overlayColor,
    this.trackHeight,
    this.thumbHeight,
    this.thumbWidth,
    this.showValues = true,
    this.valueFormatter,
    this.label,
    this.spacing,
    this.padding,
  });

  @override
  State<EcSlideRangeFilter> createState() => _EcSlideRangeFilterState();
}

class _EcSlideRangeFilterState extends State<EcSlideRangeFilter> {
  late double _lowerValue;
  late double _upperValue;

  @override
  void initState() {
    super.initState();
    _lowerValue = widget.lowerValue.clamp(widget.min, widget.max);
    _upperValue = widget.upperValue.clamp(widget.min, widget.max);
  }

  @override
  void didUpdateWidget(EcSlideRangeFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lowerValue != widget.lowerValue) {
      _lowerValue = widget.lowerValue.clamp(widget.min, widget.max);
    }
    if (oldWidget.upperValue != widget.upperValue) {
      _upperValue = widget.upperValue.clamp(widget.min, widget.max);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final colors = themeExtension.colors;
    final spacing = themeExtension.spacing;

    // Get effective colors
    final effectiveActiveColor = widget.activeColor ?? colors.primary;
    final effectiveInactiveColor =
        widget.inactiveColor ?? colors.outline.withValues(alpha: 0.3);
    final effectiveOverlayColor =
        widget.overlayColor ?? colors.primary.withValues(alpha: 0.12);

    // Get effective spacing
    final effectiveSpacing = widget.spacing ?? spacing.sm;

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          if (widget.label != null) ...[
            EcLabelMediumText(
              widget.label!,
              color:
                  widget.enabled ? colors.secondary : colors.onSurfaceVariant,
            ),
            SizedBox(height: effectiveSpacing),
          ],

          // Value display
          if (widget.showValues) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EcBodyMediumText(
                  _formatValue(_lowerValue),
                  color:
                      widget.enabled
                          ? colors.secondary
                          : colors.onSurfaceVariant,
                ),
                EcBodyMediumText(
                  _formatValue(_upperValue),
                  color:
                      widget.enabled
                          ? colors.secondary
                          : colors.onSurfaceVariant,
                ),
              ],
            ),
            SizedBox(height: effectiveSpacing),
          ],

          // Range slider
          RangeSlider(
            values: RangeValues(
              _lowerValue.clamp(widget.min, widget.max),
              _upperValue.clamp(widget.min, widget.max),
            ),
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions?.toInt(),
            onChanged: widget.enabled ? _onRangeChanged : null,
            onChangeStart: widget.enabled ? _onRangeChangeStart : null,
            onChangeEnd: widget.enabled ? _onRangeChangeEnd : null,
            activeColor: effectiveActiveColor,
            inactiveColor: effectiveInactiveColor,
            overlayColor: WidgetStateProperty.all(effectiveOverlayColor),
          ),

          // Min/Max labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EcBodySmallText(
                _formatValue(widget.min),
                color: colors.onSurfaceVariant,
              ),
              EcBodySmallText(
                _formatValue(widget.max),
                color: colors.onSurfaceVariant,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onRangeChanged(RangeValues values) {
    setState(() {
      _lowerValue = values.start.clamp(widget.min, widget.max);
      _upperValue = values.end.clamp(widget.min, widget.max);
    });
    widget.onChanged?.call(RangeValues(_lowerValue, _upperValue));
  }

  void _onRangeChangeStart(RangeValues values) {
    widget.onChangeStart?.call(values);
  }

  void _onRangeChangeEnd(RangeValues values) {
    widget.onChangeEnd?.call(values);
  }

  String _formatValue(double value) {
    if (widget.valueFormatter != null) {
      return widget.valueFormatter!(value);
    }

    // Default formatting based on the value
    if (value == value.toInt().toDouble()) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(1);
    }
  }
}

/// A widget that displays multiple EcSlideRangeFilter widgets in a column with proper spacing
class EcSlideRangeFilterColumn extends StatelessWidget {
  /// List of range filters to display
  final List<EcSlideRangeFilter> filters;

  /// Spacing between filters
  final double spacing;

  /// How to align the filters
  final MainAxisAlignment mainAxisAlignment;

  /// How to align filters horizontally
  final CrossAxisAlignment crossAxisAlignment;

  const EcSlideRangeFilterColumn({
    super.key,
    required this.filters,
    this.spacing = 24.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children:
          filters
              .expand((filter) => [filter, SizedBox(height: spacing)])
              .take(filters.length * 2 - 1)
              .toList(),
    );
  }
}

/// A widget that displays multiple EcSlideRangeFilter widgets in a row with proper spacing
class EcSlideRangeFilterRow extends StatelessWidget {
  /// List of range filters to display
  final List<EcSlideRangeFilter> filters;

  /// Spacing between filters
  final double spacing;

  /// How to align the filters
  final MainAxisAlignment mainAxisAlignment;

  /// How to align filters vertically
  final CrossAxisAlignment crossAxisAlignment;

  const EcSlideRangeFilterRow({
    super.key,
    required this.filters,
    this.spacing = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children:
          filters
              .expand((filter) => [filter, SizedBox(width: spacing)])
              .take(filters.length * 2 - 1)
              .toList(),
    );
  }
}
