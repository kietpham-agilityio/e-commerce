import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

/// A widget that displays a selectable palette of color options.
///
/// [EcColorSelector] allows users to select one or multiple colors from a list of [ColorOption]s.
/// It supports both single and multi-select modes, and notifies selection changes via [onChanged].
///
/// Example usage:
/// ```dart
/// EcColorSelector(
///   colors: [
///     ColorOption(key: 'Red', hex: '#FF0000'),
///     ColorOption(key: 'Blue', hex: '#0000FF'),
///   ],
///   singleSelect: true,
///   onChanged: (selected) {
///     print(selected.map((e) => e.key));
///   },
/// )
/// ```
///
/// The [initialSelected] parameter can be used to pre-select colors.
/// If [singleSelect] is true, only one color can be selected at a time.
/// Unavailable colors (where [ColorOption.isAvailable] is false) are shown with reduced opacity and are not selectable.
class EcColorSelector extends StatelessWidget {
  /// Creates a color selector widget.
  ///
  /// [colors] is the list of available color options.
  /// [onChanged] is called whenever the selection changes.
  /// [initialSelected] is the list of initially selected colors.
  /// [singleSelect] determines if only one color can be selected at a time.
  EcColorSelector({
    super.key,
    required this.colors,
    this.onChanged,
    this.initialSelected,
    this.singleSelect = false,
  });

  /// The list of color options to display.
  final List<ColorOption> colors;

  /// Callback when the selected colors change.
  final ValueChanged<List<ColorOption>>? onChanged;

  /// The list of initially selected color options.
  final List<ColorOption>? initialSelected;

  /// If true, only one color can be selected at a time.
  final bool singleSelect;

  /// Internal notifier for the selected color options.
  final ValueNotifier<List<ColorOption>> _selectedNotifier = ValueNotifier([]);

  /// Converts a hex string (e.g. "#FF0000") to a [Color].
  Color _hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Toggles the selection state of a [ColorOption].
  void _toggleSelection(ColorOption option) {
    final current = List<ColorOption>.from(_selectedNotifier.value);
    if (singleSelect) {
      _selectedNotifier.value = [option];
    } else {
      if (current.any((e) => e.key == option.key)) {
        current.removeWhere((e) => e.key == option.key);
      } else {
        current.add(option);
      }
      _selectedNotifier.value = current;
    }
    if (onChanged != null) {
      onChanged!(_selectedNotifier.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedNotifier.value = initialSelected ?? [];
    final ecTheme = Theme.of(context);
    final themeExt = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = themeExt.spacing;

    return ValueListenableBuilder<List<ColorOption>>(
      valueListenable: _selectedNotifier,
      builder: (context, selected, _) {
        return Wrap(
          spacing: spacing.md,
          runSpacing: spacing.md,
          children:
              colors.map((option) {
                final isSelected = selected.any((e) => e.key == option.key);
                final color = _hexToColor(option.hex);

                return GestureDetector(
                  onTap:
                      option.isAvailable
                          ? () => _toggleSelection(option)
                          : null,
                  child: Opacity(
                    opacity: option.isAvailable ? 1.0 : 0.4,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              isSelected
                                  ? ecTheme.colorScheme.primary
                                  : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: CircleAvatar(backgroundColor: color, radius: 18),
                    ),
                  ),
                );
              }).toList(),
        );
      },
    );
  }
}

/// Represents a selectable color option for [EcColorSelector].
///
/// [key] is a unique identifier or name for the color (e.g., "Red", "Beige").
/// [hex] is the color's hex code (e.g., "#FF0000").
/// [isAvailable] indicates if the color can be selected (defaults to true).
class ColorOption {
  /// The unique key or name of the color (e.g., "Red", "Beige").
  final String key;

  /// The hex code of the color (e.g., "#FF0000").
  final String hex;

  /// Whether this color option is available for selection.
  final bool isAvailable;

  /// Creates a [ColorOption].
  const ColorOption({
    required this.key,
    required this.hex,
    this.isAvailable = true,
  });
}
