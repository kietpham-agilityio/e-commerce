import 'flavor_environment.dart';
import 'ec_flavor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Predefined configurations for different application flavors
class FlavorConfig {
  FlavorConfig._();

  /// Development environment configuration
  static FlavorEnvironment get dev => FlavorEnvironment(
    apiBaseUrl: dotenv.env['API_BASE_URL'] ?? 'https://api-dev.example.com',
    appName: dotenv.env['APP_NAME'] ?? 'E-Commerce Dev',
    appVersion: dotenv.env['APP_VERSION'] ?? '1.0.0-dev',
    enableLogging: _parseBool(dotenv.env['ENABLE_LOGGING'] ?? 'true'),
    enableAnalytics: _parseBool(dotenv.env['ENABLE_ANALYTICS'] ?? 'false'),
    enableCrashlytics: _parseBool(dotenv.env['ENABLE_CRASHLYTICS'] ?? 'false'),
    timeoutSeconds: int.tryParse(dotenv.env['TIMEOUT_SECONDS'] ?? '60') ?? 60,
    maxRetries: int.tryParse(dotenv.env['MAX_RETRIES'] ?? '5') ?? 5,
  );

  /// Staging environment configuration
  static FlavorEnvironment get staging => FlavorEnvironment(
    apiBaseUrl: dotenv.env['API_BASE_URL'] ?? 'https://api-staging.example.com',
    appName: dotenv.env['APP_NAME'] ?? 'E-Commerce Staging',
    appVersion: dotenv.env['APP_VERSION'] ?? '1.0.0-staging',
    enableLogging: _parseBool(dotenv.env['ENABLE_LOGGING'] ?? 'true'),
    enableAnalytics: _parseBool(dotenv.env['ENABLE_ANALYTICS'] ?? 'true'),
    enableCrashlytics: _parseBool(dotenv.env['ENABLE_CRASHLYTICS'] ?? 'false'),
    timeoutSeconds: int.tryParse(dotenv.env['TIMEOUT_SECONDS'] ?? '45') ?? 45,
    maxRetries: int.tryParse(dotenv.env['MAX_RETRIES'] ?? '3') ?? 3,
  );

  /// Production environment configuration
  static FlavorEnvironment get production => FlavorEnvironment(
    apiBaseUrl: dotenv.env['API_BASE_URL'] ?? 'https://api.example.com',
    appName: dotenv.env['APP_NAME'] ?? 'E-Commerce',
    appVersion: dotenv.env['APP_VERSION'] ?? '1.0.0',
    enableLogging: _parseBool(dotenv.env['ENABLE_LOGGING'] ?? 'false'),
    enableAnalytics: _parseBool(dotenv.env['ENABLE_ANALYTICS'] ?? 'true'),
    enableCrashlytics: _parseBool(dotenv.env['ENABLE_CRASHLYTICS'] ?? 'true'),
    timeoutSeconds: int.tryParse(dotenv.env['TIMEOUT_SECONDS'] ?? '30') ?? 30,
    maxRetries: int.tryParse(dotenv.env['MAX_RETRIES'] ?? '2') ?? 2,
  );

  /// Helper method to parse boolean strings
  static bool _parseBool(String value) {
    return value.toLowerCase() == 'true';
  }

  /// Get configuration for a specific flavor
  static FlavorEnvironment getConfig(EcFlavor flavor) {
    switch (flavor) {
      case EcFlavor.dev:
        return dev;
      case EcFlavor.staging:
        return staging;
      case EcFlavor.production:
        return production;
    }
  }

  /// Get all available configurations
  static Map<EcFlavor, FlavorEnvironment> getAllConfigs() {
    return {
      EcFlavor.dev: dev,
      EcFlavor.staging: staging,
      EcFlavor.production: production,
    };
  }

  /// Check if a feature is enabled for a specific flavor
  static bool isFeatureEnabled(EcFlavor flavor, String feature) {
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
