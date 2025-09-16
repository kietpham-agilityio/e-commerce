import 'dart:convert';
import 'package:isar/isar.dart';
import '../services/core/base_service.dart';
import '../services/ec_local_store/ec_local_database.dart';
import 'feature_flag.dart';
import 'feature_flag_box.dart';

/// Service for managing feature flags with local storage
class FeatureFlagService extends BaseService {
  late Isar _isar;
  late IsarCollection<FeatureFlagBox> _featureFlagCollection;
  late IsarCollection<FeatureFlagOverrideBox> _overrideCollection;

  @override
  Future<void> initialize() async {
    _isar = EcLocalDatabase.instance.store;
    _featureFlagCollection = _isar.featureFlagBoxs;
    _overrideCollection = _isar.featureFlagOverrideBoxs;
  }

  @override
  Future<void> dispose() async {
    // No specific disposal needed for Isar collections
  }

  /// Get all feature flags
  Future<List<FeatureFlag>> getAllFeatureFlags() async {
    final boxes = await _featureFlagCollection.where().findAll();
    return boxes.map(_boxToFeatureFlag).toList();
  }

  /// Get feature flag by key
  Future<FeatureFlag?> getFeatureFlag(String key) async {
    final box =
        await _featureFlagCollection.filter().keyEqualTo(key).findFirst();
    return box != null ? _boxToFeatureFlag(box) : null;
  }

  /// Get feature flags by environment and flavor
  Future<List<FeatureFlag>> getFeatureFlagsByEnvironmentAndFlavor({
    required FeatureFlagEnvironment environment,
    required FeatureFlagFlavor flavor,
  }) async {
    final boxes =
        await _featureFlagCollection
            .filter()
            .environmentEqualTo(environment.name)
            .and()
            .flavorEqualTo(flavor.name)
            .findAll();
    return boxes.map(_boxToFeatureFlag).toList();
  }

  /// Save feature flag
  Future<void> saveFeatureFlag(FeatureFlag flag) async {
    final box = _featureFlagToBox(flag);
    await _isar.writeTxn(() async {
      await _featureFlagCollection.put(box);
    });
  }

  /// Save multiple feature flags
  Future<void> saveFeatureFlags(List<FeatureFlag> flags) async {
    final boxes = flags.map(_featureFlagToBox).toList();
    await _isar.writeTxn(() async {
      await _featureFlagCollection.putAll(boxes);
    });
  }

  /// Delete feature flag
  Future<void> deleteFeatureFlag(String key) async {
    await _isar.writeTxn(() async {
      await _featureFlagCollection.filter().keyEqualTo(key).deleteFirst();
    });
  }

  /// Get feature flag override
  Future<FeatureFlagOverride?> getOverride(String key) async {
    final box = await _overrideCollection.filter().keyEqualTo(key).findFirst();
    return box != null ? _boxToOverride(box) : null;
  }

  /// Save feature flag override
  Future<void> saveOverride(FeatureFlagOverride override) async {
    await _isar.writeTxn(() async {
      // Check if override already exists
      final existingBox =
          await _overrideCollection
              .filter()
              .keyEqualTo(override.key)
              .findFirst();

      if (existingBox != null) {
        // Update existing override
        existingBox.value = _serializeValue(override.value);
        existingBox.isEnabled = override.isEnabled;
        existingBox.createdAt = override.createdAt;
        existingBox.expiresAt = override.expiresAt;
        existingBox.reason = override.reason;
        await _overrideCollection.put(existingBox);
      } else {
        // Create new override
        final box = _overrideToBox(override);
        await _overrideCollection.put(box);
      }
    });
  }

  /// Delete feature flag override
  Future<void> deleteOverride(String key) async {
    await _isar.writeTxn(() async {
      await _overrideCollection.filter().keyEqualTo(key).deleteFirst();
    });
  }

  /// Get all overrides
  Future<List<FeatureFlagOverride>> getAllOverrides() async {
    final boxes = await _overrideCollection.where().findAll();
    return boxes.map(_boxToOverride).toList();
  }

  /// Clear all overrides
  Future<void> clearAllOverrides() async {
    await _isar.writeTxn(() async {
      await _overrideCollection.clear();
    });
  }

  /// Clear expired overrides
  Future<void> clearExpiredOverrides() async {
    final now = DateTime.now();
    await _isar.writeTxn(() async {
      await _overrideCollection
          .filter()
          .expiresAtIsNotNull()
          .and()
          .expiresAtLessThan(now)
          .deleteAll();
    });
  }

