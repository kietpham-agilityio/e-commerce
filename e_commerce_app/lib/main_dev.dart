import 'package:ec_themes/themes/icons.dart';
import 'package:flutter/material.dart';
import 'package:ec_core/ec_core.dart';

void main() {
  // Initialize API client for development
  _initializeApiClient();
  runApp(const MyApp());
}

/// Initialize API client with development configuration
void _initializeApiClient() {
  // Create API client for development environment
  final apiClient = ApiClientFactory.createDev(
    additionalHeaders: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  );
  
  // Store globally or in a service locator
  // For now, we'll demonstrate usage in the UI
  print('API Client initialized for development environment');
  print('Current flavor: ${EcFlavor.current.displayName}');
  print('API Base URL: ${EcFlavor.current.apiBaseUrl}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
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
  String _apiStatus = 'Not tested';
  bool _isLoading = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  /// Test API connection
  Future<void> _testApiConnection() async {
    setState(() {
      _isLoading = true;
      _apiStatus = 'Testing...';
    });

    try {
      // Create API client for testing
      final apiClient = ApiClientFactory.createDev();
      
      // Test with a simple GET request (using a public API for testing)
      final response = await apiClient.get<Map<String, dynamic>>(
        'https://jsonplaceholder.typicode.com/posts/1',
      );
      
      setState(() {
        _apiStatus = 'API Test Successful!\nTitle: ${response['title'] ?? 'N/A'}';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _apiStatus = 'API Test Failed: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Counter section
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              
              // Icons section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(EcDesignIcons.icArrowLeft, size: 30, color: Colors.blue),
                  const SizedBox(width: 20),
                  Icon(EcDesignIcons.icArrowRight, size: 30, color: Colors.green),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // API Client section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'API Client Test',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Current Flavor: ${EcFlavor.current.displayName}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Environment: ${EcFlavor.current.environment}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _testApiConnection,
                        child: _isLoading 
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Test API Connection'),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _apiStatus,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
