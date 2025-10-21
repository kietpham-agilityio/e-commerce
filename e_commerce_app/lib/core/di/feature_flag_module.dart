import 'package:e_commerce_app/data/repositories/feature_flag_repository_impl.dart';
import 'package:e_commerce_app/domain/repositories/feature_flag_repository.dart';
import 'package:e_commerce_app/domain/usecases/fetch_feature_flags_use_case.dart';
import 'package:e_commerce_app/domain/usecases/save_feature_flags_use_case.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/di/di_initializer.dart';
import 'package:ec_core/services/ec_local_store/ec_local_database.dart';
import 'package:get_it/get_it.dart';

/// Dependency injection module for feature flag-related dependencies
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
    _getIt.registerLazySingleton<FetchFeatureFlagsUseCase>(
      () =>
          FetchFeatureFlagsUseCase(repository: _getIt<FeatureFlagRepository>()),
    );

    _getIt.registerLazySingleton<SaveFeatureFlagsUseCase>(
      () =>
          SaveFeatureFlagsUseCase(repository: _getIt<FeatureFlagRepository>()),
    );
  }

  /// Check if dependencies are registered
  static bool get isRegistered => _getIt.isRegistered<FeatureFlagRepository>();
}
