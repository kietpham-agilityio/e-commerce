import 'dart:developer';

import 'package:ec_flavor/ec_flavor.dart';
import 'package:flutter/material.dart';
import 'package:ec_design/ec_design.dart';

void main() {
  // Initialize flavor manager for development environment
  FlavorManager.initialize(EcFlavor.dev);

  // log configuration summary for debugging
  FlavorUtils.printConfigurationSummary(EcFlavor.dev);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlavorManager.appName,
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
    if (FlavorManager.isFeatureEnabled('logging')) {
      log('Counter incremented to: $_counter');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          // Show debug info button only in development/staging
          if (FlavorUtils.shouldEnableDebugFeatures(
            FlavorManager.currentFlavor,
          ))
            IconButton(icon: const Icon(Icons.info), onPressed: _showDebugInfo),
        ],
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
                    'Environment: ${FlavorManager.currentFlavor.displayName}',
                    style: TextStyle(
                      color: _getFlavorColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'API: ${FlavorManager.apiBaseUrl}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Version: ${FlavorManager.appVersion}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(EcDesignIcons.icArrowLeft, size: 30, color: Colors.blue),
                const SizedBox(width: 20),
                Icon(EcDesignIcons.icArrowRight, size: 30, color: Colors.green),
              ],
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

  void _showDebugInfo() {
    final debugInfo = FlavorManager.debugInfo;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Debug Information'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children:
                    debugInfo.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text('${entry.key}: ${entry.value}'),
                      );
                    }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }
}
