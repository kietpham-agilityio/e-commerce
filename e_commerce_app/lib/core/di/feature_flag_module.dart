import 'package:e_commerce_app/data/repositories/feature_flag_repository.dart';
import 'package:e_commerce_app/domain/repositories/feature_flag_repository.dart';
import 'package:e_commerce_app/domain/usecases/feature_flag_usecase.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/di/di_initializer.dart';
import 'package:ec_core/services/ec_local_store/ec_local_database.dart';
import 'package:get_it/get_it.dart';

/// Feature flag module for registering feature flag related dependencies
class FeatureFlagModule {
  static final GetIt _getIt = GetIt.instance;

  /// Register feature flag dependencies
  static void registerDependencies() {
    // Register repository
    _getIt.registerLazySingleton<FeatureFlagRepository>(
      () => FeatureFlagRepositoryImpl(
        apiClient: DI.get<ApiClient>(instanceName: 'main'),
        userSessionBox:
            DI.get<EcLocalDatabase>(instanceName: 'main').userSessionBox,
      ),
    );

    // Register use cases
    _getIt.registerLazySingleton<UpdateFeatureFlagUseCase>(
      () => UpdateFeatureFlagUseCase(
        featureFlagRepository: _getIt<FeatureFlagRepository>(),
      ),
    );

    _getIt.registerLazySingleton<LogFeatureFlagChangeUseCase>(
      () => LogFeatureFlagChangeUseCase(
        featureFlagRepository: _getIt<FeatureFlagRepository>(),
      ),
    );

    _getIt.registerLazySingleton<GetFeatureFlagUseCase>(
      () => GetFeatureFlagUseCase(
        featureFlagRepository: _getIt<FeatureFlagRepository>(),
      ),
    );
  }

  /// Check if dependencies are registered
  static bool get isRegistered => _getIt.isRegistered<FeatureFlagRepository>();

  /// Reset all dependencies (useful for testing)
  static void reset() {
    if (_getIt.isRegistered<FeatureFlagRepository>()) {
      _getIt.unregister<FeatureFlagRepository>();
    }
    if (_getIt.isRegistered<UpdateFeatureFlagUseCase>()) {
      _getIt.unregister<UpdateFeatureFlagUseCase>();
    }
    if (_getIt.isRegistered<LogFeatureFlagChangeUseCase>()) {
      _getIt.unregister<LogFeatureFlagChangeUseCase>();
    }
    if (_getIt.isRegistered<GetFeatureFlagUseCase>()) {
      _getIt.unregister<GetFeatureFlagUseCase>();
    }
  }
}
