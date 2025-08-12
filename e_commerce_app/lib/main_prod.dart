import 'dart:developer';

import 'package:ec_flavor/ec_flavor.dart';
import 'package:flutter/material.dart';
import 'core/services/ec_locator.dart';
import 'core/services/api_service.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize dependency injection and all application services
    await EcLocator.initialize();
    runApp(const MyApp());
  } catch (e) {
    // Exit app if initialization fails
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: EcLocator.getCurrentConfig().appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          backgroundColor: _getFlavorColor(),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  Color _getFlavorColor() {
    final colorHex = FlavorUtils.getFlavorColor(FlavorManager.currentFlavor);
    return Color(int.parse(colorHex.replaceAll('#', '0xFF')));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    // Log the action if logging is enabled
    if (EcLocator.isFeatureEnabled('logging')) {
      log('Counter incremented to: $_counter');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        // No debug button in production
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Show environment info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getFlavorColor().withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _getFlavorColor()),
              ),
              child: Column(
                children: [
                  Text(
                    'Environment: ${EcLocator.getCurrentConfig().appName}',
                    style: TextStyle(
                      color: _getFlavorColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Version: ${EcLocator.getCurrentConfig().appVersion}',
                    style: TextStyle(
                      color: _getFlavorColor(),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _testApiService,
              child: const Text('Test API Service'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getFlavorColor() {
    final colorHex = FlavorUtils.getFlavorColor(FlavorManager.currentFlavor);
    return Color(int.parse(colorHex.replaceAll('#', '0xFF')));
  }

  Future<void> _testApiService() async {
    try {
      final apiService = EcLocator.get<ApiService>();
      
      // Test API availability
      final isAvailable = await apiService.isApiAvailable();
      
      if (isAvailable) {
        // Test GET request
        final response = await apiService.get('/test');
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('API Test Success: ${response['data']}'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('API is not available'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('API Test Failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
