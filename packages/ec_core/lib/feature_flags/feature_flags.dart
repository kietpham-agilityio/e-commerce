/// Feature flags system for E-Commerce application
///
/// This module provides a comprehensive feature flag system that allows
/// runtime control of features across different environments and flavors.
///
/// ## Features
/// - Environment-aware feature flags (development, staging, production)
/// - Flavor-aware feature flags (admin, user)
/// - Local storage with Isar database
/// - Runtime overrides with expiration
/// - Type-safe value retrieval
/// - Stream-based updates
/// - Dependency injection integration
///
/// ## Usage
///
/// ### Basic Usage
/// ```dart
/// // Check if a feature is enabled
/// final isEnabled = await DI.featureFlagManager.isEnabled('debug_mode');
///
/// // Get feature flag value
/// final value = await DI.featureFlagManager.getValue('api_timeout');
///
/// // Get typed value
/// final timeout = await DI.featureFlagManager.getNumberValue('api_timeout', defaultValue: 30);
/// ```
///
/// ### Setting Overrides
/// ```dart
/// // Set temporary override
/// await DI.featureFlagManager.setOverride(
///   key: 'debug_mode',
///   value: true,
///   expiresAt: DateTime.now().add(Duration(hours: 1)),
///   reason: 'Testing new feature',
/// );
/// ```
///
/// ### Listening to Changes
/// ```dart
/// // Listen to individual flag updates
/// DI.featureFlagManager.flagUpdates.listen((flag) {
///   print('Feature flag ${flag.key} updated');
/// });
///
/// // Listen to all flags updates
/// DI.featureFlagManager.flagsUpdates.listen((flags) {
///   print('${flags.length} feature flags updated');
/// });
/// ```
///
/// ## Architecture
///
/// The feature flags system consists of several components:
///
/// 1. **FeatureFlag**: Data model representing a feature flag
/// 2. **FeatureFlagService**: Service for local storage operations
/// 3. **FeatureFlagManager**: High-level manager with caching and streams
/// 4. **FeatureFlagConfigurations**: Default configurations for environments
/// 5. **FeatureFlagDI**: Dependency injection integration
///
/// ## Environment Configuration
///
/// Feature flags are automatically configured based on the current environment:
/// - **Development**: Debug features enabled, mock backend available
/// - **Staging**: Limited debug features, real backend
/// - **Production**: Minimal debug features, production backend
///
/// ## Flavor Configuration
///
/// Different flags are available for different flavors:
/// - **Admin**: Additional admin-specific features
/// - **User**: Standard user features
///
/// ## Local Storage
///
/// Feature flags are stored locally using Isar database for:
/// - Offline access
/// - Performance
/// - Persistence across app restarts
///
/// ## Overrides
///
/// Local overrides allow temporary changes to feature flags:
/// - Can be set with expiration times
/// - Automatically cleaned up when expired
/// - Useful for testing and debugging
///
/// ## Integration
///
/// The feature flags system is automatically initialized when using the DI system:
/// ```dart
/// await DI.initializeDevelopment();
/// // Feature flags are now available via DI.featureFlagManager
/// ```
library;

// Core models and enums
export 'feature_flag.dart';

// Storage models
export 'feature_flag_box.dart';

// Services
export 'feature_flag_service.dart';
export 'feature_flag_manager.dart';

// Configuration
export 'feature_flag_configurations.dart';

// Dependency injection
export 'feature_flag_di.dart';

