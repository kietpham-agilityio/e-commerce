import 'package:dio/dio.dart';
import '../apis/api_client_error.dart';
import '../apis/failure.dart';
import '../apis/api_internal_error_code.dart';
import 'api_client.dart';
import 'dart:async';

/// Base class for API services
/// Provides common functionality and error handling
abstract class BaseApiService {
  final ApiClient _apiClient;

  BaseApiService(this._apiClient);

  /// Get the API client instance
  ApiClient get apiClient => _apiClient;

  /// Get the underlying Dio client
  Dio get dioClient => _apiClient.getDioClient();

  /// Handle successful response
  T handleSuccess<T>(T data) => data;

  /// Handle error response with internal error code conversion
  Failure<dynamic> handleError(Exception error) {
    if (error is Failure) {
      // Convert to the same generic type
      final failure = error as Failure;
      return Failure<dynamic>(
        failure.message,
        noConnectionData: failure.noConnectionData,
        internalErrorCode: failure.internalErrorCode,
        apiClientError: failure.apiClientError,
      );
    }
    
    // Convert to API client error if possible
    if (error is DioException) {
      final apiClientError = ApiClientError.convertApiClientErrorFromError(
        error,
        StackTrace.current,
      );
      return Failure.fromApiClientError(apiClientError);
    }
    
    // For other exceptions, create a generic failure with correct type
    return Failure<dynamic>(
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

  /// Add authentication header
  void addAuthHeader(String token) {
    _apiClient.setAuthorizationHeader('Bearer $token');
  }

  /// Remove authentication header
  void removeAuthHeader() {
    _apiClient.removeAuthorizationHeader();
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

  /// Extract error code from response and convert to internal error code
  ApiInternalErrorCode? _extractErrorCodeFromResponse(Map<String, dynamic> response) {
    String? errorCode;
    
    if (response.containsKey('code')) {
      errorCode = response['code'].toString();
    } else if (response.containsKey('error_code')) {
      errorCode = response['error_code'].toString();
    } else if (response.containsKey('status')) {
      errorCode = response['status'].toString();
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

  /// Safe API call wrapper with enhanced error handling
  Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on Failure {
      rethrow;
    } catch (e) {
      if (e is Exception) {
        throw handleError(e);
      }
      throw Failure(
        'Unexpected error: $e',
        internalErrorCode: ApiInternalErrorCode.unsupported(),
      );
    }
  }

  /// Safe API call with custom error handling and internal error codes
  Future<T> safeApiCallWithError<T>(
    Future<T> Function() apiCall,
    Failure Function(Exception error) errorHandler,
  ) async {
    try {
      return await apiCall();
    } on Failure {
      rethrow;
    } catch (e) {
      if (e is Exception) {
        throw errorHandler(e);
      }
      throw Failure(
        'Unexpected error: $e',
        internalErrorCode: ApiInternalErrorCode.unsupported(),
      );
    }
  }

  /// Safe API call with retry logic and internal error code handling
  Future<T> safeApiCallWithRetry<T>(
    Future<T> Function() apiCall, {
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
    bool Function(Failure)? shouldRetry,
  }) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      try {
        return await apiCall();
      } on Failure catch (failure) {
        attempts++;
        
        // Check if we should retry based on error type
        if (attempts >= maxRetries || 
            (shouldRetry != null && !shouldRetry(failure))) {
          rethrow;
        }
        
        // Don't retry on authentication errors
        if (failure.isAuthError) {
          rethrow;
        }
        
        // Wait before retrying
        if (attempts < maxRetries) {
          await Future.delayed(delay * attempts);
        }
      } catch (e) {
        attempts++;
        
        if (attempts >= maxRetries) {
          if (e is Exception) {
            throw handleError(e);
          }
          throw Failure(
            'Unexpected error after $maxRetries attempts: $e',
            internalErrorCode: ApiInternalErrorCode.unsupported(),
          );
        }
        
        // Wait before retrying
        if (attempts < maxRetries) {
          await Future.delayed(delay * attempts);
        }
      }
    }
    
    throw Failure(
      'Failed after $maxRetries attempts',
      internalErrorCode: ApiInternalErrorCode.unsupported(),
    );
  }

  /// Common function for calling APIs using Completer
  /// Replaces method channel pattern with HTTP methods
  /// Uses existing common error handling from ApiClient
  static Future<T> callApiWithCompleter<T>({
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

  /// GET request using Completer pattern
  /// Uses existing ApiClient.get() with built-in error handling
  Future<T> getWithCompleter<T>(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) {
    return callApiWithCompleter<T>(
      apiCall: () => apiClient.get<T>(
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

  /// POST request using Completer pattern
  /// Uses existing ApiClient.post() with built-in error handling
  Future<T> postWithCompleter<T>(
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
    return callApiWithCompleter<T>(
      apiCall: () => apiClient.post<T>(
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

  /// PUT request using Completer pattern
  /// Uses existing ApiClient.put() with built-in error handling
  Future<T> putWithCompleter<T>(
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
    return callApiWithCompleter<T>(
      apiCall: () => apiClient.put<T>(
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

  /// PATCH request using Completer pattern
  /// Uses existing ApiClient.patch() with built-in error handling
  Future<T> patchWithCompleter<T>(
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
    return callApiWithCompleter<T>(
      apiCall: () => apiClient.patch<T>(
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

  /// DELETE request using Completer pattern
  /// Uses existing ApiClient.delete() with built-in error handling
  Future<T?> deleteWithCompleter<T>(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) {
    return callApiWithCompleter<T?>(
      apiCall: () => apiClient.delete<T>(
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

  /// Upload file using Completer pattern
  /// Uses existing ApiClient.uploadFile() with built-in error handling
  Future<T> uploadFileWithCompleter<T>(
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
    return callApiWithCompleter<T>(
      apiCall: () => apiClient.uploadFile<T>(
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

  /// Download file using Completer pattern
  /// Uses existing ApiClient.downloadFile() with built-in error handling
  Future<T> downloadFileWithCompleter<T>(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    String? errorContext,
    Duration timeout = const Duration(seconds: 120),
  }) {
    return callApiWithCompleter<T>(
      apiCall: () => apiClient.downloadFile<T>(
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
}

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
