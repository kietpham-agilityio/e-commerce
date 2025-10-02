import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/presentations/items/items_page.dart';
import 'package:ec_core/ec_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return BlocProvider(
      create: (context) => AppBloc(featureFlagService: getFeatureFlagService()),
      child: MaterialApp(
        title: 'E-Commerce Dev - ${flavor.displayName}',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: flavor.isAdmin ? Colors.deepPurple : Colors.blue,
          ),
          useMaterial3: true,
        ),
        // home: const MyHomePage(title: 'E-Commerce Dev - API Testing'),
        home: const ItemsPage(),
      ),
    );
  }
}
