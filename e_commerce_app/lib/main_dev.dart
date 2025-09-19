import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:flutter/material.dart';

import 'core/di/app_module.dart';

void main() {
  // Initialize dependency injection
  AppModule.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = EcFlavor.current;

    return MaterialApp(
      title: 'E-Commerce Dev - ${flavor.displayName}',
      theme: EcDesignTheme.lightTheme,
      darkTheme: EcDesignTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const ExampleNavigation(),
    );
  }
}
