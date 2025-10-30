import 'package:ec_themes/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ec_theme_extension.dart';

/// Common app bar widget with consistent styling across the app
class EcAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title widget to display in the app bar
  final Widget? title;

  /// The title text (alternative to title widget)
  final String? titleText;

  /// List of actions to display in the app bar
  final List<Widget>? actions;

  /// Leading widget (usually back button)
  final Widget? leading;

  /// Whether to automatically show a back button
  final bool automaticallyImplyLeading;

  /// Background color override
  final Color? backgroundColor;

  /// Foreground color override
  final Color? foregroundColor;

  /// Elevation of the app bar
  final double? elevation;

  /// Shadow color
  final Color? shadowColor;

  /// Surface tint color
  final Color? surfaceTintColor;

  /// Whether the app bar should be centered
  final bool? centerTitle;

  /// Title spacing
  final double? titleSpacing;

  /// Leading width
  final double? leadingWidth;

  /// Toolbar height
  final double? toolbarHeight;

  /// Bottom widget (like TabBar)
  final PreferredSizeWidget? bottom;

  /// System overlay style
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// Whether to show the app bar
  final bool visible;

  const EcAppBar({
    super.key,
    this.title,
    this.titleText,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.centerTitle,
    this.titleSpacing,
    this.leadingWidth,
    this.toolbarHeight,
    this.bottom,
    this.systemOverlayStyle,
    this.visible = true,
  }) : assert(
         title == null || titleText == null,
         'Cannot provide both title and titleText',
       );

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }

    final ecTheme = Theme.of(context).extension<EcThemeExtension>()!;
    final colors = ecTheme.colors;

    // Determine title widget
    Widget? titleWidget = title;
    if (titleWidget == null && titleText != null) {
      titleWidget = Text(
        titleText!,
        style: EcTypography.getHeadlineMedium(
          ecTheme.themeType,
          ecTheme.isDark,
        ),
      );
    }

    return AppBar(
      title: titleWidget,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor ?? colors.surface,
      foregroundColor: foregroundColor ?? colors.secondary,
      elevation: elevation ?? 0,
      shadowColor: shadowColor ?? colors.shadow,
      surfaceTintColor: surfaceTintColor ?? Colors.transparent,
      centerTitle: centerTitle ?? true,
      titleSpacing: titleSpacing,
      leadingWidth: leadingWidth,
      toolbarHeight: toolbarHeight,
      bottom: bottom,
      systemOverlayStyle:
          systemOverlayStyle ??
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                ecTheme.isDark ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: backgroundColor ?? colors.surfaceDim,
            systemNavigationBarIconBrightness:
                ecTheme.isDark ? Brightness.light : Brightness.dark,
          ),
    );
  }

  @override
  Size get preferredSize {
    if (!visible) return Size.zero;

    final height = toolbarHeight ?? kToolbarHeight;
    final bottomHeight = bottom?.preferredSize.height ?? 0;

    return Size.fromHeight(height + bottomHeight);
  }
}

/// Convenience constructors for common app bar variations
extension EcAppBarVariations on EcAppBar {
  /// App bar with back button and title
  static EcAppBar withBackButton({
    required String titleText,
    List<Widget>? actions,
    VoidCallback? onBackPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    Key? key,
  }) {
    return EcAppBar(
      key: key,
      titleText: titleText,
      actions: actions,
      leading:
          onBackPressed != null
              ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackPressed,
              )
              : null,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }

  /// App bar with custom leading widget
  static EcAppBar withCustomLeading({
    required Widget leading,
    required String titleText,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? foregroundColor,
    Key? key,
  }) {
    return EcAppBar(
      key: key,
      titleText: titleText,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }
}
