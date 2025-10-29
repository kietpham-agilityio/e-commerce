import 'package:e_commerce_app/data/repositories/shop_repository.dart';
import 'package:e_commerce_app/domain/repositories/home_repository.dart';
import 'package:e_commerce_app/domain/repositories/shop_repository.dart';
import 'package:e_commerce_app/domain/usecases/shop_usecase.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/di/di_initializer.dart';
import 'package:get_it/get_it.dart';

class ShopModule {
  static final GetIt _getIt = GetIt.instance;

  static void registerDependencies() {
    // Register Supabase repository
    _getIt.registerLazySingleton<ShopRepository>(
      () => ShopRepositoryImpl(
        apiClient: DI.get<ApiClient>(instanceName: 'main'),
      ),
    );

    // Register use cases
    _getIt.registerLazySingleton<ShopUseCase>(
      () => ShopUseCase(shopRepository: _getIt<ShopRepository>()),
    );
  }

  /// Check if dependencies are registered
  static bool get isRegistered => _getIt.isRegistered<HomeRepository>();
}
