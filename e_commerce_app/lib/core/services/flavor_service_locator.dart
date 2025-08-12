import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ec_flavor/ec_flavor.dart';
import 'dart:io';
import 'api_service.dart';

/// Flavor-aware service locator for different build configurations
class FlavorServiceLocator {
  /// Initialize services based on the detected flavor
  static Future<void> initialize() async {
    try {
      // Detect current flavor
      final flavor = _detectFlavor();
      
      // Load environment configuration
      await _loadEnvironmentConfig(flavor);
      
      // Initialize flavor manager
      FlavorManager.initialize(flavor);
      
      // Register flavor-specific services
      _registerFlavorServices(flavor);
    } catch (e) {
      rethrow;
    }
  }

  /// Detect the current flavor based on build configuration
  static EcFlavor _detectFlavor() {
    // Method 1: Check for build arguments (most reliable)
    final args = Platform.environment;
    
    // Method 2: Check for flavor-specific environment variables
    if (args.containsKey('FLAVOR')) {
      final flavorString = args['FLAVOR']!.toLowerCase();
      switch (flavorString) {
        case 'dev':
        case 'development':
          return EcFlavor.dev;
        case 'staging':
          return EcFlavor.staging;
        case 'prod':
        case 'production':
          return EcFlavor.production;
      }
    }
    
    // Method 3: Check for flavor-specific files or directories
    if (_hasFlavorFile('dev')) return EcFlavor.dev;
    if (_hasFlavorFile('staging')) return EcFlavor.staging;
    if (_hasFlavorFile('prod')) return EcFlavor.production;
    
    // Method 4: Default to development
    return EcFlavor.dev;
  }

  /// Check if a flavor-specific file exists
  static bool _hasFlavorFile(String flavor) {
    try {
      final file = File('../packages/ec_core/ec_flavor/env.$flavor');
      return file.existsSync();
    } catch (e) {
      return false;
    }
  }

  /// Load environment configuration for the detected flavor
  static Future<void> _loadEnvironmentConfig(EcFlavor flavor) async {
    try {
      final envFile = _getEnvironmentFilePath(flavor);
      await dotenv.load(fileName: envFile);
    } catch (e) {
      // Continue with default values from FlavorConfig
    }
  }

  /// Get environment file path for the specified flavor
  static String _getEnvironmentFilePath(EcFlavor flavor) {
    switch (flavor) {
      case EcFlavor.dev:
        return '../packages/ec_core/ec_flavor/env.dev';
      case EcFlavor.staging:
        return '../packages/ec_core/ec_flavor/env.staging';
      case EcFlavor.production:
        return '../packages/ec_core/ec_flavor/env.prod';
    }
  }

  /// Register flavor-specific services
  static void _registerFlavorServices(EcFlavor flavor) {
    // Register flavor-specific API service
    _registerApiService(flavor);
    
    // Register other flavor-specific services
    _registerOtherServices(flavor);
  }

  /// Register API service with flavor-specific configuration
  static void _registerApiService(EcFlavor flavor) {
    final getIt = GetIt.instance;
    
    // Get flavor configuration
    final config = FlavorConfig.getConfig(flavor);
    
    // Register API service with flavor-specific configuration
    getIt.registerLazySingleton<ApiService>(() => ApiService(
      baseUrl: config.apiBaseUrl,
      timeout: Duration(seconds: config.timeoutSeconds),
      maxRetries: config.maxRetries,
    ));
  }

  /// Register other flavor-specific services
  static void _registerOtherServices(EcFlavor flavor) {
    final getIt = GetIt.instance;
    
    // Register logging service based on flavor configuration
    if (FlavorConfig.getConfig(flavor).enableLogging) {
      getIt.registerLazySingleton<LoggingService>(() => LoggingService());
    }
    
    // Register analytics service based on flavor configuration
    if (FlavorConfig.getConfig(flavor).enableAnalytics) {
      getIt.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
    }
    
    // Register crashlytics service based on flavor configuration
    if (FlavorConfig.getConfig(flavor).enableCrashlytics) {
      getIt.registerLazySingleton<CrashlyticsService>(() => CrashlyticsService());
    }
  }

  /// Get current flavor configuration
  static FlavorEnvironment getCurrentConfig() {
    return FlavorManager.currentConfig;
  }

  /// Check if a feature is enabled for current flavor
  static bool isFeatureEnabled(String feature) {
    return FlavorManager.isFeatureEnabled(feature);
  }

  /// Get service by type with flavor awareness
  static T get<T extends Object>() {
    return GetIt.instance<T>();
  }

  /// Check if a service is registered
  static bool isRegistered<T extends Object>() {
    return GetIt.instance.isRegistered<T>();
  }

  /// Reset all services (useful for testing)
  static void reset() {
    GetIt.instance.reset();
  }
}

/// Mock services for demonstration (these would be real implementations)
class LoggingService {
  void log(String message) {
    // Placeholder implementation
  }
}

class AnalyticsService {
  void track(String event) {
    // Placeholder implementation
  }
}

class CrashlyticsService {
  void recordError(dynamic error) {
    // Placeholder implementation
  }
}

/// Extension methods for easier flavor service access
extension FlavorServiceLocatorExtension on Object {
  T getFlavorService<T extends Object>() => FlavorServiceLocator.get<T>();
  
  bool hasFlavorService<T extends Object>() => FlavorServiceLocator.isRegistered<T>();
  
  FlavorEnvironment get currentFlavorConfig => FlavorServiceLocator.getCurrentConfig();
  
  bool isFeatureEnabled(String feature) => FlavorServiceLocator.isFeatureEnabled(feature);
}
