import 'package:dio/dio.dart';
import '../apis/api_client_error.dart';
import '../apis/failure.dart';
import 'api_client.dart';

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

  /// Handle error response
  Failure handleError(Exception error) => Failure(error.toString());

  /// Handle API response with custom error mapping
  T handleResponse<T>(
    dynamic response,
    T Function(dynamic) fromJson,
  ) {
    try {
      return fromJson(response);
    } catch (e) {
      throw Failure('Failed to parse response: $e');
    }
  }

  /// Handle list response
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
        throw Failure('Invalid response format for list');
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure('Failed to parse list response: $e');
    }
  }

  /// Handle paginated response
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
        throw Failure('Invalid paginated response format');
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure('Failed to parse paginated response: $e');
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

  /// Safe API call wrapper
  Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure('Unexpected error: $e');
    }
  }

  /// Safe API call with custom error handling
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
      throw Failure('Unexpected error: $e');
    }
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
