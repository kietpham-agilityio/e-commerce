# EC Secrets Package

A Flutter package for managing secrets, environment configurations, and application flavors in the e-commerce application.

## Features

- **Flavor Management**: Easy management of development, staging, and production environments
- **Environment Configuration**: Centralized configuration for each flavor
- **Feature Flags**: Environment-specific feature toggles
- **Utility Functions**: Helper methods for common flavor operations

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  ec_secrets:
    path: ../packages/ec_secrets
```

## Quick Start

### 1. Initialize Flavor Manager

In your main function, initialize the flavor manager:

```dart
import 'package:ec_secrets/ec_secrets.dart';

void main() {
  // Initialize with development flavor
  FlavorManager.initialize(AppFlavor.dev);
  
  runApp(const MyApp());
}
```

### 2. Use Flavor Configuration

Access configuration values throughout your app:

```dart
class ApiService {
  static const String baseUrl = FlavorManager.apiBaseUrl;
  static const int timeout = FlavorManager.currentConfig.timeoutSeconds;
  
  static Future<void> makeRequest() async {
    if (FlavorManager.isFeatureEnabled('logging')) {
      print('Making request to: $baseUrl');
    }
    // ... rest of the code
  }
}
```

### 3. Check Current Flavor

```dart
if (FlavorManager.isDev) {
  // Development-specific code
  print('Running in development mode');
}

if (FlavorManager.isProduction) {
  // Production-specific code
  print('Running in production mode');
}
```

## Available Classes

### AppFlavor

Enum representing different application flavors:

```dart
enum AppFlavor {
  dev('dev', 'Development'),
  staging('staging', 'Staging'),
  production('production', 'Production');
}
```

### FlavorEnvironment

Configuration class for each environment:

```dart
class FlavorEnvironment {
  final String apiBaseUrl;
  final String appName;
  final String appVersion;
  final bool enableLogging;
  final bool enableAnalytics;
  final bool enableCrashlytics;
  final int timeoutSeconds;
  final int maxRetries;
}
```

### FlavorConfig

Predefined configurations for each flavor:

```dart
// Get configuration for a specific flavor
final devConfig = FlavorConfig.getConfig(AppFlavor.dev);

// Get all configurations
final allConfigs = FlavorConfig.getAllConfigs();

// Check if a feature is enabled
final isLoggingEnabled = FlavorConfig.isFeatureEnabled(AppFlavor.dev, 'logging');
```

### FlavorManager

Main class for managing the current flavor:

```dart
// Get current flavor
final currentFlavor = FlavorManager.currentFlavor;

// Get current configuration
final config = FlavorManager.currentConfig;

// Check current environment
if (FlavorManager.isDev) { /* ... */ }

// Get specific values
final apiUrl = FlavorManager.apiBaseUrl;
final appName = FlavorManager.appName;

// Check features
final canLog = FlavorManager.isFeatureEnabled('logging');
```

### FlavorUtils

Utility methods for working with flavors:

```dart
// Get environment description
final description = FlavorUtils.getEnvironmentDescription(AppFlavor.dev);

// Get flavor color for UI
final color = FlavorUtils.getFlavorColor(AppFlavor.staging);

// Check if debug features should be enabled
final enableDebug = FlavorUtils.shouldEnableDebugFeatures(AppFlavor.dev);

// Validate configuration
final errors = FlavorUtils.validateConfiguration(config);

// Compare configurations
final differences = FlavorUtils.compareConfigurations(config1, config2);

// Print configuration summary (debug mode only)
FlavorUtils.printConfigurationSummary(AppFlavor.dev);
```

## Configuration Examples

### Development Environment

```dart
const FlavorEnvironment dev = FlavorEnvironment(
  apiBaseUrl: 'https://api-dev.example.com',
  appName: 'E-Commerce Dev',
  appVersion: '1.0.0-dev',
  enableLogging: true,
  enableAnalytics: false,
  enableCrashlytics: false,
  timeoutSeconds: 60,
  maxRetries: 5,
);
```

### Staging Environment

```dart
const FlavorEnvironment staging = FlavorEnvironment(
  apiBaseUrl: 'https://api-staging.example.com',
  appName: 'E-Commerce Staging',
  appVersion: '1.0.0-staging',
  enableLogging: true,
  enableAnalytics: true,
  enableCrashlytics: false,
  timeoutSeconds: 45,
  maxRetries: 3,
);
```

### Production Environment

```dart
const FlavorEnvironment production = FlavorEnvironment(
  apiBaseUrl: 'https://api.example.com',
  appName: 'E-Commerce',
  appVersion: '1.0.0',
  enableLogging: false,
  enableAnalytics: true,
  enableCrashlytics: true,
  timeoutSeconds: 30,
  maxRetries: 2,
);
```

## Usage Patterns

### 1. API Service Configuration

```dart
class ApiService {
  static String get baseUrl => FlavorManager.apiBaseUrl;
  static int get timeout => FlavorManager.currentConfig.timeoutSeconds;
  static int get maxRetries => FlavorManager.currentConfig.maxRetries;
  
  static Future<Response> get(String endpoint) async {
    final url = '$baseUrl$endpoint';
    
    if (FlavorManager.isFeatureEnabled('logging')) {
      print('GET request to: $url');
    }
    
    // ... rest of implementation
  }
}
```

### 2. Feature Toggles

```dart
class FeatureFlags {
  static bool get enableDebugMenu => FlavorManager.isDev || FlavorManager.isStaging;
  static bool get enableAnalytics => FlavorManager.isFeatureEnabled('analytics');
  static bool get enableCrashlytics => FlavorManager.isFeatureEnabled('crashlytics');
  static bool get enablePerformanceMonitoring => 
      FlavorUtils.shouldEnablePerformanceMonitoring(FlavorManager.currentFlavor);
}
```

### 3. UI Theming

```dart
class AppTheme {
  static ThemeData get theme {
    final flavor = FlavorManager.currentFlavor;
    final color = FlavorUtils.getFlavorColor(flavor);
    
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(int.parse(color.replaceAll('#', '0xFF'))),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      // ... rest of theme
    );
  }
}
```

### 4. Logging Configuration

```dart
class Logger {
  static void log(String message, {String? level}) {
    if (!FlavorManager.isFeatureEnabled('logging')) return;
    
    final logLevel = level ?? FlavorUtils.getLogLevel(FlavorManager.currentFlavor);
    final timestamp = DateTime.now().toIso8601String();
    
    print('[$timestamp] [$logLevel] $message');
  }
}
```

## Best Practices

1. **Initialize Early**: Always initialize `FlavorManager` before running your app
2. **Use Constants**: Access configuration through `FlavorManager` rather than hardcoding values
3. **Feature Flags**: Use `isFeatureEnabled()` for conditional features
4. **Validation**: Use `FlavorUtils.validateConfiguration()` to ensure configuration integrity
5. **Debug Info**: Use `FlavorUtils.printConfigurationSummary()` for debugging

## Error Handling

The package includes proper error handling:

```dart
try {
  final config = FlavorManager.currentConfig;
  // Use config
} on StateError catch (e) {
  print('FlavorManager not initialized: $e');
  // Handle error appropriately
}
```

## Testing

For testing purposes, you can reset the flavor manager:

```dart
test('test flavor configuration', () {
  FlavorManager.initialize(AppFlavor.dev);
  
  // Your test code here
  
  FlavorManager.reset(); // Clean up after test
});
```

## Dependencies

- `flutter_flavor: ^3.1.4` - For flavor management
- `flutter` - Flutter SDK

## License

This package is part of the e-commerce application and follows the same license terms.
