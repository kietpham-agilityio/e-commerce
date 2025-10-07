import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Custom API configuration that overrides the core ApiConfig methods
class ApiConfigOverride {
  /// Override getBaseUrl to provide environment-specific URLs from .env files
  static String getBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
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

  /// Override getAdminBaseUrl to provide admin-specific URLs from .env files
  static String getAdminBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
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

    return headers;
  }
}
