import 'package:dio/dio.dart';
import 'package:ec_core/ec_core.dart';

/// API configuration for different environments and app flavors
/// Base URLs are configurable through environment variables
class ApiConfig {
  /// Default headers for all requests
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'User-Agent': 'E-Commerce-App/1.0.0',
  };

  /// Default timeout settings
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  /// Base URL configuration map
  static final Map<String, String> _baseUrls = {
    'dev': 'https://jsonplaceholder.typicode.com',
    'development': 'https://jsonplaceholder.typicode.com',
    'staging': 'https://staging-api.ecommerce.com',
    'prod': 'https://api.ecommerce.com',
    'production': 'https://api.ecommerce.com',
  };

  /// Admin base URL configuration map
  static final Map<String, String> _adminBaseUrls = {
    'dev': 'https://admin-dev.ecommerce.com',
    'development': 'https://admin-dev.ecommerce.com',
    'staging': 'https://admin-staging.ecommerce.com',
    'prod': 'https://admin.ecommerce.com',
    'production': 'https://admin.ecommerce.com',
  };

  /// Get base URL based on environment string
  static String getBaseUrl(String environment) {
    return _baseUrls[environment.toLowerCase()] ?? _baseUrls['dev']!;
  }

  /// Get admin base URL based on environment string
  static String getAdminBaseUrl(String environment) {
    return _adminBaseUrls[environment.toLowerCase()] ?? _adminBaseUrls['dev']!;
  }

  /// Configure base URLs for environments
  static void configureBaseUrls(Map<String, String> baseUrls) {
    _baseUrls.addAll(baseUrls);
  }

  /// Configure admin base URLs for environments
  static void configureAdminBaseUrls(Map<String, String> adminBaseUrls) {
    _adminBaseUrls.addAll(adminBaseUrls);
  }

  /// Get base URL based on EcFlavor (admin/user variant)
  static String getBaseUrlFromFlavor(EcFlavor flavor) {
    switch (flavor) {
      case EcFlavor.admin:
        return getAdminBaseUrl(flavor.environment);
      case EcFlavor.user:
        return getBaseUrl(flavor.environment);
    }
  }

  /// Get base URL for current flavor
  static String getCurrentFlavorBaseUrl() {
    return getBaseUrlFromFlavor(EcFlavor.current);
  }

  /// Create BaseOptions for API client
  static BaseOptions createBaseOptions({
    required String baseUrl,
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    final headers = Map<String, String>.from(defaultHeaders);

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? ApiConfig.connectTimeout,
      receiveTimeout: receiveTimeout ?? ApiConfig.receiveTimeout,
      sendTimeout: sendTimeout ?? ApiConfig.sendTimeout,
      headers: headers,
    );
  }

  /// Create BaseOptions with environment
  static BaseOptions createBaseOptionsWithEnvironment({
    required String environment,
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    final baseUrl = getBaseUrl(environment);
    return createBaseOptions(
      baseUrl: baseUrl,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );
  }

  /// Create BaseOptions with EcFlavor (admin/user variant)
  static BaseOptions createBaseOptionsWithFlavor({
    required EcFlavor flavor,
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    final baseUrl = getBaseUrlFromFlavor(flavor);
    return createBaseOptions(
      baseUrl: baseUrl,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );
  }

  /// Create BaseOptions for current flavor
  static BaseOptions createCurrentFlavorBaseOptions({
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    return createBaseOptionsWithFlavor(
      flavor: EcFlavor.current,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );
  }

  /// Create default BaseOptions for current environment
  static BaseOptions createDefaultBaseOptions({
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    // Default to dev environment
    return createBaseOptionsWithEnvironment(
      environment: 'dev',
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );
  }

  /// Get environment name from EcFlavor
  static String getEnvironmentFromFlavor(EcFlavor flavor) {
    return flavor.environment;
  }

  /// Check if current flavor is admin
  static bool get isCurrentFlavorAdmin => EcFlavor.current.isAdmin;

  /// Check if current flavor is user
  static bool get isCurrentFlavorUser => EcFlavor.current.isUser;

  /// Check if current flavor is development
  static bool get isCurrentFlavorDevelopment => EcFlavor.current.isDevelopment;

  /// Check if current flavor is staging
  static bool get isCurrentFlavorStaging => EcFlavor.current.isStaging;

  /// Check if current flavor is production
  static bool get isCurrentFlavorProduction => EcFlavor.current.isProduction;
}
