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
      case 'shop_page':
        return flags.enableShopPage ?? true;
      case 'items_page':
        return flags.enableItemsPage ?? true;
      case 'product_details_page':
        return flags.enableProductDetailsPage ?? true;
      case 'bag_page':
        return flags.enableBagPage ?? true;
      case 'favorites_page':
        return flags.enableFavoritesPage ?? true;

      case 'profile_page':
        return flags.enableProfilePage ?? true;
      case 'comments_page':
        return flags.enableCommentsPage ?? true;
      default:
        return false;
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
