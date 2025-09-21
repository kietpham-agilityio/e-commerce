import 'package:flutter/material.dart';
import '../typography.dart';
import '../app_spacing.dart';
import '../ec_theme_extension.dart';

/// Common tab bar widget with 3 tabs
class EcTabBar extends StatefulWidget {
  /// The tabs to display
  final List<EcTab> tabs;

  /// The currently selected tab index
  final int selectedIndex;

  /// Callback when a tab is selected
  final ValueChanged<int>? onTap;

  /// Whether the tab bar should be scrollable
  final bool isScrollable;

  /// Tab bar height
  final double? height;

  /// Tab bar padding
  final EdgeInsetsGeometry? padding;

  /// Tab bar margin
  final EdgeInsetsGeometry? margin;

  /// Background color override
  final Color? backgroundColor;

  /// Indicator color override
  final Color? indicatorColor;

  /// Label color override
  final Color? labelColor;

  /// Unselected label color override
  final Color? unselectedLabelColor;

  const EcTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    this.onTap,
    this.isScrollable = false,
    this.height,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
  }) : assert(tabs.length == 3, 'EcTabBar must have exactly 3 tabs');

  @override
  State<EcTabBar> createState() => _EcTabBarState();
}

class _EcTabBarState extends State<EcTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      initialIndex: widget.selectedIndex,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ecTheme = Theme.of(context).extension<EcThemeExtension>()!;
    final colors = ecTheme.colors;
    final sizing = ecTheme.sizing;
    final spacing = AppSpacing(ecTheme.themeType);

    return Container(
      margin: widget.margin,
      height: widget.height ?? sizing.button,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? colors.primaryContainer,
      ),
      child: TabBar(
        controller: _tabController,
        onTap: widget.onTap,
        isScrollable: widget.isScrollable,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: widget.indicatorColor ?? colors.primary,
            width: 3,
          ),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        // indicatorPadding: EdgeInsets.zero,
        labelColor: widget.labelColor ?? colors.secondary,
        unselectedLabelColor: widget.unselectedLabelColor ?? colors.secondary,
        labelStyle: EcTypography.getBodyLarge(
          ecTheme.themeType,
          ecTheme.isDark,
        ).copyWith(
          color: widget.labelColor ?? colors.secondary,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: EcTypography.getBodyLarge(
          ecTheme.themeType,
          ecTheme.isDark,
        ).copyWith(color: widget.unselectedLabelColor ?? colors.secondary),
        tabs:
            widget.tabs
                .map(
                  (tab) => Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.sm,
                        vertical: spacing.xs,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (tab.icon != null) ...[
                            tab.icon!,
                            SizedBox(width: spacing.xs),
                          ],
                          Text(tab.text),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}

/// Tab data class for EcTabBar
class EcTab {
  /// The text to display on the tab
  final String text;

  /// Optional icon to display on the tab
  final Widget? icon;

  /// Optional key for the tab
  final Key? key;

  const EcTab({required this.text, this.icon, this.key});
}
