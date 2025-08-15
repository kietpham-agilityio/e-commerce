import 'flavor_environment.dart';
import 'ec_flavor.dart';
import 'role_config.dart';
import 'user_role.dart';
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
    roleConfigs: _createRoleConfigs(),
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
    roleConfigs: _createRoleConfigs(),
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
    roleConfigs: _createRoleConfigs(),
  );

  /// Helper method to parse boolean strings
  static bool _parseBool(String value) {
    return value.toLowerCase() == 'true';
  }

  /// Helper method to create role configurations
  static Map<String, RoleConfig> _createRoleConfigs() {
    return {
      UserRole.admin.value: const RoleConfig(
        role: UserRole.admin,
        canAccessAdminPanel: true,
        canManageUsers: true,
        canViewAnalytics: true,
        canManageProducts: true,
        canViewReports: true,
        maxApiCallsPerMinute: 1000,
        featureFlags: {
          'advanced_analytics': true,
          'user_management': true,
          'product_management': true,
          'report_generation': true,
          'system_settings': true,
          'backup_restore': true,
          'audit_logs': true,
        },
      ),
      UserRole.user.value: const RoleConfig(
        role: UserRole.user,
        canAccessAdminPanel: false,
        canManageUsers: false,
        canViewAnalytics: false,
        canManageProducts: false,
        canViewReports: false,
        maxApiCallsPerMinute: 100,
        featureFlags: {
          'basic_shopping': true,
          'order_history': true,
          'profile_management': true,
          'wishlist': true,
          'reviews': true,
          'notifications': true,
        },
      ),
    };
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

  /// Check if a feature is enabled for a specific flavor and role
  static bool isFeatureEnabledForRole(EcFlavor flavor, String feature, String role) {
    final config = getConfig(flavor);
    final roleConfig = config.roleConfigs[role];
    
    if (roleConfig == null) return false;
    
    return roleConfig.isFeatureEnabled(feature);
  }

  /// Get role configuration for a specific flavor and role
  static RoleConfig? getRoleConfig(EcFlavor flavor, String role) {
    final config = getConfig(flavor);
    return config.roleConfigs[role];
  }

  /// Get all role configurations for a specific flavor
  static Map<String, RoleConfig> getAllRoleConfigs(EcFlavor flavor) {
    final config = getConfig(flavor);
    return config.roleConfigs;
  }
}
