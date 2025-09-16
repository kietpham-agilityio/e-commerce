import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_flag.freezed.dart';
part 'feature_flag.g.dart';

/// Enum defining different types of feature flags
enum FeatureFlagType {
  /// Boolean feature flag (on/off)
  boolean,

  /// String feature flag with custom values
  string,

  /// Number feature flag with numeric values
  number,

  /// JSON feature flag with complex data structures
  json,
}

/// Enum defining different environments for feature flags
enum FeatureFlagEnvironment {
  /// Development environment
  development,

  /// Staging environment
  staging,

  /// Production environment
  production,
}

/// Enum defining different flavors for feature flags
enum FeatureFlagFlavor {
  /// Admin flavor
  admin,

  /// User flavor
  user,
}

/// Feature flag configuration model
@freezed
class FeatureFlag with _$FeatureFlag {
  const factory FeatureFlag({
    /// Unique identifier for the feature flag
    required String key,

    /// Display name for the feature flag
    required String name,

    /// Description of what this feature flag controls
    required String description,

    /// Type of the feature flag
    required FeatureFlagType type,

    /// Default value for the feature flag
    required dynamic defaultValue,

    /// Current value of the feature flag
    required dynamic currentValue,

    /// Whether the feature flag is enabled
    required bool isEnabled,

    /// Whether the feature flag can be overridden locally
    required bool isOverridable,

    /// Environment where this feature flag applies
    required FeatureFlagEnvironment environment,

    /// Flavor where this feature flag applies
    required FeatureFlagFlavor flavor,

    /// Timestamp when the feature flag was created
    required DateTime createdAt,

    /// Timestamp when the feature flag was last updated
    required DateTime updatedAt,

    /// Additional metadata for the feature flag
    Map<String, dynamic>? metadata,
  }) = _FeatureFlag;

  factory FeatureFlag.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagFromJson(json);
}

/// Feature flag override model for local overrides
@freezed
class FeatureFlagOverride with _$FeatureFlagOverride {
  const factory FeatureFlagOverride({
    /// Feature flag key
    required String key,

    /// Override value
    required dynamic value,

    /// Whether the override is enabled
    required bool isEnabled,

    /// Timestamp when the override was created
    required DateTime createdAt,

    /// Timestamp when the override expires (optional)
    DateTime? expiresAt,

    /// Reason for the override
    String? reason,
  }) = _FeatureFlagOverride;

  factory FeatureFlagOverride.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagOverrideFromJson(json);
}

/// Feature flag configuration model for different environments
@freezed
class FeatureFlagConfig with _$FeatureFlagConfig {
  const factory FeatureFlagConfig({
    /// Environment this configuration applies to
    required FeatureFlagEnvironment environment,

    /// Flavor this configuration applies to
    required FeatureFlagFlavor flavor,

    /// Feature flags for this environment/flavor combination
    required Map<String, FeatureFlag> flags,

    /// Timestamp when this configuration was created
    required DateTime createdAt,

    /// Timestamp when this configuration was last updated
    required DateTime updatedAt,
  }) = _FeatureFlagConfig;

  factory FeatureFlagConfig.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagConfigFromJson(json);
}

