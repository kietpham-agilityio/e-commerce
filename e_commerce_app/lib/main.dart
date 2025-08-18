import 'dart:developer';

import 'package:ec_flavor/ec_flavor.dart';
import 'package:flutter/material.dart';
import 'core/services/env_config_service.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize environment configuration
    await EnvConfigService.initialize();

    // Set default role based on environment configuration
    final defaultRole = EnvConfigService.getDefaultRole();
    if (defaultRole == 'admin') {
      RoleManager.setRole(UserRole.admin);
    } else {
      RoleManager.setRole(UserRole.user);
    }

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
      title: EnvConfigService.getAppName(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _getThemeColor()),
        appBarTheme: AppBarTheme(
          backgroundColor: _getThemeColor(),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(title: 'E-Commerce - Home Page'),
    );
  }

  Color _getThemeColor() {
    final colorName = EnvConfigService.getThemeColor();
    switch (colorName.toLowerCase()) {
      case 'orange':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      default:
        return Colors.blue;
    }
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
    if (EnvConfigService.getEnableLogging()) {
      log('Counter incremented to: $_counter');
    }
  }

  void _showDebugInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${EnvConfigService.getEnvironment()} Debug Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Environment: ${EnvConfigService.getEnvironment()}'),
            Text('Current Role: ${RoleManager.currentRole.displayName}'),
            Text('Can Access Admin: ${RoleManager.canAccessAdminPanel}'),
            Text('Can Manage Users: ${RoleManager.canManageUsers}'),
            Text('Can View Analytics: ${RoleManager.canViewAnalytics}'),
            Text('Max API Calls: ${RoleManager.maxApiCallsPerMinute}/min'),
            const SizedBox(height: 16),
            const Text('Build Info:'),
            Text('  - App Name: ${EnvConfigService.getAppName()}'),
            Text('  - Version: ${EnvConfigService.getAppVersion()}'),
            Text('  - Build: ${EnvConfigService.getBuildNumber()}'),
            Text('  - Theme: ${EnvConfigService.getThemeColor()}'),
            Text('  - API URL: ${EnvConfigService.getApiBaseUrl()}'),
            const SizedBox(height: 16),
            const Text('Feature Flags:'),
            Text('  - Logging: ${EnvConfigService.getEnableLogging()}'),
            Text('  - Analytics: ${EnvConfigService.getEnableAnalytics()}'),
            Text('  - Crashlytics: ${EnvConfigService.getEnableCrashlytics()}'),
            Text(
                '  - Debug Features: ${EnvConfigService.getEnableDebugFeatures()}'),
            const SizedBox(height: 16),
            const Text('Role Permissions:'),
            Text('  - Admin Panel: ${RoleManager.canAccessAdminPanel}'),
            Text('  - User Management: ${RoleManager.canManageUsers}'),
            Text('  - Analytics: ${RoleManager.canViewAnalytics}'),
            Text('  - Products: ${RoleManager.canManageProducts}'),
            Text('  - Reports: ${RoleManager.canViewReports}'),
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
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _getThemeColor();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          // Show debug info button only if debug features are enabled
          if (EnvConfigService.getEnableDebugFeatures())
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
                color: themeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: themeColor),
              ),
              child: Column(
                children: [
                  Text(
                    EnvConfigService.getAppName(),
                    style: TextStyle(
                      color: themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${EnvConfigService.getEnvironment()} Environment',
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Role: ${RoleManager.currentRole.displayName}',
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 12,
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
            // Role switching button for testing
            ElevatedButton(
              onPressed: _switchRole,
              child: Text(
                  'Switch to ${RoleManager.currentRole == UserRole.admin ? 'User' : 'Admin'} Role'),
            ),
            const SizedBox(height: 16),
            // Environment info
            Text(
              'Environment: ${EnvConfigService.getEnvironment()} | API: ${EnvConfigService.getApiBaseUrl()}',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: themeColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getThemeColor() {
    final colorName = EnvConfigService.getThemeColor();
    switch (colorName.toLowerCase()) {
      case 'orange':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  void _switchRole() {
    setState(() {
      if (RoleManager.currentRole == UserRole.admin) {
        RoleManager.setRole(UserRole.user);
      } else {
        RoleManager.setRole(UserRole.admin);
      }
    });
  }
}
