import 'package:isar/isar.dart';

part 'feature_flag_box.g.dart';

/// Isar collection for storing feature flags
@collection
class FeatureFlagBox {
  /// Primary key
  Id id = Isar.autoIncrement;

  /// Feature flag key
  @Index(unique: true)
  late String key;

  /// Feature flag name
  late String name;

  /// Feature flag description
  late String description;

  /// Feature flag type as string
  late String type;

  /// Default value as JSON string
  late String defaultValue;

  /// Current value as JSON string
  late String currentValue;

  /// Whether the feature flag is enabled
  late bool isEnabled;

  /// Whether the feature flag can be overridden locally
  late bool isOverridable;

  /// Environment as string
  late String environment;

  /// Flavor as string
  late String flavor;

  /// Created timestamp
  late DateTime createdAt;

  /// Updated timestamp
  late DateTime updatedAt;

  /// Metadata as JSON string
  String? metadata;
}

/// Isar collection for storing feature flag overrides
@collection
class FeatureFlagOverrideBox {
  /// Primary key
  Id id = Isar.autoIncrement;

  /// Feature flag key
  @Index(unique: true)
  late String key;

  /// Override value as JSON string
  late String value;

  /// Whether the override is enabled
  late bool isEnabled;

  /// Created timestamp
  late DateTime createdAt;

  /// Expiration timestamp
  DateTime? expiresAt;

  /// Reason for the override
  String? reason;
}
