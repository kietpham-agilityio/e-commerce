import 'package:ec_core/ec_core.dart';

import '../config/api_client_config.dart';

/// Dependency injection module for API client configuration
class ApiClientModule {
  /// Register API client dependencies
  static void registerDependencies() {
    // Register our custom ApiClient with environment-based configuration
    DI.registerService<ApiClient>(_createApiClient(), instanceName: 'main');
  }

  /// Create the main API client instance
  static ApiClient _createApiClient() {
    final flavor = EcFlavor.current;
    final environment = flavor.environment;

    // Get base URL from environment variables
    final baseUrl =
        flavor.isAdmin
            ? ApiClientConfig.getAdminBaseUrl(environment)
            : ApiClientConfig.getBaseUrl(environment);

    // Get additional headers including API key
    final additionalHeaders =
        flavor.isAdmin
            ? ApiClientConfig.getAdminAdditionalHeaders(environment)
            : ApiClientConfig.getAdditionalHeaders(environment);

    // Add flavor and environment headers
    final headers = {
      ...additionalHeaders,
      'X-Flavor': flavor.displayName,
      'X-Environment': environment,
    };

    return ApiClientFactory.createWithCustomUrl(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      interceptors: [MockBackendInterceptor()],
    );
  }

  /// Create API client for specific environment
  static ApiClient createForEnvironment(String environment) {
    final flavor = EcFlavor.current;

    // Get base URL from environment variables
    final baseUrl =
        flavor.isAdmin
            ? ApiClientConfig.getAdminBaseUrl(environment)
            : ApiClientConfig.getBaseUrl(environment);

    // Get additional headers including API key
    final additionalHeaders =
        flavor.isAdmin
            ? ApiClientConfig.getAdminAdditionalHeaders(environment)
            : ApiClientConfig.getAdditionalHeaders(environment);

    // Add flavor and environment headers
    final headers = {
      ...additionalHeaders,
      'X-Flavor': flavor.displayName,
      'X-Environment': environment,
    };

    return ApiClientFactory.createWithCustomUrl(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );
  }

  /// Create API client for specific flavor
  static ApiClient createForFlavor(
    EcFlavor flavor, {
    String environment = 'dev',
  }) {
    // Get base URL from environment variables
    final baseUrl =
        flavor.isAdmin
            ? ApiClientConfig.getAdminBaseUrl(environment)
            : ApiClientConfig.getBaseUrl(environment);

    // Get additional headers including API key
    final additionalHeaders =
        flavor.isAdmin
            ? ApiClientConfig.getAdminAdditionalHeaders(environment)
            : ApiClientConfig.getAdditionalHeaders(environment);

    // Add flavor and environment headers
    final headers = {
      ...additionalHeaders,
      'X-Flavor': flavor.displayName,
      'X-Environment': environment,
    };

    return ApiClientFactory.createWithCustomUrl(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );
  }

  /// Get the registered ApiClient instance
  static ApiClient get apiClient => DI.get<ApiClient>(instanceName: 'main');

  /// Check if dependencies are registered
  static bool get isRegistered =>
      DI.isRegistered<ApiClient>(instanceName: 'main');
}
