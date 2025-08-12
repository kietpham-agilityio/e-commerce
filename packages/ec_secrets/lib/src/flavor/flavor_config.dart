import 'app_flavor.dart';
import 'flavor_environment.dart';

/// Predefined configurations for different application flavors
class FlavorConfig {
  FlavorConfig._();

  /// Development environment configuration
  static const FlavorEnvironment dev = FlavorEnvironment(
    //FIXME: Update with actual development environment values
    apiBaseUrl: 'https://api-dev.example.com',
    appName: 'E-Commerce Dev',
    appVersion: '1.0.0-dev',
    enableLogging: true,
    enableAnalytics: false,
    enableCrashlytics: false,
    timeoutSeconds: 60,
    maxRetries: 5,
  );

  /// Staging environment configuration
  static const FlavorEnvironment staging = FlavorEnvironment(
    //FIXME: Update with actual development environment values
    apiBaseUrl: 'https://api-staging.example.com',
    appName: 'E-Commerce Staging',
    appVersion: '1.0.0-staging',
    enableLogging: true,
    enableAnalytics: true,
    enableCrashlytics: false,
    timeoutSeconds: 45,
    maxRetries: 3,
  );

  /// Production environment configuration
  static const FlavorEnvironment production = FlavorEnvironment(
    //FIXME: Update with actual development environment values
    apiBaseUrl: 'https://api.example.com',
    appName: 'E-Commerce',
    appVersion: '1.0.0',
    enableLogging: false,
    enableAnalytics: true,
    enableCrashlytics: true,
    timeoutSeconds: 30,
    maxRetries: 2,
  );

  /// Get configuration for a specific flavor
  static FlavorEnvironment getConfig(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        return dev;
      case AppFlavor.staging:
        return staging;
      case AppFlavor.production:
        return production;
    }
  }

  /// Get all available configurations
  static Map<AppFlavor, FlavorEnvironment> getAllConfigs() {
    return {
      AppFlavor.dev: dev,
      AppFlavor.staging: staging,
      AppFlavor.production: production,
    };
  }

  /// Check if a feature is enabled for a specific flavor
  static bool isFeatureEnabled(AppFlavor flavor, String feature) {
    final config = getConfig(flavor);

    switch (feature.toLowerCase()) {
      case 'logging':
        return config.enableLogging;
      case 'analytics':
        return config.enableAnalytics;
      case 'crashlytics':
        return config.enableCrashlytics;
      default:
        return false;
    }
  }
}
