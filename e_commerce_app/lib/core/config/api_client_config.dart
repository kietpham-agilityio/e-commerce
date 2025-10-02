import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:ec_core/ec_core.dart';

/// App-specific API client configuration that uses environment variables
class ApiClientConfig {
  /// Get base URL from environment variables
  static String getBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
      case 'development':
        return dotenv.env['API_BASE_URL'] ??
            'https://jsonplaceholder.typicode.com';
      case 'staging':
        return dotenv.env['STAGING_API_BASE_URL'] ??
            'https://staging-api.ecommerce.com';
      case 'prod':
      case 'production':
        return dotenv.env['PROD_API_BASE_URL'] ?? 'https://api.ecommerce.com';
      default:
        return dotenv.env['API_BASE_URL'] ?? 'https://dev-api.ecommerce.com';
    }
  }

  /// Get admin base URL from environment variables
  static String getAdminBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
      case 'development':
        return dotenv.env['ADMIN_API_BASE_URL'] ??
            'https://jsonplaceholder.typicode.com';
      case 'staging':
        return dotenv.env['STAGING_ADMIN_API_BASE_URL'] ??
            'https://staging-admin-api.ecommerce.com';
      case 'prod':
      case 'production':
        return dotenv.env['PROD_ADMIN_API_BASE_URL'] ??
            'https://admin-api.ecommerce.com';
      default:
        return dotenv.env['ADMIN_API_BASE_URL'] ??
            'https://dev-admin-api.ecommerce.com';
    }
  }

  /// Get API key from environment variables
  static String? getApiKey(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
      case 'development':
        return dotenv.env['API_KEY'];
      case 'staging':
        return dotenv.env['STAGING_API_KEY'];
      case 'prod':
      case 'production':
        return dotenv.env['PROD_API_KEY'];
      default:
        return dotenv.env['API_KEY'];
    }
  }

  /// Get admin API key from environment variables
  static String? getAdminApiKey(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
      case 'development':
        return dotenv.env['ADMIN_API_KEY'];
      case 'staging':
        return dotenv.env['STAGING_ADMIN_API_KEY'];
      case 'prod':
      case 'production':
        return dotenv.env['PROD_ADMIN_API_KEY'];
      default:
        return dotenv.env['ADMIN_API_KEY'];
    }
  }

  /// Get additional headers including API key
  static Map<String, String> getAdditionalHeaders(String environment) {
    final headers = <String, String>{};

    // Add API key if available
    final apiKey = getApiKey(environment);
    if (apiKey != null && apiKey.isNotEmpty) {
      headers['X-API-Key'] = apiKey;
    }

    // Add app version from environment
    final appVersion = dotenv.env['APP_VERSION'];
    if (appVersion != null && appVersion.isNotEmpty) {
      headers['X-App-Version'] = appVersion;
    }

    // Add platform header
    headers['X-Platform'] = 'mobile';

    return headers;
  }

  /// Get admin additional headers including admin API key
  static Map<String, String> getAdminAdditionalHeaders(String environment) {
    final headers = <String, String>{};

    // Add admin API key if available
    final adminApiKey = getAdminApiKey(environment);
    if (adminApiKey != null && adminApiKey.isNotEmpty) {
      headers['X-Admin-API-Key'] = adminApiKey;
    }

    // Add app version from environment
    final appVersion = dotenv.env['APP_VERSION'];
    if (appVersion != null && appVersion.isNotEmpty) {
      headers['X-App-Version'] = appVersion;
    }

    // Add platform header
    headers['X-Platform'] = 'mobile';

    return headers;
  }

  /// Create API client with environment-based configuration
  static ApiClient createApiClient({
    required String environment,
    EcFlavor? flavor,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? customInterceptors,
    bool enableLogging = true,
  }) {
    final currentFlavor = flavor ?? EcFlavor.current;

    // Get base URL based on flavor
    final baseUrl =
        currentFlavor.isAdmin
            ? getAdminBaseUrl(environment)
            : getBaseUrl(environment);

    // Get additional headers
    final additionalHeaders =
        currentFlavor.isAdmin
            ? getAdminAdditionalHeaders(environment)
            : getAdditionalHeaders(environment);

    // Create API client using the factory
    return ApiClientFactory.createWithCustomUrl(
      baseUrl: baseUrl,
      headers: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: customInterceptors,
      talker: enableLogging ? null : null, // Will be set by DI
    );
  }

  /// Get current environment configuration
  static Map<String, String> getCurrentEnvironmentConfig() {
    final environment =
        EcFlavor
            .currentEnvironment; // Use DI-set environment instead of flavor.environment
    final flavor = EcFlavor.current;

    return {
      'environment': environment,
      'flavor': flavor.name,
      'baseUrl':
          flavor.isAdmin
              ? getAdminBaseUrl(environment)
              : getBaseUrl(environment),
      'apiKey':
          flavor.isAdmin
              ? getAdminApiKey(environment) ?? 'N/A'
              : getApiKey(environment) ?? 'N/A',
      'appVersion': dotenv.env['APP_VERSION'] ?? 'N/A',
    };
  }
}
