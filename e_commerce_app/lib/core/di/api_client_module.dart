import 'package:ec_core/ec_core.dart';

import '../config/api_client_config.dart';

/// Dependency injection module for API client configuration
class ApiClientModule {
  /// Register API client dependencies
  static void registerDependencies({String environment = 'dev'}) {
    // Register our custom ApiClient with environment-based configuration
    // Use override: true to replace any existing registration
    DI.registerService<ApiClient>(
      forEnvironment(environment: environment),
      instanceName: 'main',
      override: true,
    );
  }

  /// Create API client for specific environment (defaults to 'dev')
  static ApiClient forEnvironment({String environment = 'dev'}) {
    return _createApiClient(environment: environment);
  }

  /// Create API client for specific flavor (defaults to 'user')
  static ApiClient forFlavor({
    EcFlavor flavor = EcFlavor.user,
    String environment = 'dev',
  }) {
    return _createApiClient(flavor: flavor, environment: environment);
  }

  /// Create the main API client instance
  static ApiClient _createApiClient({EcFlavor? flavor, String? environment}) {
    final currentFlavor = flavor ?? EcFlavor.current;
    final currentEnvironment = environment ?? 'dev';

    // Get base URL from environment variables
    final baseUrl =
        currentFlavor.isAdmin
            ? ApiClientConfig.getAdminBaseUrl(currentEnvironment)
            : ApiClientConfig.getBaseUrl(currentEnvironment);

    // Get additional headers including API key
    final additionalHeaders =
        currentFlavor.isAdmin
            ? ApiClientConfig.getAdminAdditionalHeaders(currentEnvironment)
            : ApiClientConfig.getAdditionalHeaders(currentEnvironment);

    // Add flavor and environment headers
    final headers = {
      ...additionalHeaders,
      'X-Flavor': currentFlavor.displayName,
      'X-Environment': currentEnvironment,
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
    return _createApiClient(environment: environment);
  }

  /// Create API client for specific flavor
  static ApiClient createForFlavor(
    EcFlavor flavor, {
    String environment = 'dev',
  }) {
    return _createApiClient(flavor: flavor, environment: environment);
  }

  /// Get the registered ApiClient instance
  static ApiClient get apiClient => DI.get<ApiClient>(instanceName: 'main');

  /// Check if dependencies are registered
  static bool get isRegistered =>
      DI.isRegistered<ApiClient>(instanceName: 'main');
}
