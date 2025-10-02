import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../apis/ecommerce_api.dart';
import 'api_config.dart';
import 'package:ec_core/ec_flavor.dart';

/// Factory class for creating Retrofit-based API clients
class RetrofitApiFactory {
  /// Create EcommerceApi client with environment-based configuration
  static EcommerceApi createWithEnvironment({
    required String environment,
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final dio = _createDioClient(
      environment: environment,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );

    return EcommerceApi(dio);
  }

  /// Create EcommerceApi client with EcFlavor (admin/user variant)
  static EcommerceApi createWithFlavor({
    required EcFlavor flavor,
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final dio = _createDioClient(
      flavor: flavor,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );

    return EcommerceApi(dio);
  }

  /// Create EcommerceApi client for current flavor
  static EcommerceApi createForCurrentFlavor({
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final dio = _createDioClient(
      useCurrentFlavor: true,
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );

    return EcommerceApi(dio);
  }

  /// Create EcommerceApi client with custom base URL
  static EcommerceApi createWithCustomUrl({
    required String baseUrl,
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final dio = _createDioClient(
      baseUrl: baseUrl,
      additionalHeaders: headers,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );

    return EcommerceApi(dio);
  }

  /// Create EcommerceApi client with default configuration
  static EcommerceApi createDefault({
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    final dio = _createDioClient(
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );

    return EcommerceApi(dio);
  }

  /// Create EcommerceApi client for development environment
  static EcommerceApi createDev({
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    return createWithEnvironment(
      environment: 'development',
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );
  }

  /// Create EcommerceApi client for staging environment
  static EcommerceApi createStaging({
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

  /// Create EcommerceApi client for production environment
  static EcommerceApi createProduction({
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    return createWithEnvironment(
      environment: 'production',
      additionalHeaders: additionalHeaders,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      interceptors: interceptors,
      talker: talker,
    );
  }

  /// Private method to create Dio client with configuration
  static Dio _createDioClient({
    String? environment,
    EcFlavor? flavor,
    bool useCurrentFlavor = false,
    String? baseUrl,
    Map<String, String>? additionalHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
    Talker? talker,
  }) {
    late BaseOptions baseOptions;

    if (baseUrl != null) {
      baseOptions = ApiConfig.createBaseOptions(
        baseUrl: baseUrl,
        additionalHeaders: additionalHeaders,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      );
    } else if (useCurrentFlavor) {
      baseOptions = ApiConfig.createCurrentFlavorBaseOptions(
        additionalHeaders: additionalHeaders,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      );
    } else if (flavor != null) {
      baseOptions = ApiConfig.createBaseOptionsWithFlavor(
        flavor: flavor,
        additionalHeaders: additionalHeaders,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      );
    } else if (environment != null) {
      baseOptions = ApiConfig.createBaseOptionsWithEnvironment(
        environment: environment,
        additionalHeaders: additionalHeaders,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      );
    } else {
      baseOptions = ApiConfig.createDefaultBaseOptions(
        additionalHeaders: additionalHeaders,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      );
    }

    final dio = Dio(baseOptions);

    // Add TalkerDioLogger interceptor if talker is provided
    if (talker != null) {
      dio.interceptors.add(TalkerDioLogger(talker: talker));
    }

    // Add custom interceptors if provided
    if (interceptors?.isNotEmpty ?? false) {
      dio.interceptors.addAll(interceptors!);
    }

    return dio;
  }
}
