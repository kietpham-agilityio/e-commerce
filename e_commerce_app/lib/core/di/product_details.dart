import 'package:e_commerce_app/data/repositories/product_details_repository.dart';
import 'package:e_commerce_app/domain/repositories/home_repository.dart';
import 'package:e_commerce_app/domain/repositories/product_details_repository.dart';
import 'package:e_commerce_app/domain/usecases/product_details_usecase.dart';
import 'package:e_commerce_app/presentations/product_details/bloc/product_details_bloc.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/di/di_initializer.dart';
import 'package:get_it/get_it.dart';

class ProductDetailsModule {
  static final GetIt _getIt = GetIt.instance;

  static void registerDependencies() {
    // Register Supabase repository
    _getIt.registerLazySingleton<ProductDetailsRepository>(
      () => ProductDetailsRepositoryImpl(
        apiClient: DI.get<ApiClient>(instanceName: 'main'),
      ),
    );

    // Register use cases
    _getIt.registerLazySingleton<ProductDetailsUseCase>(
      () => ProductDetailsUseCase(
        productDetailsRepository: _getIt<ProductDetailsRepository>(),
      ),
    );

    // Register BLoC
    // _getIt.registerFactory<ProductDetailsBloc>(
    //   () => ProductDetailsBloc(
    //     productDetailsUseCase: _getIt<ProductDetailsUseCase>(),
    //   ),
    // );
  }

  /// Check if dependencies are registered
  static bool get isRegistered => _getIt.isRegistered<HomeRepository>();
}
