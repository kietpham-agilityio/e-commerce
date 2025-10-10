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
    this.background,
    this.maxHeight,
    this.expandedPaddingBottom,
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

  final Widget? background;

  final double? maxHeight;

  final double? expandedPaddingBottom;

  @override
  Widget build(BuildContext context) {
    // Obtain EC theme extension and sizing for consistent styling.
    final themeExtension = Theme.of(context).extension<EcThemeExtension>()!;
    final sizing = themeExtension.sizing;
    final spacing = themeExtension.spacing;

    final double maxExtentHeight = maxHeight ?? sizing.expandedAppBar;
    final double toolbarHeight = sizing.appBarHeight;

    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      expandedHeight: maxExtentHeight,
      toolbarHeight: toolbarHeight,
      pinned: pinned,
      leading: leading,
      actions: actions,

      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          if (background != null) background!,
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black26, Colors.black54],
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final double currentHeight = constraints.biggest.height;
              final double topPadding = MediaQuery.of(context).padding.top;
              final double minHeight = toolbarHeight + topPadding;
              final double maxHeight = maxExtentHeight + topPadding;
              final double collapseRange = (maxHeight - minHeight).clamp(
                1.0,
                double.infinity,
              );
              final double t = ((maxHeight - currentHeight) / collapseRange)
                  .clamp(0.0, 1.0);
              final double alignX = lerpDouble(-1.0, 0.0, t)!;
              final double fontSize = lerpDouble(34, 18, t)!;
              final double paddingBottom =
                  lerpDouble(expandedPaddingBottom ?? 0, 10, t)!;

              return Padding(
                padding: EdgeInsetsDirectional.only(
                  start: spacing.xl,
                  end: spacing.xl,
                  bottom: paddingBottom,
                ),
                child: Align(
                  alignment: Alignment(alignX, 1.0),
                  child: SafeArea(
                    child: Text(
                      title,
                      maxLines: titleMaxLines,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(fontSize: fontSize, color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
