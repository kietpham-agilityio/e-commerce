import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:ec_core/ec_core.dart';

/// Factory class for creating API clients with different configurations
class ApiClientFactory {
  /// Create API client with environment-based configuration
  static ApiClient createWithEnvironment({
    required String environment,
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final baseOptions = ApiConfig.createBaseOptionsWithEnvironment(
      environment: environment,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );

    return ApiClient(baseOptions, interceptors: interceptors, talker: talker);
  }

  /// Create API client with EcFlavor (admin/user variant)
  static ApiClient createWithFlavor({
    required EcFlavor flavor,
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final baseOptions = ApiConfig.createBaseOptionsWithFlavor(
      flavor: flavor,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );

    return ApiClient(baseOptions, interceptors: interceptors, talker: talker);
  }

  /// Create API client for current flavor
  static ApiClient createForCurrentFlavor({
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final baseOptions = ApiConfig.createCurrentFlavorBaseOptions(
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );

    return ApiClient(baseOptions, interceptors: interceptors, talker: talker);
  }

  /// Create API client with custom base URL
  static ApiClient createWithCustomUrl({
    required String baseUrl,
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final baseOptions = ApiConfig.createBaseOptions(
      baseUrl: baseUrl,
      additionalHeaders: headers,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );

    return ApiClient(baseOptions, interceptors: interceptors, talker: talker);
  }

  /// Create API client with default configuration
  static ApiClient createDefault({
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final baseOptions = ApiConfig.createDefaultBaseOptions(
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );

    return ApiClient(baseOptions, interceptors: interceptors, talker: talker);
  }

  /// Create API client for development environment
  static ApiClient createDev({
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    return createWithEnvironment(
      environment: 'dev',
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );
  }

  /// Create API client for staging environment
  static ApiClient createStaging({
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    return createWithEnvironment(
      environment: 'staging',
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );
  }

  /// Create API client for production environment
  static ApiClient createProd({
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    return createWithEnvironment(
      environment: 'prod',
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );
  }

  /// Create API client for admin flavor
  static ApiClient createAdmin({
    String environment = 'dev',
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    return createWithFlavor(
      flavor: EcFlavor.admin,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );
  }

  /// Create API client for user flavor
  static ApiClient createUser({
    String environment = 'dev',
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    return createWithFlavor(
      flavor: EcFlavor.user,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );
  }

  /// Create API client with authentication
  static ApiClient createWithAuth({
    required String token,
    String environment = 'dev',
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final headers = <String, String>{'Authorization': 'Bearer $token'};

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    final apiClient = createWithEnvironment(
      environment: environment,
      additionalHeaders: headers,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );

    return apiClient;
  }

  /// Create API client with authentication for specific flavor
  static ApiClient createWithAuthAndFlavor({
    required String token,
    required EcFlavor flavor,
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final headers = <String, String>{'Authorization': 'Bearer $token'};

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    final apiClient = createWithFlavor(
      flavor: flavor,
      additionalHeaders: headers,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );

    return apiClient;
  }

  /// Create API client with custom interceptors
  static ApiClient createWithInterceptors({
    required List<Interceptor> interceptors,
    String environment = 'dev',
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Talker? talker,
  }) {
    return createWithEnvironment(
      environment: environment,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );
  }

  /// Create API client with custom interceptors for specific flavor
  static ApiClient createWithInterceptorsAndFlavor({
    required List<Interceptor> interceptors,
    required EcFlavor flavor,
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Talker? talker,
  }) {
    return createWithFlavor(
      flavor: flavor,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );
  }
}
