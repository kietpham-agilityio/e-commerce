import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../apis/api_client_error.dart';
import '../apis/failure.dart';

/// Core API client for E-Commerce application
/// Integrates with existing error handling and failure classes
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

  /// Add additional interceptors
  void appendInterceptors(List<Interceptor> interceptors) {
    _dio.interceptors.addAll(interceptors);
  }

  /// Set authorization header
  void setAuthorizationHeader(String token) {
    _dio.options.headers['Authorization'] = token;
  }

  /// Remove authorization header
  void removeAuthorizationHeader() {
    _dio.options.headers.remove('Authorization');
  }

  /// Add custom header
  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  /// Remove custom header
  void removeHeader(String key) {
    _dio.options.headers.remove(key);
  }

  /// Update multiple headers
  void updateHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  /// Clear all headers
  void clearHeaders() {
    _dio.options.headers.clear();
    // Restore default content type
    _dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
  }

  /// Expose Dio client for other services to use
  Dio getDioClient() {
    return _dio;
  }

  /// Set base URL
  set baseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  /// Get base URL
  String get baseUrl => _dio.options.baseUrl;

  /// GET request with error handling
  Future<T> get<T>(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data!;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Failure('Unexpected error: $e');
    }
  }

  /// POST request with error handling
  Future<T> post<T>(
    String uri, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
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
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Failure('Unexpected error: $e');
    }
  }

  /// PUT request with error handling
  Future<T> put<T>(
    String uri, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data!;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Failure('Unexpected error: $e');
    }
  }

  /// PATCH request with error handling
  Future<T> patch<T>(
    String uri, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
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
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Failure('Unexpected error: $e');
    }
  }

  /// DELETE request with error handling
  Future<T?> delete<T>(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Failure('Unexpected error: $e');
    }
  }

  /// Upload file with progress tracking
  Future<T> uploadFile<T>(
    String uri, {
    required FormData formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        uri,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data!;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Failure('Unexpected error: $e');
    }
  }

  /// Download file with progress tracking
  Future<T> downloadFile<T>(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Failure('Unexpected error: $e');
    }
  }

  /// Handle Dio specific errors and convert to Failure
  Failure _handleDioError(DioException error) {
    final apiClientError = ApiClientError.convertApiClientErrorFromError(
      error,
      StackTrace.current,
    );
    
    return Failure(
      apiClientError.toString(),
      noConnectionData: apiClientError,
    );
  }

  /// Dispose the client
  void dispose() {
    _dio.close();
  }
}
