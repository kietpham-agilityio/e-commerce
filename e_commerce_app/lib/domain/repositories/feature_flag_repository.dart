import 'package:ec_core/ec_core.dart';

/// Repository interface for feature flag operations
abstract class FeatureFlagRepository {
  /// Fetch feature flags from the server
  Future<EcFeatureFlag> fetchFeatureFlags();

  /// Save feature flags to the server
  Future<void> saveFeatureFlags(EcFeatureFlag flags);
}
