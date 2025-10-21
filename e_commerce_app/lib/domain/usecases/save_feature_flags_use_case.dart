import 'package:e_commerce_app/domain/repositories/feature_flag_repository.dart';
import 'package:ec_core/ec_core.dart';

/// Use case for saving feature flags to the server
class SaveFeatureFlagsUseCase {
  SaveFeatureFlagsUseCase({required FeatureFlagRepository repository})
    : _repository = repository;

  final FeatureFlagRepository _repository;

  Future<void> execute(EcFeatureFlag flags) async {
    await _repository.saveFeatureFlags(flags);
  }
}
