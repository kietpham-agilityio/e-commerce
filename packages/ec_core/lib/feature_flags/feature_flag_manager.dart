import 'dart:async';
import '../services/core/base_service.dart';
import '../ec_flavor.dart';
import 'feature_flag.dart';
import 'feature_flag_service.dart';

/// Manager for feature flags with runtime control and environment awareness
class FeatureFlagManager extends BaseService {
  late FeatureFlagService _service;
  final Map<String, FeatureFlag> _cache = {};
  final Map<String, FeatureFlagOverride> _overrideCache = {};
  final StreamController<FeatureFlag> _flagUpdateController =
      StreamController<FeatureFlag>.broadcast();
  final StreamController<List<FeatureFlag>> _flagsUpdateController =
      StreamController<List<FeatureFlag>>.broadcast();

  /// Stream of individual feature flag updates
  Stream<FeatureFlag> get flagUpdates => _flagUpdateController.stream;

  /// Stream of all feature flags updates
  Stream<List<FeatureFlag>> get flagsUpdates => _flagsUpdateController.stream;

  /// Get the underlying service (for internal use)
  FeatureFlagService get service => _service;

  @override
  Future<void> initialize() async {
    _service = FeatureFlagService();
    await _service.initialize();
    await _loadCache();
  }

  @override
  Future<void> dispose() async {
    await _flagUpdateController.close();
    await _flagsUpdateController.close();
    await _service.dispose();
  }

  /// Load feature flags into cache
  Future<void> _loadCache() async {
    final flags = await _service.getAllFeatureFlags();
    _cache.clear();
    for (final flag in flags) {
      _cache[flag.key] = flag;
    }

    final overrides = await _service.getAllOverrides();
    _overrideCache.clear();
    for (final override in overrides) {
      _overrideCache[override.key] = override;
    }
  }

  /// Check if a feature flag is enabled
  Future<bool> isEnabled(String key) async {
    // Check override cache first
    final override = _overrideCache[key];
    if (override != null && override.isEnabled) {
      if (override.expiresAt != null &&
          override.expiresAt!.isBefore(DateTime.now())) {
        await removeOverride(key);
        return await isEnabled(key); // Recursive call after cleanup
      }
      return _parseBooleanValue(override.value);
    }

    // Check feature flag cache
    final flag = _cache[key];
    if (flag != null && flag.isEnabled) {
      return _parseBooleanValue(flag.currentValue);
    }

    return false;
  }

  /// Get feature flag value
  Future<dynamic> getValue(String key) async {
    // Check override cache first
    final override = _overrideCache[key];
    if (override != null && override.isEnabled) {
      if (override.expiresAt != null &&
          override.expiresAt!.isBefore(DateTime.now())) {
        await removeOverride(key);
        return await getValue(key); // Recursive call after cleanup
      }
      return override.value;
    }

    // Check feature flag cache
    final flag = _cache[key];
    if (flag != null && flag.isEnabled) {
      return flag.currentValue;
    }

    return null;
  }

  /// Get feature flag with type safety
  Future<T?> getValueAs<T>(String key) async {
    final value = await getValue(key);
    if (value is T) {
      return value;
    }
    return null;
  }

  /// Get boolean feature flag value
  Future<bool> getBooleanValue(String key, {bool defaultValue = false}) async {
    final value = await getValueAs<bool>(key);
    return value ?? defaultValue;
  }

  /// Get string feature flag value
  Future<String> getStringValue(String key, {String defaultValue = ''}) async {
    final value = await getValueAs<String>(key);
    return value ?? defaultValue;
  }

  /// Get number feature flag value
  Future<num> getNumberValue(String key, {num defaultValue = 0}) async {
    final value = await getValueAs<num>(key);
    return value ?? defaultValue;
  }

  /// Get JSON feature flag value
  Future<Map<String, dynamic>> getJsonValue(
    String key, {
    Map<String, dynamic>? defaultValue,
  }) async {
    final value = await getValueAs<Map<String, dynamic>>(key);
    return value ?? defaultValue ?? <String, dynamic>{};
  }