  /// Check if feature flag is enabled (considering overrides)
  Future<bool> isFeatureFlagEnabled(String key) async {
    // Check for override first
    final override = await getOverride(key);
    if (override != null && override.isEnabled) {
      // Check if override has expired
      if (override.expiresAt != null &&
          override.expiresAt!.isBefore(DateTime.now())) {
        await deleteOverride(key);
      } else {
        return _parseValue(override.value, FeatureFlagType.boolean) as bool;
      }
    }

    // Check feature flag
    final flag = await getFeatureFlag(key);
    if (flag != null && flag.isEnabled) {
      return _parseValue(flag.currentValue, flag.type) as bool;
    }

    return false;
  }

  /// Get feature flag value (considering overrides)
  Future<dynamic> getFeatureFlagValue(String key) async {
    // Check for override first
    final override = await getOverride(key);
    if (override != null && override.isEnabled) {
      // Check if override has expired
      if (override.expiresAt != null &&
          override.expiresAt!.isBefore(DateTime.now())) {
        await deleteOverride(key);
      } else {
        return _parseValue(override.value, FeatureFlagType.string);
      }
    }

    // Check feature flag
    final flag = await getFeatureFlag(key);
    if (flag != null && flag.isEnabled) {
      return _parseValue(flag.currentValue, flag.type);
    }

    return null;
  }

  /// Convert FeatureFlagBox to FeatureFlag
  FeatureFlag _boxToFeatureFlag(FeatureFlagBox box) {
    return FeatureFlag(
      key: box.key,
      name: box.name,
      description: box.description,
      type: FeatureFlagType.values.firstWhere(
        (e) => e.name == box.type,
        orElse: () => FeatureFlagType.boolean,
      ),
      defaultValue: _parseValue(box.defaultValue, FeatureFlagType.string),
      currentValue: _parseValue(box.currentValue, FeatureFlagType.string),
      isEnabled: box.isEnabled,
      isOverridable: box.isOverridable,
      environment: FeatureFlagEnvironment.values.firstWhere(
        (e) => e.name == box.environment,
        orElse: () => FeatureFlagEnvironment.development,
      ),
      flavor: FeatureFlagFlavor.values.firstWhere(
        (e) => e.name == box.flavor,
        orElse: () => FeatureFlagFlavor.user,
      ),
      createdAt: box.createdAt,
      updatedAt: box.updatedAt,
      metadata: box.metadata != null ? jsonDecode(box.metadata!) : null,
    );
  }

  /// Convert FeatureFlag to FeatureFlagBox
  FeatureFlagBox _featureFlagToBox(FeatureFlag flag) {
    final box = FeatureFlagBox();
    box.key = flag.key;
    box.name = flag.name;
    box.description = flag.description;
    box.type = flag.type.name;
    box.defaultValue = _serializeValue(flag.defaultValue);
    box.currentValue = _serializeValue(flag.currentValue);
    box.isEnabled = flag.isEnabled;
    box.isOverridable = flag.isOverridable;
    box.environment = flag.environment.name;
    box.flavor = flag.flavor.name;
    box.createdAt = flag.createdAt;
    box.updatedAt = flag.updatedAt;
    box.metadata = flag.metadata != null ? jsonEncode(flag.metadata) : null;
    return box;
  }

  /// Convert FeatureFlagOverrideBox to FeatureFlagOverride
  FeatureFlagOverride _boxToOverride(FeatureFlagOverrideBox box) {
    return FeatureFlagOverride(
      key: box.key,
      value: _parseValue(box.value, FeatureFlagType.string),
      isEnabled: box.isEnabled,
      createdAt: box.createdAt,
      expiresAt: box.expiresAt,
      reason: box.reason,
    );
  }

  /// Convert FeatureFlagOverride to FeatureFlagOverrideBox
  FeatureFlagOverrideBox _overrideToBox(FeatureFlagOverride override) {
    final box = FeatureFlagOverrideBox();
    box.key = override.key;
    box.value = _serializeValue(override.value);
    box.isEnabled = override.isEnabled;
    box.createdAt = override.createdAt;
    box.expiresAt = override.expiresAt;
    box.reason = override.reason;
    return box;
  }

  /// Parse value from JSON string based on type
  dynamic _parseValue(String jsonString, FeatureFlagType type) {
    try {
      switch (type) {
        case FeatureFlagType.boolean:
          return jsonDecode(jsonString) as bool;
        case FeatureFlagType.string:
          return jsonDecode(jsonString) as String;
        case FeatureFlagType.number:
          return jsonDecode(jsonString) as num;
        case FeatureFlagType.json:
          return jsonDecode(jsonString);
      }
    } catch (e) {
      // Return default value if parsing fails
      switch (type) {
        case FeatureFlagType.boolean:
          return false;
        case FeatureFlagType.string:
          return '';
        case FeatureFlagType.number:
          return 0;
        case FeatureFlagType.json:
          return <String, dynamic>{};
      }
    }
  }

  /// Serialize value to JSON string
  String _serializeValue(dynamic value) {
    return jsonEncode(value);
  }
}
