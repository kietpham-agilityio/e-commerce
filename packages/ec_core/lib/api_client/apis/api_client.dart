import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  ApiClient(this.options, {Dio? dio, this.interceptors}) {
    _dio = dio ?? Dio();
    _dio
      ..options = options
      ..options.headers = <String, dynamic>{
        'Content-Type': 'application/json; charset=UTF-8',
      };

    // Add interceptors configuration
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        compact: false,
        filter: (options, args) {
          // Don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // Don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
  }

  final BaseOptions options;

  late Dio _dio;

  final List<Interceptor>? interceptors;

  void appendInterceptors(List<Interceptor> interceptors) {
    _dio.interceptors.addAll(interceptors);
  }

  void setAuthorizationHeader(String token) {
    _dio.options.headers['Authorization'] = token;
  }

  /// Expose Dio client for other services to use
  Dio getDioClient() {
    return _dio;
  }

  set baseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  String get baseUrl => _dio.options.baseUrl;

  Future<T> get<T>(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await _dio.get<T>(
      uri,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    return response.data!;
  }

  Future<T> post<T>(
    String uri, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await _dio.post<T>(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return response.data!;
  }

  Future<T> patch<T>(
    String uri, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await _dio.patch<T>(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return response.data!;
  }

  Future<T?> delete<T>(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.delete<T>(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

    return response.data;
  }

  // UserPreferencesApis get userPreferencesApis => UserPreferencesApis(_dio);
}
