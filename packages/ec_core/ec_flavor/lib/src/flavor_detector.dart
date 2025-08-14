import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ec_flavor.dart';

/// Utility class for detecting the current application flavor
/// and loading environment-specific configurations
class FlavorDetector {
  FlavorDetector._();

  /// Detect the current flavor based on build configuration
  /// Uses multiple detection methods for reliability
  static EcFlavor detectFlavor() {
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

  /// Get environment file path for the specified flavor
  static String getEnvironmentFilePath(EcFlavor flavor) {
    switch (flavor) {
      case EcFlavor.dev:
        return '../packages/ec_core/ec_flavor/env.dev';
      case EcFlavor.staging:
        return '../packages/ec_core/ec_flavor/env.staging';
      case EcFlavor.production:
        return '../packages/ec_core/ec_flavor/env.prod';
    }
  }

  /// Load environment configuration for the specified flavor
  static Future<void> loadEnvironmentConfig(EcFlavor flavor) async {
    try {
      final envFile = getEnvironmentFilePath(flavor);
      await dotenv.load(fileName: envFile);
    } catch (e) {
      // Continue with default values from FlavorConfig
      // This is not a critical error as FlavorConfig provides defaults
    }
  }

  /// Auto-detect and load environment configuration
  /// This is the main method to use for automatic flavor setup
  static Future<EcFlavor> autoDetectAndLoad() async {
    final detectedFlavor = detectFlavor();
    await loadEnvironmentConfig(detectedFlavor);
    return detectedFlavor;
  }

  /// Get debug information about flavor detection
  static Map<String, dynamic> getDetectionInfo() {
    final args = Platform.environment;
    final hasFlavorEnv = args.containsKey('FLAVOR');
    final flavorEnvValue = args['FLAVOR'];
    
    return {
      'detectedFlavor': detectFlavor().displayName,
      'hasFlavorEnv': hasFlavorEnv,
      'flavorEnvValue': flavorEnvValue,
      'hasDevFile': _hasFlavorFile('dev'),
      'hasStagingFile': _hasFlavorFile('staging'),
      'hasProdFile': _hasFlavorFile('prod'),
      'platform': Platform.operatingSystem,
      'environment': args,
    };
  }
}
