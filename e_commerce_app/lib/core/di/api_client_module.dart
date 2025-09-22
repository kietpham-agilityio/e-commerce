import 'package:ec_core/ec_core.dart';
import 'package:ec_core/mocked_backend/interceptors/mock_backend_interceptor.dart';
import 'package:get_it/get_it.dart';

import '../api_config_override.dart';

/// Dependency injection module for API client configuration
class ApiClientModule {
  static final GetIt _getIt = GetIt.instance;

  /// Register API client dependencies
  static void registerDependencies() {
    // Register ApiClient as singleton
    _getIt.registerLazySingleton<ApiClient>(() => _createApiClient());

    // Register ApiClientFactory for creating different configurations
    _getIt.registerLazySingleton<ApiClientFactory>(() => ApiClientFactory());
  }

  /// Create the main API client instance
  static ApiClient _createApiClient() {
    final flavor = EcFlavor.current;
    final baseUrl =
        flavor.isAdmin
            ? ApiConfigOverride.getAdminBaseUrl('dev')
            : ApiConfigOverride.getBaseUrl('dev');

    return ApiClientFactory.createWithCustomUrl(
      baseUrl: baseUrl,
      headers: {
        'X-App-Version': '1.0.0',
        'X-Platform': 'flutter',
        'X-Flavor': flavor.displayName,
        'X-Environment': 'dev',
      },
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      interceptors: [MockBackendInterceptor()],
    );
  }

  /// Create API client for specific environment
  static ApiClient createForEnvironment(String environment) {
    final flavor = EcFlavor.current;
    final baseUrl =
        flavor.isAdmin
            ? ApiConfigOverride.getAdminBaseUrl(environment)
            : ApiConfigOverride.getBaseUrl(environment);

    return ApiClientFactory.createWithCustomUrl(
      baseUrl: baseUrl,
      headers: {
        'X-App-Version': '1.0.0',
        'X-Platform': 'flutter',
        'X-Flavor': flavor.displayName,
        'X-Environment': environment,
      },
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );
  }

  /// Create API client for specific flavor
  static ApiClient createForFlavor(
    EcFlavor flavor, {
    String environment = 'dev',
  }) {
    final baseUrl =
        flavor.isAdmin
            ? ApiConfigOverride.getAdminBaseUrl(environment)
            : ApiConfigOverride.getBaseUrl(environment);

    return ApiClientFactory.createWithCustomUrl(
      baseUrl: baseUrl,
      headers: {
        'X-App-Version': '1.0.0',
        'X-Platform': 'flutter',
        'X-Flavor': flavor.displayName,
        'X-Environment': environment,
      },
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );
  }

  /// Get the registered ApiClient instance
  static ApiClient get apiClient => _getIt<ApiClient>();

  /// Get the registered ApiClientFactory instance
  static ApiClientFactory get apiClientFactory => _getIt<ApiClientFactory>();

  /// Reset all dependencies (useful for testing)
  static void reset() {
    _getIt.reset();
  }

  /// Check if dependencies are registered
  static bool get isRegistered => _getIt.isRegistered<ApiClient>();
}
