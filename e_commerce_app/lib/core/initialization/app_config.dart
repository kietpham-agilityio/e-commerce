import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Configuration helper for app theme, router, and UI
class AppConfig {
  AppConfig._();

  /// Get router configuration based on flavor
  static GoRouter getRouter() {
    final flavor = EcFlavor.current;
    return switch (flavor.isAdmin) {
      true => AppRouter.adminRouter,
      false => AppRouter.router,
    };
  }

  /// Get light theme based on flavor
  static ThemeData getTheme() {
    final flavor = EcFlavor.current;
    return switch (flavor.isAdmin) {
      true => EcDesignTheme.adminLightTheme,
      false => EcDesignTheme.lightTheme,
    };
  }

  /// Get dark theme based on flavor
  static ThemeData getDarkTheme() {
    final flavor = EcFlavor.current;
    return switch (flavor.isAdmin) {
      true => EcDesignTheme.adminDarkTheme,
      false => EcDesignTheme.darkTheme,
    };
  }

  /// Get system UI overlay style
  static SystemUiOverlayStyle getSystemUiOverlayStyle() {
    return SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          ThemeMode.system == ThemeMode.light
              ? Brightness.light
              : Brightness.dark,
    );
  }
}
