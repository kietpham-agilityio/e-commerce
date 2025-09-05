import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../apis/api_client_error.dart';
import '../apis/failure.dart';
import '../apis/api_internal_error_code.dart';
import 'dart:async';

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

  // ============================================================================
  // HEADER MANAGEMENT
  // ============================================================================

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

  // ============================================================================
  // CLIENT ACCESS
  // ============================================================================

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

  // ============================================================================
  // BASIC HTTP METHODS
  // ============================================================================

  /// GET request with enhanced error handling
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
      throw Failure(
        'Unexpected error in GET request: $e',
        internalErrorCode: null,
      );
    }
  }

  /// POST request with enhanced error handling
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
      throw Failure(
        'Unexpected error in POST request: $e',
        internalErrorCode: null,
      );
    }
  }

  /// PUT request with enhanced error handling
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
      throw Failure(
        'Unexpected error in PUT request: $e',
        internalErrorCode: null,
      );
    }
  }

  /// PATCH request with enhanced error handling
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
      throw Failure(
        'Unexpected error in PATCH request: $e',
        internalErrorCode: null,
      );
    }
  }

  /// DELETE request with enhanced error handling
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
      throw Failure(
        'Unexpected error in DELETE request: $e',
        internalErrorCode: null,
      );
    }
  }

  /// Upload file with progress tracking and enhanced error handling
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
      throw Failure(
        'Unexpected error in file upload: $e',
        internalErrorCode: null,
      );
    }
  }

  /// Download file with progress tracking and enhanced error handling
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
      throw Failure(
        'Unexpected error in file download: $e',
        internalErrorCode: null,
      );
    }
  }

  // ============================================================================
  // HIGH-LEVEL SERVICE METHODS
  // ============================================================================

  /// Handle successful response
  T handleSuccess<T>(T data) => data;

  /// Handle error response with internal error code conversion
  Failure handleError(Exception error) {
    if (error is Failure) {
      return error as Failure;
    }
    
    // Convert to API client error if possible
    if (error is DioException) {
      final apiClientError = ApiClientError.convertApiClientErrorFromError(
        error,
        StackTrace.current,
      );
      return Failure.fromApiClientError(apiClientError);
    }
    
    // For other exceptions, create a generic failure
    return Failure(
      error.toString(),
      internalErrorCode: ApiInternalErrorCode.unsupported(),
    );
  }

  /// Handle API response with custom error mapping and internal error codes
  T handleResponse<T>(
    dynamic response,
    T Function(dynamic) fromJson,
  ) {
    try {
      return fromJson(response);
    } catch (e) {
      // Check if response contains error information
      if (response is Map<String, dynamic>) {
        final errorCode = _extractErrorCodeFromResponse(response);
        if (errorCode != null) {
          throw Failure(
            'Failed to parse response: ${_extractErrorMessageFromResponse(response)}',
            internalErrorCode: errorCode,
          );
        }
      }
      
      throw Failure(
        'Failed to parse response: $e',
        internalErrorCode: ApiInternalErrorCode.unsupported(),
      );
    }
  }

  /// Handle list response with enhanced error handling
  List<T> handleListResponse<T>(
    dynamic response,
    T Function(dynamic) fromJson,
  ) {
    try {
      if (response is List) {
        return response.map((item) => fromJson(item)).toList();
      } else if (response is Map && response.containsKey('data')) {
        final listData = response['data'] as List;
        return listData.map((item) => fromJson(item)).toList();
      } else {
        throw Failure(
          'Invalid response format for list',
          internalErrorCode: ApiInternalErrorCode.unsupported(),
        );
      }
    } catch (e) {
      if (e is Failure) rethrow;
      
      // Check if response contains error information
      if (response is Map<String, dynamic>) {
        final errorCode = _extractErrorCodeFromResponse(response);
        if (errorCode != null) {
          throw Failure(
            'Failed to parse list response: ${_extractErrorMessageFromResponse(response)}',
            internalErrorCode: errorCode,
          );
        }
      }
      
      throw Failure(
        'Failed to parse list response: $e',
        internalErrorCode: ApiInternalErrorCode.unsupported(),
      );
    }
  }

  /// Handle paginated response with enhanced error handling
  PaginatedResponse<T> handlePaginatedResponse<T>(
    dynamic response,
    T Function(dynamic) fromJson,
  ) {
    try {
      if (response is Map) {
        final data = response['data'] as List;
        final items = data.map((item) => fromJson(item)).toList();
        
        final pagination = Pagination(
          page: response['page'] ?? 1,
          limit: response['limit'] ?? 10,
          total: response['total'] ?? 0,
          totalPages: response['totalPages'] ?? 1,
        );

        return PaginatedResponse(
          data: items,
          pagination: pagination,
        );
      } else {
        throw Failure(
          'Invalid paginated response format',
          internalErrorCode: ApiInternalErrorCode.unsupported(),
        );
      }
    } catch (e) {
      if (e is Failure) rethrow;
      
      // Check if response contains error information
      if (response is Map<String, dynamic>) {
        final errorCode = _extractErrorCodeFromResponse(response);
        if (errorCode != null) {
          throw Failure(
            'Failed to parse paginated response: ${_extractErrorMessageFromResponse(response)}',
            internalErrorCode: errorCode,
          );
        }
      }
      
      throw Failure(
        'Failed to parse paginated response: $e',
        internalErrorCode: ApiInternalErrorCode.unsupported(),
      );
    }
  }

  /// Check if response has error
  bool hasError(dynamic response) {
    if (response is Map) {
      return response.containsKey('error') || 
             (response.containsKey('message') && response['success'] == false);
    }
    return false;
  }

  /// Extract error message from response
  String extractErrorMessage(dynamic response) {
    if (response is Map) {
      if (response.containsKey('error')) {
        return response['error'].toString();
      }
      if (response.containsKey('message')) {
        return response['message'].toString();
      }
    }
    return 'Unknown error occurred';
  }

  // ============================================================================
  // MAYBE FETCH METHODS
  // ============================================================================

  /// Maybe fetch wrapper with enhanced error handling
  /// Returns data if successful, throws Failure if error occurs
  /// May use cached data if available, uncertain outcome
  /// 
  /// Optional parameters:
  /// - [errorHandler]: Custom error handler function
  /// - [maxRetries]: Maximum number of retry attempts (default: 0, no retry)
  /// - [delay]: Delay between retry attempts (default: 1 second)
  /// - [shouldRetry]: Function to determine if a failure should trigger a retry
  Future<T> maybeFetch<T>(
    Future<T> Function() apiCall, {
    Failure Function(Exception error)? errorHandler,
    int maxRetries = 0,
    Duration delay = const Duration(seconds: 1),
    bool Function(Failure)? shouldRetry,
  }) async {
    int attempts = 0;
    
    while (attempts <= maxRetries) {
      try {
        return await apiCall();
      } on Failure catch (failure) {
        attempts++;
        
        // Check if we should retry based on error type
        if (attempts > maxRetries || 
            (shouldRetry != null && !shouldRetry(failure))) {
          rethrow;
        }
        
        // Don't retry on authentication errors
        if (failure.isAuthError) {
          rethrow;
        }
        
        // Wait before retrying
        if (attempts <= maxRetries) {
          await Future.delayed(delay * attempts);
        }
      } catch (e) {
        attempts++;
        
        if (attempts > maxRetries) {
          if (e is Exception) {
            if (errorHandler != null) {
              throw errorHandler(e);
            }
            throw handleError(e);
          }
          throw Failure(
            'Unexpected error after $maxRetries attempts in maybe fetch: $e',
            internalErrorCode: ApiInternalErrorCode.unsupported(),
          );
        }
        
        // Wait before retrying
        if (attempts <= maxRetries) {
          await Future.delayed(delay * attempts);
        }
      }
    }
    
    throw Failure(
      'Maybe fetch failed after $maxRetries attempts',
      internalErrorCode: ApiInternalErrorCode.unsupported(),
    );
  }

  // ============================================================================
  // FORCE FETCH METHODS
  // ============================================================================

  /// Force fetch wrapper that bypasses any caching and always makes fresh API calls
  /// Returns data if successful, throws Failure if error occurs
  /// Use this when you need to ensure you get the latest data from the server
  /// 
  /// Optional parameters:
  /// - [errorHandler]: Custom error handler function
  /// - [maxRetries]: Maximum number of retry attempts (default: 0, no retry)
  /// - [delay]: Delay between retry attempts (default: 1 second)
  /// - [shouldRetry]: Function to determine if a failure should trigger a retry
  Future<T> forceFetch<T>(
    Future<T> Function() apiCall, {
    Failure Function(Exception error)? errorHandler,
    int maxRetries = 0,
    Duration delay = const Duration(seconds: 1),
    bool Function(Failure)? shouldRetry,
  }) async {
    int attempts = 0;
    
    while (attempts <= maxRetries) {
      try {
        return await apiCall();
      } on Failure catch (failure) {
        attempts++;
        
        // Check if we should retry based on error type
        if (attempts > maxRetries || 
            (shouldRetry != null && !shouldRetry(failure))) {
          rethrow;
        }
        
        // Don't retry on authentication errors
        if (failure.isAuthError) {
          rethrow;
        }
        
        // Wait before retrying
        if (attempts <= maxRetries) {
          await Future.delayed(delay * attempts);
        }
      } catch (e) {
        attempts++;
        
        if (attempts > maxRetries) {
          if (e is Exception) {
            if (errorHandler != null) {
              throw errorHandler(e);
            }
            throw handleError(e);
          }
          throw Failure(
            'Unexpected error after $maxRetries attempts in force fetch: $e',
            internalErrorCode: ApiInternalErrorCode.unsupported(),
          );
        }
        
        // Wait before retrying
        if (attempts <= maxRetries) {
          await Future.delayed(delay * attempts);
        }
      }
    }
    
    throw Failure(
      'Force fetch failed after $maxRetries attempts',
      internalErrorCode: ApiInternalErrorCode.unsupported(),
    );
  }

  // ============================================================================
  // BACKGROUND API CALL METHODS
  // ============================================================================

  /// Common function for calling APIs running in background
  /// Replaces method channel pattern with HTTP methods
  /// Uses existing common error handling from ApiClient
  static Future<T> callApiRunBackground<T>({
    required Future<T> Function() apiCall,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) {
    final completer = Completer<T>();
    
    // Set timeout
    Timer? timeoutTimer;
    if (timeout != Duration.zero) {
      timeoutTimer = Timer(timeout, () {
        if (!completer.isCompleted) {
          completer.completeError(
            Failure(
              'Request timeout${errorContext != null ? ' for $errorContext' : ''}',
              internalErrorCode: ApiInternalErrorCode.unsupported(),
            ),
          );
        }
      });
    }
    
    // Execute API call
    apiCall().then((T result) {
      timeoutTimer?.cancel();
      if (!completer.isCompleted) {
        completer.complete(result);
      }
    }).catchError((dynamic error) {
      timeoutTimer?.cancel();
      if (!completer.isCompleted) {
        // Use existing error handling patterns from ApiClient
        if (error is Failure) {
          completer.completeError(error);
          return;
        }
        
        if (error is DioException) {
          // Use the common error handling function from ApiClient
          final apiClientError = ApiClientError.convertApiClientErrorFromError(
            error,
            StackTrace.current,
          );
          completer.completeError(Failure.fromApiClientError(apiClientError));
          return;
        }
        
        if (error is Exception) {
          completer.completeError(
            Failure(
              error.toString(),
              internalErrorCode: ApiInternalErrorCode.unsupported(),
            ),
          );
          return;
        }
        
        // Handle other error types
        String message = "Unknown error";
        if (error is Map && error.containsKey('details')) {
          message = error['details'].toString();
        } else if (error is String) {
          message = error;
        }
        
        completer.completeError(
          Failure(
            message,
            internalErrorCode: ApiInternalErrorCode.unsupported(),
          ),
        );
      }
    });
    
    return completer.future;
  }

  /// GET request using background pattern
  Future<T> getRunBackground<T>(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) {
    return callApiRunBackground<T>(
      apiCall: () => get<T>(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
      errorContext: errorContext ?? 'GET $uri',
      timeout: timeout,
    );
  }

  /// POST request using background pattern
  Future<T> postRunBackground<T>(
    String uri, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) {
    return callApiRunBackground<T>(
      apiCall: () => post<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      errorContext: errorContext ?? 'POST $uri',
      timeout: timeout,
    );
  }

  /// PUT request using background pattern
  Future<T> putRunBackground<T>(
    String uri, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) {
    return callApiRunBackground<T>(
      apiCall: () => put<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      errorContext: errorContext ?? 'PUT $uri',
      timeout: timeout,
    );
  }

  /// PATCH request using background pattern
  Future<T> patchRunBackground<T>(
    String uri, {
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) {
    return callApiRunBackground<T>(
      apiCall: () => patch<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      errorContext: errorContext ?? 'PATCH $uri',
      timeout: timeout,
    );
  }

  /// DELETE request using background pattern
  Future<T?> deleteRunBackground<T>(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) {
    return callApiRunBackground<T?>(
      apiCall: () => delete<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
      errorContext: errorContext ?? 'DELETE $uri',
      timeout: timeout,
    );
  }

  /// Upload file using background pattern
  Future<T> uploadFileRunBackground<T>(
    String uri, {
    required FormData formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? errorContext,
    Duration timeout = const Duration(seconds: 60),
  }) {
    return callApiRunBackground<T>(
      apiCall: () => uploadFile<T>(
        uri,
        formData: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      errorContext: errorContext ?? 'UPLOAD $uri',
      timeout: timeout,
    );
  }

  /// Download file using background pattern
  Future<T> downloadFileRunBackground<T>(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    String? errorContext,
    Duration timeout = const Duration(seconds: 120),
  }) {
    return callApiRunBackground<T>(
      apiCall: () => downloadFile<T>(
        url,
        savePath,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
      errorContext: errorContext ?? 'DOWNLOAD $url',
      timeout: timeout,
    );
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Extract error code from response and convert to internal error code
  ApiInternalErrorCode? _extractErrorCodeFromResponse(Map<String, dynamic> response) {
    String? errorCode;
    
    if (response.containsKey('code')) {
      errorCode = response['code'].toString();
    } else if (response.containsKey('error_code')) {
      errorCode = response['error_code'].toString();
    }
    
    if (errorCode != null) {
      return ApiInternalErrorCode.fromInternalErrorMessage(errorCode);
    }
    
    return null;
  }

  /// Extract error message from response
  String _extractErrorMessageFromResponse(Map<String, dynamic> response) {
    if (response.containsKey('error')) {
      return response['error'].toString();
    }
    if (response.containsKey('message')) {
      return response['message'].toString();
    }
    if (response.containsKey('error_message')) {
      return response['error_message'].toString();
    }
    return 'Unknown error occurred';
  }

  /// Handle Dio specific errors and convert to Failure with internal error codes
  Failure _handleDioError(DioException error) {
    final apiClientError = ApiClientError.convertApiClientErrorFromError(
      error,
      StackTrace.current,
    );
    
    return Failure.fromApiClientError(apiClientError);
  }

  /// Dispose the client
  void dispose() {
    _dio.close();
  }
}

// ============================================================================
// SUPPORTING CLASSES
// ============================================================================

/// Pagination information
class Pagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  bool get hasNext => page < totalPages;
  bool get hasPrevious => page > 1;
  int get nextPage => hasNext ? page + 1 : page;
  int get previousPage => hasPrevious ? page - 1 : page;
}

/// Paginated response wrapper
class PaginatedResponse<T> {
  final List<T> data;
  final Pagination pagination;

  const PaginatedResponse({
    required this.data,
    required this.pagination,
  });

  bool get isEmpty => data.isEmpty;
  bool get isNotEmpty => data.isNotEmpty;
  int get length => data.length;
  T operator [](int index) => data[index];
}