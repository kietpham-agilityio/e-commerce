import 'package:flutter/foundation.dart';
import 'ec_flavor.dart';
import 'flavor_config.dart';
import 'flavor_environment.dart';
import 'flavor_detector.dart';

/// Manages the current application flavor and provides easy access to configuration
class FlavorManager {
  FlavorManager._();

  static EcFlavor? _currentFlavor;
  static FlavorEnvironment? _currentConfig;

  /// Initialize the flavor manager with a specific flavor
  static void initialize(EcFlavor flavor) {
    _currentFlavor = flavor;
    _currentConfig = FlavorConfig.getConfig(flavor);
    
    if (kDebugMode) {
      print('FlavorManager initialized with: ${flavor.displayName}');
      print('API Base URL: ${_currentConfig?.apiBaseUrl}');
      print('Logging enabled: ${_currentConfig?.enableLogging}');
    }
  }

  /// Initialize the flavor manager with automatic flavor detection
  /// This is the recommended method for most applications
  static Future<EcFlavor> initializeWithAutoDetection() async {
    final detectedFlavor = await FlavorDetector.autoDetectAndLoad();
    initialize(detectedFlavor);
    return detectedFlavor;
  }

  /// Initialize the flavor manager with a specific flavor and load environment
  static Future<void> initializeWithEnvironment(EcFlavor flavor) async {
    await FlavorDetector.loadEnvironmentConfig(flavor);
    initialize(flavor);
  }

  /// Get the current flavor
  static EcFlavor get currentFlavor {
    if (_currentFlavor == null) {
      throw StateError('FlavorManager not initialized. Call initialize() first.');
    }
    return _currentFlavor!;
  }

  /// Get the current environment configuration
  static FlavorEnvironment get currentConfig {
    if (_currentConfig == null) {
      throw StateError('FlavorManager not initialized. Call initialize() first.');
    }
    return _currentConfig!;
  }

  /// Check if current flavor is development
  static bool get isDev => currentFlavor.isDev;
  
  /// Check if current flavor is staging
  static bool get isStaging => currentFlavor.isStaging;
  
  /// Check if current flavor is production
  static bool get isProduction => currentFlavor.isProduction;

  /// Get API base URL for current flavor
  static String get apiBaseUrl => currentConfig.apiBaseUrl;
  
  /// Get app name for current flavor
  static String get appName => currentConfig.appName;
  
  /// Get app version for current flavor
  static String get appVersion => currentConfig.appVersion;

  /// Check if a feature is enabled for current flavor
  static bool isFeatureEnabled(String feature) {
    return FlavorConfig.isFeatureEnabled(currentFlavor, feature);
  }

  /// Get configuration for a specific flavor
  static FlavorEnvironment getConfig(EcFlavor flavor) {
    return FlavorConfig.getConfig(flavor);
  }

  /// Get all available configurations
  static Map<EcFlavor, FlavorEnvironment> getAllConfigs() {
    return FlavorConfig.getAllConfigs();
  }

  /// Reset the flavor manager (useful for testing)
  static void reset() {
    _currentFlavor = null;
    _currentConfig = null;
  }

  /// Get debug information about current flavor
  static Map<String, dynamic> get debugInfo {
    if (_currentFlavor == null) {
      return {'error': 'FlavorManager not initialized'};
    }
    
    return {
      'currentFlavor': _currentFlavor!.displayName,
      'apiBaseUrl': _currentConfig!.apiBaseUrl,
      'appName': _currentConfig!.appName,
      'appVersion': _currentConfig!.appVersion,
      'enableLogging': _currentConfig!.enableLogging,
      'enableAnalytics': _currentConfig!.enableAnalytics,
      'enableCrashlytics': _currentConfig!.enableCrashlytics,
      'timeoutSeconds': _currentConfig!.timeoutSeconds,
      'maxRetries': _currentConfig!.maxRetries,
    };
  }

  /// Get flavor detection information
  static Map<String, dynamic> get detectionInfo => FlavorDetector.getDetectionInfo();

  /// Check if the flavor manager is initialized
  static bool get isInitialized => _currentFlavor != null;
}
