import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Service for managing environment-specific configuration
/// Uses flutter_dotenv to load configuration from environment files
class EnvConfigService {
  static bool _isInitialized = false;
  static String _currentEnvironment = 'production';

  /// Initialize the environment configuration service
  /// Loads the appropriate environment file based on the current environment
  static Future<void> initialize({String? environment}) async {
    if (_isInitialized) return;

    try {
      // Determine which environment file to load
      _currentEnvironment = environment ?? _detectEnvironment();
      
      // Load the base environment file first
      await dotenv.load(fileName: 'env.base');
      
      // Load the specific environment file
      await dotenv.load(fileName: 'env.$_currentEnvironment');
      
      _isInitialized = true;
      
      print('Environment loaded: $_currentEnvironment');
      print('App Name: ${getAppName()}');
      print('API Base URL: ${getApiBaseUrl()}');
    } catch (e) {
      print('Error loading environment configuration: $e');
      // Fallback to base configuration
      await dotenv.load(fileName: 'env.base');
      _isInitialized = true;
    }
  }

  /// Detect the current environment from platform or build configuration
  static String _detectEnvironment() {
    // Check if running in debug mode (development)
    if (const bool.fromEnvironment('dart.vm.product') == false) {
      return 'dev';
    }
    
    // Check for environment variable
    final envVar = Platform.environment['FLUTTER_ENV'];
    if (envVar != null) {
      return envVar;
    }
    
    // Default to production
    return 'production';
  }

  /// Get the current environment
  static String get currentEnvironment => _currentEnvironment;

  /// Check if the service is initialized
  static bool get isInitialized => _isInitialized;

  // App Configuration
  static String getAppName() => dotenv.env['APP_NAME'] ?? 'E-Commerce';
  static String getAppVersion() => dotenv.env['APP_VERSION'] ?? '1.0.0';
  static String getBuildNumber() => dotenv.env['BUILD_NUMBER'] ?? '1';
  static String getEnvironment() => dotenv.env['ENVIRONMENT'] ?? 'production';
  static String getThemeColor() => dotenv.env['THEME_COLOR'] ?? 'blue';
  static String getDefaultRole() => dotenv.env['DEFAULT_ROLE'] ?? 'user';

  // API Configuration
  static String getApiBaseUrl() => dotenv.env['API_BASE_URL'] ?? 'https://api.example.com';
  static int getApiTimeoutSeconds() {
    final timeout = dotenv.env['API_TIMEOUT_SECONDS'];
    return timeout != null ? int.tryParse(timeout) ?? 30 : 30;
  }
  static int getApiMaxRetries() {
    final retries = dotenv.env['API_MAX_RETRIES'];
    return retries != null ? int.tryParse(retries) ?? 3 : 3;
  }

  // Feature Flags
  static bool getEnableLogging() => _parseBool(dotenv.env['ENABLE_LOGGING'] ?? 'false');
  static bool getEnableAnalytics() => _parseBool(dotenv.env['ENABLE_ANALYTICS'] ?? 'false');
  static bool getEnableCrashlytics() => _parseBool(dotenv.env['ENABLE_CRASHLYTICS'] ?? 'false');
  static bool getEnableDebugFeatures() => _parseBool(dotenv.env['ENABLE_DEBUG_FEATURES'] ?? 'false');

  // Database Configuration
  static String getDbHost() => dotenv.env['DB_HOST'] ?? 'localhost';
  static int getDbPort() {
    final port = dotenv.env['DB_PORT'];
    return port != null ? int.tryParse(port) ?? 5432 : 5432;
  }
  static String getDbName() => dotenv.env['DB_NAME'] ?? 'ecommerce';

  // Payment Configuration
  static String getPaymentGatewayUrl() => dotenv.env['PAYMENT_GATEWAY_URL'] ?? 'https://payment.example.com';
  static String getNotificationServiceUrl() => dotenv.env['NOTIFICATION_SERVICE_URL'] ?? 'https://notifications.example.com';

  // Security
  static String getJwtSecret() => dotenv.env['JWT_SECRET'] ?? 'default-jwt-secret';
  static String getEncryptionKey() => dotenv.env['ENCRYPTION_KEY'] ?? 'default-encryption-key';

  /// Helper method to parse boolean strings
  static bool _parseBool(String value) {
    return value.toLowerCase() == 'true';
  }

  /// Get all configuration as a map
  static Map<String, dynamic> getAllConfig() {
    return {
      'environment': getEnvironment(),
      'appName': getAppName(),
      'appVersion': getAppVersion(),
      'buildNumber': getBuildNumber(),
      'themeColor': getThemeColor(),
      'defaultRole': getDefaultRole(),
      'apiBaseUrl': getApiBaseUrl(),
      'apiTimeoutSeconds': getApiTimeoutSeconds(),
      'apiMaxRetries': getApiMaxRetries(),
      'enableLogging': getEnableLogging(),
      'enableAnalytics': getEnableAnalytics(),
      'enableCrashlytics': getEnableCrashlytics(),
      'enableDebugFeatures': getEnableDebugFeatures(),
      'dbHost': getDbHost(),
      'dbPort': getDbPort(),
      'dbName': getDbName(),
      'paymentGatewayUrl': getPaymentGatewayUrl(),
      'notificationServiceUrl': getNotificationServiceUrl(),
    };
  }

  /// Get configuration summary for debugging
  static Map<String, dynamic> getConfigSummary() {
    return {
      'environment': getEnvironment(),
      'app': {
        'name': getAppName(),
        'version': getAppVersion(),
        'buildNumber': getBuildNumber(),
        'themeColor': getThemeColor(),
        'defaultRole': getDefaultRole(),
      },
      'api': {
        'baseUrl': getApiBaseUrl(),
        'timeoutSeconds': getApiTimeoutSeconds(),
        'maxRetries': getApiMaxRetries(),
      },
      'features': {
        'logging': getEnableLogging(),
        'analytics': getEnableAnalytics(),
        'crashlytics': getEnableCrashlytics(),
        'debugFeatures': getEnableDebugFeatures(),
      },
      'database': {
        'host': getDbHost(),
        'port': getDbPort(),
        'name': getDbName(),
      },
      'services': {
        'payment': getPaymentGatewayUrl(),
        'notifications': getNotificationServiceUrl(),
      },
    };
  }

  /// Reset the service (useful for testing)
  static void reset() {
    _isInitialized = false;
    _currentEnvironment = 'production';
  }
}
