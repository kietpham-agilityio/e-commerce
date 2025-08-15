import 'package:flutter/foundation.dart';
import 'ec_flavor.dart';
import 'flavor_config.dart';
import 'flavor_environment.dart';

/// Utility methods for working with flavors and configurations
class FlavorUtils {
  FlavorUtils._();

  /// Get a user-friendly description of the current environment
  static String getEnvironmentDescription(EcFlavor flavor) {
    switch (flavor) {
      case EcFlavor.dev:
        return 'Development Environment - For testing and development purposes';
      case EcFlavor.staging:
        return 'Staging Environment - For pre-production testing';
      case EcFlavor.production:
        return 'Production Environment - Live application';
    }
  }

  /// Get color scheme for different flavors (useful for UI theming)
  static String getFlavorColor(EcFlavor flavor) {
    switch (flavor) {
      case EcFlavor.dev:
        return '#FF6B6B'; // Red for development
      case EcFlavor.staging:
        return '#4ECDC4'; // Teal for staging
      case EcFlavor.production:
        return '#45B7D1'; // Blue for production
    }
  }

  /// Check if debug features should be enabled
  static bool shouldEnableDebugFeatures(EcFlavor flavor) {
    return flavor.isDev || flavor.isStaging;
  }

  /// Check if performance monitoring should be enabled
  static bool shouldEnablePerformanceMonitoring(EcFlavor flavor) {
    return flavor.isStaging || flavor.isProduction;
  }

  /// Get appropriate log level for the flavor
  static String getLogLevel(EcFlavor flavor) {
    switch (flavor) {
      case EcFlavor.dev:
        return 'VERBOSE';
      case EcFlavor.staging:
        return 'INFO';
      case EcFlavor.production:
        return 'WARNING';
    }
  }

  /// Validate configuration for a flavor
  static List<String> validateConfiguration(FlavorEnvironment config) {
    final errors = <String>[];
    
    if (config.apiBaseUrl.isEmpty) {
      errors.add('API base URL cannot be empty');
    }
    
    if (!config.apiBaseUrl.startsWith('http')) {
      errors.add('API base URL must start with http:// or https://');
    }
    
    if (config.appName.isEmpty) {
      errors.add('App name cannot be empty');
    }
    
    if (config.appVersion.isEmpty) {
      errors.add('App version cannot be empty');
    }
    
    if (config.timeoutSeconds <= 0) {
      errors.add('Timeout must be greater than 0');
    }
    
    if (config.maxRetries < 0) {
      errors.add('Max retries cannot be negative');
    }
    
    return errors;
  }

  /// Compare two configurations and return differences
  static Map<String, dynamic> compareConfigurations(
    FlavorEnvironment config1,
    FlavorEnvironment config2,
  ) {
    final differences = <String, dynamic>{};
    
    if (config1.apiBaseUrl != config2.apiBaseUrl) {
      differences['apiBaseUrl'] = {
        'from': config1.apiBaseUrl,
        'to': config2.apiBaseUrl,
      };
    }
    
    if (config1.appName != config2.appName) {
      differences['appName'] = {
        'from': config1.appName,
        'to': config2.appName,
      };
    }
    
    if (config1.appVersion != config2.appVersion) {
      differences['appVersion'] = {
        'from': config1.appVersion,
        'to': config2.appVersion,
      };
    }
    
    if (config1.enableLogging != config2.enableLogging) {
      differences['enableLogging'] = {
        'from': config1.enableLogging,
        'to': config2.enableLogging,
      };
    }
    
    if (config1.enableAnalytics != config2.enableAnalytics) {
      differences['enableAnalytics'] = {
        'from': config1.enableAnalytics,
        'to': config2.enableAnalytics,
      };
    }
    
    if (config1.enableCrashlytics != config2.enableCrashlytics) {
      differences['enableCrashlytics'] = {
        'from': config1.enableCrashlytics,
        'to': config2.enableCrashlytics,
      };
    }
    
    if (config1.timeoutSeconds != config2.timeoutSeconds) {
      differences['timeoutSeconds'] = {
        'from': config1.timeoutSeconds,
        'to': config2.timeoutSeconds,
      };
    }
    
    if (config1.maxRetries != config2.maxRetries) {
      differences['maxRetries'] = {
        'from': config1.maxRetries,
        'to': config2.maxRetries,
      };
    }
    
    return differences;
  }

  /// Get configuration summary for debugging
  static Map<String, dynamic> getConfigurationSummary(EcFlavor flavor) {
    final config = FlavorConfig.getConfig(flavor);
    final validationErrors = validateConfiguration(config);
    
    return {
      'flavor': flavor.displayName,
      'config': {
        'apiBaseUrl': config.apiBaseUrl,
        'appName': config.appName,
        'appVersion': config.appVersion,
        'enableLogging': config.enableLogging,
        'enableAnalytics': config.enableAnalytics,
        'enableCrashlytics': config.enableCrashlytics,
        'timeoutSeconds': config.timeoutSeconds,
        'maxRetries': config.maxRetries,
      },
      'validation': {
        'isValid': validationErrors.isEmpty,
        'errors': validationErrors,
      },
      'features': {
        'debugFeatures': shouldEnableDebugFeatures(flavor),
        'performanceMonitoring': shouldEnablePerformanceMonitoring(flavor),
        'logLevel': getLogLevel(flavor),
      },
      'ui': {
        'color': getFlavorColor(flavor),
        'description': getEnvironmentDescription(flavor),
      },
    };
  }

  /// Print configuration summary to console (debug mode only)
  static void printConfigurationSummary(EcFlavor flavor) {
    if (kDebugMode) {
      final summary = getConfigurationSummary(flavor);
      print('=== Flavor Configuration Summary ===');
      print('Flavor: ${summary['flavor']}');
      print('API Base URL: ${summary['config']['apiBaseUrl']}');
      print('App Name: ${summary['config']['appName']}');
      print('App Version: ${summary['config']['appVersion']}');
      print('Logging: ${summary['config']['enableLogging']}');
      print('Analytics: ${summary['config']['enableAnalytics']}');
      print('Crashlytics: ${summary['config']['enableCrashlytics']}');
      print('Timeout: ${summary['config']['timeoutSeconds']}s');
      print('Max Retries: ${summary['config']['maxRetries']}');
      print('Debug Features: ${summary['features']['debugFeatures']}');
      print('Performance Monitoring: ${summary['features']['performanceMonitoring']}');
      print('Log Level: ${summary['features']['logLevel']}');
      print('=====================================');
    }
  }
}
