import 'package:e_commerce_app/domain/repositories/feature_flag_repository.dart';
import 'package:ec_core/ec_core.dart';

/// Use case for updating feature flags
class UpdateFeatureFlagUseCase {
  const UpdateFeatureFlagUseCase({
    required FeatureFlagRepository featureFlagRepository,
  }) : _featureFlagRepository = featureFlagRepository;

  final FeatureFlagRepository _featureFlagRepository;

  /// Execute feature flag update
  /// Returns updated [EcFeatureFlag] on success or throws [Failure] on error
  Future<EcFeatureFlag> call(EcFeatureFlag flags) async {
    return await _featureFlagRepository.updateFeatureFlags(flags);
  }
}

/// Use case for getting feature flags
class GetFeatureFlagUseCase {
  const GetFeatureFlagUseCase({
    required FeatureFlagRepository featureFlagRepository,
  }) : _featureFlagRepository = featureFlagRepository;

  final FeatureFlagRepository _featureFlagRepository;

  /// Execute feature flag retrieval
  /// Returns [EcFeatureFlag] on success or throws [Failure] on error
  Future<EcFeatureFlag> call() async {
    return await _featureFlagRepository.getFeatureFlags();
  }
}
