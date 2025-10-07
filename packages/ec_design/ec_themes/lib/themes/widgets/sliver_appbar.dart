import 'dart:ui';

import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

/// A customizable sliver app bar widget that adapts to the EC design system.
///
/// The [EcSliverAppBar] provides a Material 3-compliant sliver app bar with smooth
/// transitions between expanded and collapsed states. It uses the EC theme extension
/// and sizing system for consistent appearance across the app.
///
/// Features:
/// - Animated title font size and alignment as the app bar collapses/expands
/// - Customizable leading widget and actions
/// - Theme-aware sizing and styling
/// - Supports Material 3 and Flutter 3.x best practices
class EcSliverAppBar extends StatelessWidget {
  /// Creates an EC design system sliver app bar.
  ///
  /// [title] is required and displayed as the app bar's main text.
  /// [pinned] determines if the app bar remains visible when scrolled.
  /// [titleMaxLines] sets the maximum number of lines for the title.
  /// [actions] are displayed at the end of the app bar.
  /// [leading] is displayed at the start of the app bar.
  const EcSliverAppBar({
    required this.title,
    this.pinned = true,
    this.titleMaxLines = 1,
    this.actions,
    this.leading,
    super.key,
  });

  /// The main title text of the app bar.
  final String title;

  /// List of widgets to display as actions at the end of the app bar.
  final List<Widget>? actions;

  /// Widget to display at the start of the app bar (e.g., back button).
  final Widget? leading;

  /// Whether the app bar should remain visible at the top when scrolled.
  final bool pinned;

  /// Maximum number of lines for the title text.
  final int titleMaxLines;

  @override
  Widget build(BuildContext context) {
    // Obtain EC theme extension and sizing for consistent styling.
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final sizing = themeExtension.sizing;
    final spacing = themeExtension.spacing;

    final double maxExtentHeight = sizing.expandedAppBar;
    final double toolbarHeight = sizing.appBarHeight;

    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      expandedHeight: maxExtentHeight,
      toolbarHeight: toolbarHeight,
      pinned: pinned,
      leading: leading,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          // Font sizes for expanded and collapsed states.
          final double sliverTitleFontSizeExpanded =
              Theme.of(context).textTheme.displayMedium?.fontSize ?? 34;

          final double sliverTitleFontSizeCollapsed =
              Theme.of(context).textTheme.headlineSmall?.fontSize ?? 18.0;

          /// The current height of the flexible space, used to determine the collapsed/expanded state.
          final double currentHeight = constraints.biggest.height;

          /// The top padding from the device's status bar.
          final double topPadding = MediaQuery.of(context).padding.top;

          /// The minimum height of the app bar (toolbar + top padding).
          final double minHeight = toolbarHeight + topPadding;

          /// The maximum height of the app bar (expanded height + top padding).
          final double maxHeight = maxExtentHeight + topPadding;

          /// The range over which the app bar collapses, clamped to at least 1.0.
          final double collapseRange = (maxHeight - minHeight).clamp(
            1.0,
            double.infinity,
          );

          /// The normalized collapse factor (0.0 = expanded, 1.0 = collapsed).
          final double t = ((maxHeight - currentHeight) / collapseRange).clamp(
            0.0,
            1.0,
          );

          /// The horizontal alignment for the title.
          /// -1.0 = left-aligned (expanded), 0.0 = center-aligned (collapsed).
          final double alignX = lerpDouble(-1.0, 0.0, t)!;

          /// The font size for the title, interpolated between expanded and collapsed states.
          final double sliverTitleFontSize =
              lerpDouble(
                sliverTitleFontSizeExpanded,
                sliverTitleFontSizeCollapsed,
                t,
              )!;

          /// The bottom padding for the title, interpolated for smooth transition.
          final double paddingBottom = lerpDouble(0.0, 10.0, t)!;

          return Padding(
            padding: EdgeInsetsDirectional.only(
              start: spacing.xl,
              end: spacing.xl,
              bottom: paddingBottom,
            ),
            child: Align(
              alignment: Alignment(alignX, 1.0),
              child: Text(
                title,
                maxLines: titleMaxLines,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: sliverTitleFontSize,
                ),
              ),
            ),
          );
        },
      ),
      actions: actions,
    );
  }
}
