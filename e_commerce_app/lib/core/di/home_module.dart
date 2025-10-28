import 'package:e_commerce_app/data/repositories/home_repository.dart';
import 'package:e_commerce_app/domain/repositories/home_repository.dart';
import 'package:e_commerce_app/domain/usecases/home_usecase.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/di/di_initializer.dart';
import 'package:ec_core/services/ec_local_store/ec_local_database.dart';
import 'package:get_it/get_it.dart';

class HomeModule {
  static final GetIt _getIt = GetIt.instance;

  static void registerDependencies() {
    // Register Supabase repository
    _getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        apiClient: DI.get<ApiClient>(instanceName: 'main'),
        userSessionBox:
            DI.get<EcLocalDatabase>(instanceName: 'main').userSessionBox,
      ),
    );

    // Register use cases
    _getIt.registerLazySingleton<HomeUseCase>(
      () => HomeUseCase(homeRepository: _getIt<HomeRepository>()),
    );
  }

  /// Check if dependencies are registered
  static bool get isRegistered => _getIt.isRegistered<HomeRepository>();
}
