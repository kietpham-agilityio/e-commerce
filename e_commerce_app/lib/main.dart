import 'package:ec_core/ec_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = EcFlavor.current;

    return MaterialApp(
      title: flavor.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: flavor.isAdmin ? Colors.deepPurple : Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(flavor.appName),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                flavor.isAdmin ? 'Admin Flavor' : 'User Flavor',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text('Bundle ID: ${flavor.bundleId}'),
              Text('API URL: ${flavor.apiBaseUrl}'),
              Text('Environment: ${flavor.environment}'),
              const SizedBox(height: 20),
              Text(
                flavor.isAdmin
                    ? 'This is the admin version with full access'
                    : 'This is the user version with essential features',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      flavor.isAdmin
                          ? Colors.red.withValues(alpha: 0.1)
                          : Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: flavor.isAdmin ? Colors.red : Colors.blue,
                    width: 2,
                  ),
                ),
                child: Text(
                  'Current Flavor: ${flavor.displayName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: flavor.isAdmin ? Colors.red : Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
