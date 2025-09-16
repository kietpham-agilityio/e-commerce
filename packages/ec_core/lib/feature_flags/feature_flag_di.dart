import '../di/di_initializer.dart';
import '../ec_flavor.dart';
import 'feature_flag_manager.dart';
import 'feature_flag_service.dart';
import 'feature_flag_configurations.dart';

/// Dependency injection for feature flags
class FeatureFlagDI {
  /// Register feature flag services
  static Future<void> registerFeatureFlagServices({
    EcFlavor? flavor,
    bool initializeWithDefaults = true,
  }) async {
    final currentFlavor = flavor ?? EcFlavor.current;

    // Register feature flag service
    DI.registerService<FeatureFlagService>(
      FeatureFlagService(),
      instanceName: 'feature_flag_service',
    );

    // Register feature flag manager
    DI.registerService<FeatureFlagManager>(
      FeatureFlagManager(),
      instanceName: 'feature_flag_manager',
    );

    // Initialize services
    final service = DI.get<FeatureFlagService>(
      instanceName: 'feature_flag_service',
    );
    final manager = DI.get<FeatureFlagManager>(
      instanceName: 'feature_flag_manager',
    );

    await service.initialize();
    await manager.initialize();

    // Initialize with default configurations if requested
    if (initializeWithDefaults) {
      await _initializeDefaultConfigurations(manager, currentFlavor);
    }
  }

  /// Initialize default feature flag configurations
  static Future<void> _initializeDefaultConfigurations(
    FeatureFlagManager manager,
    EcFlavor flavor,
  ) async {
    try {
      // Get default flags for current environment and flavor
      final defaultFlags = FeatureFlagConfigurations.getCurrentFlags();

      // Save default flags if they don't exist
      for (final flag in defaultFlags) {
        final existingFlag = await manager.service.getFeatureFlag(flag.key);
        if (existingFlag == null) {
          await manager.updateFeatureFlag(flag);
        }
      }
    } catch (e) {
      // Log error but don't fail initialization
      print('Failed to initialize default feature flag configurations: $e');
    }
  }

  /// Get feature flag service
  static FeatureFlagService get featureFlagService {
    if (!DI.isRegistered<FeatureFlagService>(
      instanceName: 'feature_flag_service',
    )) {
      throw Exception(
        'Feature flag service not registered. Call FeatureFlagDI.registerFeatureFlagServices() first.',
      );
    }
    return DI.get<FeatureFlagService>(instanceName: 'feature_flag_service');
  }

  /// Get feature flag manager
  static FeatureFlagManager get featureFlagManager {
    if (!DI.isRegistered<FeatureFlagManager>(
      instanceName: 'feature_flag_manager',
    )) {
      throw Exception(
        'Feature flag manager not registered. Call FeatureFlagDI.registerFeatureFlagServices() first.',
      );
    }
    return DI.get<FeatureFlagManager>(instanceName: 'feature_flag_manager');
  }

  /// Check if feature flag services are registered
  static bool get isRegistered {
    return DI.isRegistered<FeatureFlagService>(
          instanceName: 'feature_flag_service',
        ) &&
        DI.isRegistered<FeatureFlagManager>(
          instanceName: 'feature_flag_manager',
        );
  }

  /// Dispose feature flag services
  static Future<void> disposeFeatureFlagServices() async {
    if (DI.isRegistered<FeatureFlagManager>(
      instanceName: 'feature_flag_manager',
    )) {
      final manager = DI.get<FeatureFlagManager>(
        instanceName: 'feature_flag_manager',
      );
      await manager.dispose();
      DI.unregister<FeatureFlagManager>(instanceName: 'feature_flag_manager');
    }

    if (DI.isRegistered<FeatureFlagService>(
      instanceName: 'feature_flag_service',
    )) {
      final service = DI.get<FeatureFlagService>(
        instanceName: 'feature_flag_service',
      );
      await service.dispose();
      DI.unregister<FeatureFlagService>(instanceName: 'feature_flag_service');
    }
  }
}
