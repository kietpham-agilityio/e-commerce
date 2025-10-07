import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:ec_core/ec_core.dart';

/// App-specific API client configuration that uses environment variables
class ApiClientConfig {
  /// Get base URL from environment variables (Supabase URL)
  static String getBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
      case 'development':
        return dotenv.env['SUPABASE_URL'] ?? '';
      case 'staging':
        return dotenv.env['SUPABASE_URL'] ?? '';
      case 'prod':
      case 'production':
        return dotenv.env['SUPABASE_URL'] ?? '';
      default:
        return dotenv.env['SUPABASE_URL'] ?? '';
    }
  }

  /// Get admin base URL from environment variables (Admin Supabase URL)
  static String getAdminBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
      case 'development':
        return dotenv.env['ADMIN_SUPABASE_URL'] ??
            dotenv.env['SUPABASE_URL'] ??
            '';
      case 'staging':
        return dotenv.env['ADMIN_SUPABASE_URL'] ??
            dotenv.env['SUPABASE_URL'] ??
            '';
      case 'prod':
      case 'production':
        return dotenv.env['ADMIN_SUPABASE_URL'] ??
            dotenv.env['SUPABASE_URL'] ??
            '';
      default:
        return dotenv.env['ADMIN_SUPABASE_URL'] ??
            dotenv.env['SUPABASE_URL'] ??
            '';
    }
  }

  /// Get Supabase anon key from environment variables
  static String? getApiKey(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
      case 'development':
        return dotenv.env['SUPABASE_ANON_KEY'];
      case 'staging':
        return dotenv.env['SUPABASE_ANON_KEY'];
      case 'prod':
      case 'production':
        return dotenv.env['SUPABASE_ANON_KEY'];
      default:
        return dotenv.env['SUPABASE_ANON_KEY'];
    }
  }

  /// Get admin Supabase anon key from environment variables
  static String? getAdminApiKey(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
      case 'development':
        return dotenv.env['ADMIN_SUPABASE_ANON_KEY'] ??
            dotenv.env['SUPABASE_ANON_KEY'];
      case 'staging':
        return dotenv.env['ADMIN_SUPABASE_ANON_KEY'] ??
            dotenv.env['SUPABASE_ANON_KEY'];
      case 'prod':
      case 'production':
        return dotenv.env['ADMIN_SUPABASE_ANON_KEY'] ??
            dotenv.env['SUPABASE_ANON_KEY'];
      default:
        return dotenv.env['ADMIN_SUPABASE_ANON_KEY'] ??
            dotenv.env['SUPABASE_ANON_KEY'];
    }
  }

  /// Get additional headers including Supabase anon key
  static Map<String, String> getAdditionalHeaders(String environment) {
    final headers = <String, String>{};

    // Add Supabase anon key to apikey header
    final anonKey = getApiKey(environment);
    if (anonKey != null && anonKey.isNotEmpty) {
      headers['apikey'] = anonKey;
      // Also add it to Authorization header as Bearer token
      headers['Authorization'] = 'Bearer $anonKey';
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

  /// Get admin additional headers including admin Supabase anon key
  static Map<String, String> getAdminAdditionalHeaders(String environment) {
    final headers = <String, String>{};

    // Add admin Supabase anon key to apikey header
    final adminAnonKey = getAdminApiKey(environment);
    if (adminAnonKey != null && adminAnonKey.isNotEmpty) {
      headers['apikey'] = adminAnonKey;
      // Also add it to Authorization header as Bearer token
      headers['Authorization'] = 'Bearer $adminAnonKey';
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
      'anonKey':
          flavor.isAdmin
              ? getAdminApiKey(environment) ?? 'N/A'
              : getApiKey(environment) ?? 'N/A',
      'appVersion': dotenv.env['APP_VERSION'] ?? 'N/A',
    };
  }
}
