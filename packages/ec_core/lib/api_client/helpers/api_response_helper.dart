import '../apis/api_internal_error_code.dart';
import '../apis/failure.dart';

/// Helper class for handling API responses and data transformation
class ApiResponseHelper {
  /// Handle API response with custom error mapping and internal error codes
  static T handleResponse<T>(dynamic response, T Function(dynamic) fromJson) {
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
  static List<T> handleListResponse<T>(
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
  static PaginatedResponse<T> handlePaginatedResponse<T>(
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

        return PaginatedResponse(data: items, pagination: pagination);
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
  static bool hasError(dynamic response) {
    if (response is Map) {
      return response.containsKey('error') ||
          (response.containsKey('message') && response['success'] == false);
    }
    return false;
  }

  /// Extract error message from response
  static String extractErrorMessage(dynamic response) {
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
  static ApiInternalErrorCode? _extractErrorCodeFromResponse(
    Map<String, dynamic> response,
  ) {
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
  static String _extractErrorMessageFromResponse(
    Map<String, dynamic> response,
  ) {
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

  const PaginatedResponse({required this.data, required this.pagination});

  bool get isEmpty => data.isEmpty;
  bool get isNotEmpty => data.isNotEmpty;
  int get length => data.length;
  T operator [](int index) => data[index];
}
