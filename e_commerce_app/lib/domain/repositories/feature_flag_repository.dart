import 'package:ec_core/ec_core.dart';

/// Feature flag repository interface
abstract class FeatureFlagRepository {
  /// Get current feature flags for user
  Future<EcFeatureFlag> getFeatureFlags();

  /// Update feature flags for user
  Future<EcFeatureFlag> updateFeatureFlags(EcFeatureFlag flags);
}
