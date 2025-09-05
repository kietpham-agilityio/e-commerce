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
      home: _HomeScreen(title: flavor.appName, flavorName: flavor.displayName),
    );
  }
}

enum HomeScenarioType { defaultBase, empty, success, error }

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({required this.title, required this.flavorName});

  final String title;
  final String flavorName;

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  HomeScenarioType _scenarioSelected = HomeScenarioType.defaultBase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: MockScenarioButton<HomeScenarioType>(
        title: 'Scenarios • ${widget.title}',
        scenarios: const [
          MockScenario<HomeScenarioType>(
            name: 'Default (app state)',
            description: 'Render the screen with normal app state',
            payload: HomeScenarioType.defaultBase,
          ),
          MockScenario<HomeScenarioType>(
            name: 'Empty state',
            description: 'Example scenario with empty content',
            payload: HomeScenarioType.empty,
          ),
          MockScenario<HomeScenarioType>(
            name: 'Success state',
            description: 'Example scenario with success UI',
            payload: HomeScenarioType.success,
          ),
          MockScenario<HomeScenarioType>(
            name: 'Error state',
            description: 'Example scenario with error UI',
            payload: HomeScenarioType.error,
          ),
        ],
        onSelected: (scenario) {
          setState(() => _scenarioSelected = scenario.payload);
        },
      ),
      body: _Body(type: _scenarioSelected),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.type});

  final HomeScenarioType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case HomeScenarioType.defaultBase:
        return const _DefaultBody();
      case HomeScenarioType.empty:
        return const _EmptyScenarioView();
      case HomeScenarioType.success:
        return const _SuccessScenarioView();
      case HomeScenarioType.error:
        return const _ErrorScenarioView();
    }
  }
}

class _DefaultBody extends StatelessWidget {
  const _DefaultBody();

  @override
  Widget build(BuildContext context) {
    final flavor = EcFlavor.current;
    return Center(
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
    );
  }
}

class _EmptyScenarioView extends StatelessWidget {
  const _EmptyScenarioView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No data'));
  }
}

class _SuccessScenarioView extends StatelessWidget {
  const _SuccessScenarioView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 48),
          const SizedBox(height: 8),
          Text(
            'Loaded successfully',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _ErrorScenarioView extends StatelessWidget {
  const _ErrorScenarioView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 8),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
