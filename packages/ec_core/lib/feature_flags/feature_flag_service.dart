import 'package:get_it/get_it.dart';
import 'package:flutter/foundation.dart';
import 'feature_flag.dart';

/// Feature flag service for dependency injection
class FeatureFlagService {
  static FeatureFlagService? _instance;
  EcFeatureFlag? _featureFlags;

  FeatureFlagService._();

  static FeatureFlagService get instance {
    _instance ??= FeatureFlagService._();
    return _instance!;
  }

  /// Initialize feature flags from environment
  Future<void> initialize() async {
    _featureFlags = EcFeatureFlag.withEnvironment();
    if (kDebugMode) {
      print('🎯 Feature flags initialized successfully');
      print('📊 Debug Mode: ${_featureFlags?.enableDebugMode}');
      print('🔍 API Logging: ${_featureFlags?.enableApiLogging}');
    }
  }

  /// Get current feature flags (with fallback to default values)
  EcFeatureFlag get flags {
    if (_featureFlags == null) {
      // Return default feature flags if not initialized
      return EcFeatureFlag.withEnvironment();
    }
    return _featureFlags!;
  }

  /// Check if service is initialized
  bool get isInitialized => _featureFlags != null;

  /// Update feature flags
  void updateFlags(EcFeatureFlag newFlags) {
    _featureFlags = newFlags;
  }

  /// Check if a specific feature is enabled
  bool isEnabled(String featureName) {
    final flags = _featureFlags;
    if (flags == null) return false;

    switch (featureName.toLowerCase()) {
      case 'debug_mode':
        return flags.enableDebugMode ?? false;
      case 'api_logging':
        return flags.enableApiLogging ?? false;
      case 'mock_backend':
        return flags.enableMockBackend ?? false;
      case 'database_inspector':
        return flags.enableDatabaseInspector ?? false;
      case 'admin_debug_panel':
        return flags.enableAdminDebugPanel ?? false;
      case 'user_impersonation':
        return flags.enableUserImpersonation ?? false;
      case 'analytics':
        return flags.enableAnalytics ?? false;
      case 'crash_reporting':
        return flags.enableCrashReporting ?? false;
      case 'performance_monitoring':
        return flags.enablePerformanceMonitoring ?? false;
      case 'api_cache':
        return flags.enableApiCache ?? false;
      case 'dark_mode':
        return flags.enableDarkMode ?? false;
      case 'animations':
        return flags.enableAnimations ?? false;
      case 'debug_overlay':
        return flags.enableDebugOverlay ?? false;
      case 'new_checkout_flow':
        return flags.enableNewCheckoutFlow ?? false;
      case 'social_login':
        return flags.enableSocialLogin ?? false;
      case 'push_notifications':
        return flags.enablePushNotifications ?? false;
      default:
        return false;
    }
  }

  /// Enable debug mode
  void enableDebugMode() {
    if (_featureFlags != null) {
      _featureFlags!.setDebugMode(enable: true);
    }
  }

  /// Enable production mode
  void enableProductionMode() {
    if (_featureFlags != null) {
      _featureFlags!.setProductionMode(enable: true);
    }
  }
}

/// Register feature flag service with GetIt
void registerFeatureFlagService() {
  GetIt.instance.registerSingleton<FeatureFlagService>(
    FeatureFlagService.instance,
    instanceName: 'feature_flag_service',
  );
}

/// Get feature flag service from GetIt (with fallback)
FeatureFlagService getFeatureFlagService() {
  try {
    return GetIt.instance.get<FeatureFlagService>(
      instanceName: 'feature_flag_service',
    );
  } catch (e) {
    // If service is not registered yet, return the instance directly
    return FeatureFlagService.instance;
  }
}
