import 'package:talker_flutter/talker_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/api_client/core/api_client_factory.dart';
import 'repositories/products/products_repository.dart';
import 'repositories/products/abstract_products_repository.dart';

/// Initialize Talker and register it in the DI container
void setupLogger() {
  final talker = TalkerFlutter.init();

  // Register Talker in the DI container
  GetIt.instance.registerSingleton<Talker>(talker);

  // Create ApiClient with TalkerDioLogger interceptor
  final apiClient = ApiClientFactory.createDev(talker: talker);

  // Register ApiClient
  GetIt.instance.registerSingleton<ApiClient>(apiClient);

  // Register ProductsRepository with ApiClient
  GetIt.instance.registerSingleton<AbstractProductsRepository>(
    ProductsRepository(dio: apiClient.getDioClient()),
  );
}

/// Dispose Talker resources
void disposeLogger() {
  // Talker doesn't have a dispose method, so we just clear the DI
  GetIt.instance.reset();
}
