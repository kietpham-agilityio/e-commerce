import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

/// {@template ec_filter}
/// A filter bar widget for product or item lists, providing filter, sort, and view mode controls.
///
/// Displays three interactive controls:
/// - A filter button (with icon and label) that triggers [onFilter] when tapped.
/// - A sort-by button (with icon and current [sortBy] label) that triggers [onSortBy] when tapped.
/// - A view mode toggle (list or grid icon) that triggers [onChangeViewMode] when tapped.
///
/// The widget adapts its spacing and text using the current theme and localization.
///
/// Example usage:
/// ```dart
/// EcFilter(
///   sortBy: 'Price: Low to High',
///   isListView: true,
///   onFilter: () => print('Filter tapped'),
///   onSortBy: () => print('Sort tapped'),
///   onChangeViewMode: () => print('View mode changed'),
/// )
/// ```
///
/// See also:
/// - [EcThemeExtension] for theme-based spacing.
/// - [AppLocale] for localization.
/// {@endtemplate}
class EcFilter extends StatelessWidget {
  /// Creates a filter bar with filter, sort, and view mode controls.
  ///
  /// [sortBy] is the current sort label to display.
  /// [isListView] determines which view mode icon is shown (list or grid).
  /// [onFilter], [onSortBy], and [onChangeViewMode] are callbacks for the respective controls.
  const EcFilter({
    required this.sortBy,
    this.isListView = true,
    this.onFilter,
    this.onSortBy,
    this.onChangeViewMode,
    super.key,
  });

  /// The current sort label to display.
  final String sortBy;

  /// Whether the current view mode is list (true) or grid (false).
  final bool isListView;

  /// Callback when the filter button is tapped.
  final VoidCallback? onFilter;

  /// Callback when the sort-by button is tapped.
  final VoidCallback? onSortBy;

  /// Callback when the view mode toggle is tapped.
  final VoidCallback? onChangeViewMode;

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<EcThemeExtension>()!;
    final spacing = themeExt.spacing;
    final l10n = AppLocale.of(context)!;

    final viewMode = switch (isListView) {
      true => EcAssets.listView(),
      false => EcAssets.gridView(),
    };

    return IntrinsicWidth(
      stepWidth: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onFilter,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                EcAssets.filter(),
                SizedBox(width: spacing.xs),
                EcLabelSmallText(l10n.generalFiltersBtn),
              ],
            ),
          ),
          GestureDetector(
            onTap: onSortBy,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                EcAssets.swap(),
                SizedBox(width: spacing.xs),
                EcLabelSmallText(sortBy, fontWeight: EcTypography.semiBold),
              ],
            ),
          ),
          GestureDetector(onTap: onChangeViewMode, child: viewMode),
        ],
      ),
    );
  }
}
