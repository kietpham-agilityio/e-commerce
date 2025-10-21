import 'package:e_commerce_app/domain/repositories/feature_flag_repository.dart';
import 'package:ec_core/ec_core.dart';

/// Use case for fetching feature flags from the server
class FetchFeatureFlagsUseCase {
  FetchFeatureFlagsUseCase({required FeatureFlagRepository repository})
    : _repository = repository;

  final FeatureFlagRepository _repository;

  Future<EcFeatureFlag> execute() async {
    return await _repository.fetchFeatureFlags();
  }
}
