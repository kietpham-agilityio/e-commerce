import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/themes/icons.dart';
import 'package:flutter/material.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize DI for development environment
  await DependencyInjection.initializeDevelopment(
    flavor: EcFlavor.user, // Use user flavor for development
    customHeaders: {'X-App-Version': '1.0.0', 'X-Platform': 'flutter'},
  );

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce Dev',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'E-Commerce Development'),
      // Add development-specific features
      builder: (context, child) {
        return _DevelopmentWrapper(child: child!);
      },
    );
  }
}

/// Development wrapper that adds debugging features
class _DevelopmentWrapper extends StatelessWidget {
  const _DevelopmentWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        // Add development overlay
        Positioned(top: 50, right: 16, child: _DevelopmentInfo()),
      ],
    );
  }
}

/// Development info widget showing DI status
class _DevelopmentInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'DEV MODE',
            style: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'DI: ${DependencyInjection.isInitialized ? "✓" : "✗"}',
            style: TextStyle(
              color:
                  DependencyInjection.isInitialized ? Colors.green : Colors.red,
              fontSize: 10,
            ),
          ),
          Text(
            'Flavor: ${DependencyInjection.currentFlavor.displayName}',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
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

  @override
  void initState() {
    super.initState();
    _logAppStart();
  }

  void _logAppStart() {
    // Demonstrate logging with DI
    final logger = DependencyInjection.logger;
    logger.info('Development app started');
    logger.debug('Counter initialized: $_counter');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    // Log the action
    final logger = DependencyInjection.logger;
    logger.info('Counter incremented to: $_counter');
  }

  Future<void> _testApiConnection() async {
    setState(() {
      _isLoading = true;
      _apiStatus = 'Testing...';
    });

    try {
      final logger = DependencyInjection.logger;
      final apiClient = DependencyInjection.apiClient;

      logger.info('Testing API connection...');

      // Test API connection (this will fail in dev, but shows the pattern)
      await apiClient.get('/health');

      setState(() {
        _apiStatus = 'Connected ✓';
      });

      logger.info('API connection successful');
    } catch (e) {
      setState(() {
        _apiStatus = 'Failed: ${e.toString()}';
      });

      final logger = DependencyInjection.logger;
      logger.error('API connection failed: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showDiInfo() {
    final logger = DependencyInjection.logger;
    final flavor = DependencyInjection.currentFlavor;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('DI Information'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Flavor: ${flavor.displayName}'),
                Text('Environment: ${flavor.environment}'),
                Text('API Base URL: ${flavor.apiBaseUrl}'),
                Text('Bundle ID: ${flavor.bundleId}'),
                const SizedBox(height: 16),
                Text(
                  'DI Status: ${DependencyInjection.isInitialized ? "Initialized" : "Not Initialized"}',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
    );

    logger.info('DI info dialog shown');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: _showDiInfo,
            tooltip: 'DI Information',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Development Environment'),
            const SizedBox(height: 20),
            const Text('Counter Demo:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),

            // API Testing Section
            const Text(
              'API Connection Test:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Status: $_apiStatus'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _testApiConnection,
              child:
                  _isLoading
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Text('Test API'),
            ),

            const SizedBox(height: 30),

            // Design Icons Demo
            const Text(
              'Design Icons:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
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
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
