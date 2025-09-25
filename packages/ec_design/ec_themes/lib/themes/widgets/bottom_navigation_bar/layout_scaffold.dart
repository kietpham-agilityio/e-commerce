import 'package:ec_themes/ec_design.dart';
import 'package:ec_themes/themes/app_sizing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'ec_bottom_navigation_item.dart';

class LayoutScaffold extends StatelessWidget {
  const LayoutScaffold({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('LayoutScaffold'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final themeExt = Theme.of(context).extension<EcThemeExtension>()!;
    final ecTheme = Theme.of(context);
    final sizing = AppSizing(themeExt.themeType);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            EcShadows.customShadow(
              context,
              color: ecTheme.colorScheme.onPrimaryContainer.withValues(
                alpha: 0.1,
              ),
              offset: const Offset(0, -4),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Theme(
          data: ecTheme.copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: BottomNavigationBar(
              items:
                  ecBottomNavigationItem
                      .map(
                        (item) => BottomNavigationBarItem(
                          icon: Icon(
                            item.icon,
                            size: sizing.bottomNavigationBarIcon,
                          ),
                          label: item.label,
                          activeIcon: Icon(
                            item.selectedIcon,
                            color: ecTheme.colorScheme.primary,
                            size: sizing.bottomNavigationBarIcon,
                          ),
                        ),
                      )
                      .toList(),
              currentIndex: navigationShell.currentIndex,
              onTap: navigationShell.goBranch,
            ),
          ),
        ),
      ),
    );
  }
}