  /// Set feature flag override
  Future<void> setOverride({
    required String key,
    required dynamic value,
    DateTime? expiresAt,
    String? reason,
  }) async {
    final override = FeatureFlagOverride(
      key: key,
      value: value,
      isEnabled: true,
      createdAt: DateTime.now(),
      expiresAt: expiresAt,
      reason: reason,
    );

    await _service.saveOverride(override);
    _overrideCache[key] = override;
    _flagUpdateController.add(_cache[key]!);
  }

  /// Remove feature flag override
  Future<void> removeOverride(String key) async {
    await _service.deleteOverride(key);
    _overrideCache.remove(key);
    if (_cache.containsKey(key)) {
      _flagUpdateController.add(_cache[key]!);
    }
  }

  /// Clear all overrides
  Future<void> clearAllOverrides() async {
    await _service.clearAllOverrides();
    _overrideCache.clear();
    _flagsUpdateController.add(_cache.values.toList());
  }

  /// Clear expired overrides
  Future<void> clearExpiredOverrides() async {
    await _service.clearExpiredOverrides();
    await _loadCache();
    _flagsUpdateController.add(_cache.values.toList());
  }

  /// Update feature flag
  Future<void> updateFeatureFlag(FeatureFlag flag) async {
    await _service.saveFeatureFlag(flag);
    _cache[flag.key] = flag;
    _flagUpdateController.add(flag);
  }

  /// Update multiple feature flags
  Future<void> updateFeatureFlags(List<FeatureFlag> flags) async {
    await _service.saveFeatureFlags(flags);
    for (final flag in flags) {
      _cache[flag.key] = flag;
    }
    _flagsUpdateController.add(_cache.values.toList());
  }

  /// Get all feature flags
  Future<List<FeatureFlag>> getAllFeatureFlags() async {
    return _cache.values.toList();
  }

  /// Get feature flags by environment and flavor
  Future<List<FeatureFlag>> getFeatureFlagsByEnvironmentAndFlavor({
    required FeatureFlagEnvironment environment,
    required FeatureFlagFlavor flavor,
  }) async {
    return _cache.values
        .where(
          (flag) => flag.environment == environment && flag.flavor == flavor,
        )
        .toList();
  }

  /// Get feature flags for current environment and flavor
  Future<List<FeatureFlag>> getCurrentFeatureFlags() async {
    final environment = _getCurrentEnvironment();
    final flavor = _getCurrentFlavor();

    return getFeatureFlagsByEnvironmentAndFlavor(
      environment: environment,
      flavor: flavor,
    );
  }

  /// Refresh feature flags from service
  Future<void> refresh() async {
    await _loadCache();
    _flagsUpdateController.add(_cache.values.toList());
  }

  /// Check if feature flag exists
  bool hasFeatureFlag(String key) {
    return _cache.containsKey(key);
  }

  /// Check if feature flag has override
  bool hasOverride(String key) {
    return _overrideCache.containsKey(key);
  }

  /// Get feature flag metadata
  Future<Map<String, dynamic>?> getMetadata(String key) async {
    final flag = _cache[key];
    return flag?.metadata;
  }

  /// Get all overrides
  Future<List<FeatureFlagOverride>> getAllOverrides() async {
    return _overrideCache.values.toList();
  }

  /// Get override for specific key
  Future<FeatureFlagOverride?> getOverride(String key) async {
    return _overrideCache[key];
  }

  /// Parse boolean value from dynamic value
  bool _parseBooleanValue(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value is String) {
      return value.toLowerCase() == 'true';
    } else if (value is num) {
      return value != 0;
    }
    return false;
  }

  /// Get current environment from EcFlavor
  FeatureFlagEnvironment _getCurrentEnvironment() {
    final flavor = EcFlavor.current;
    if (flavor.isDevelopment) {
      return FeatureFlagEnvironment.development;
    } else if (flavor.isStaging) {
      return FeatureFlagEnvironment.staging;
    } else {
      return FeatureFlagEnvironment.production;
    }
  }

  /// Get current flavor from EcFlavor
  FeatureFlagFlavor _getCurrentFlavor() {
    final flavor = EcFlavor.current;
    return flavor.isAdmin ? FeatureFlagFlavor.admin : FeatureFlagFlavor.user;
  }
}
