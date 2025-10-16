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
  /// Creates API client with BaseOptions containing only:
  /// - baseUrl: Supabase URL from environment variables
  /// - headers: Only 'apikey' header
  static ApiClient _createApiClient({EcFlavor? flavor, String? environment}) {
    final currentFlavor = flavor ?? EcFlavor.current;
    final currentEnvironment = environment ?? 'dev';

    // Get base URL from environment variables
    final baseUrl =
        currentFlavor.isAdmin
            ? ApiClientConfig.getAdminBaseUrl(currentEnvironment)
            : ApiClientConfig.getBaseUrl(currentEnvironment);

    // Get headers with only 'apikey'
    final headers =
        currentFlavor.isAdmin
            ? ApiClientConfig.getAdminAdditionalHeaders(currentEnvironment)
            : ApiClientConfig.getAdditionalHeaders(currentEnvironment);

    // Create API client with simplified BaseOptions:
    // - No default headers (Content-Type, Accept, User-Agent)
    // - No timeout configurations
    // - Only baseUrl and apikey header
    final apiClient = ApiClientFactory.createWithCustomUrl(
      baseUrl: baseUrl,
      headers: headers,
      interceptors: [MockBackendInterceptor()],
    );

    return apiClient;
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
