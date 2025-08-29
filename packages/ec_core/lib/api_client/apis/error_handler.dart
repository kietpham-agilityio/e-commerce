import 'api_client_error.dart';
import 'api_internal_error_code.dart';
import 'failure.dart';
import 'dart:developer' as developer;

/// Centralized error handler for API operations
class ApiErrorHandler {
  /// Convert any error to a Failure with internal error codes
  static Failure handleError(dynamic error, {StackTrace? stackTrace}) {
    if (error is Failure) return error;
    
    if (error is Exception) {
      return _handleException(error, stackTrace);
    }
    
    return Failure(
      'Unexpected error: $error',
      internalErrorCode: ApiInternalErrorCode.unsupported(),
    );
  }

  /// Handle specific exceptions and convert to appropriate failures
  static Failure _handleException(Exception exception, StackTrace? stackTrace) {
    if (exception is ApiClientError) {
      return Failure.fromApiClientError(exception as ApiClientError);
    }
    
    // Handle other specific exception types
    final errorString = exception.toString().toLowerCase();
    
    if (errorString.contains('timeout') || errorString.contains('timed out')) {
      return Failure(
        'Request timed out: $exception',
        internalErrorCode: ApiInternalErrorCode.unsupported(),
      );
    }
    
    if (errorString.contains('network') || errorString.contains('connection')) {
      return Failure(
        'Network error: $exception',
        internalErrorCode: ApiInternalErrorCode.unsupported(),
      );
    }
    
    if (errorString.contains('unauthorized') || errorString.contains('401')) {
      return Failure(
        'Unauthorized: $exception',
        internalErrorCode: ApiInternalErrorCode.authGeneral(),
      );
    }
    
    if (errorString.contains('forbidden') || errorString.contains('403')) {
      return Failure(
        'Forbidden: $exception',
        internalErrorCode: ApiInternalErrorCode.authDoNotHavePermissions(),
      );
    }
    
    if (errorString.contains('not found') || errorString.contains('404')) {
      return Failure(
        'Resource not found: $exception',
        internalErrorCode: ApiInternalErrorCode.unsupported(),
      );
    }
    
    if (errorString.contains('server error') || errorString.contains('500')) {
      return Failure(
        'Server error: $exception',
        internalErrorCode: ApiInternalErrorCode.unsupported(),
      );
    }
    
    // Default case
    return Failure(
      'Unexpected error: $exception',
      internalErrorCode: ApiInternalErrorCode.unsupported(),
    );
  }

  /// Check if an error should trigger a retry
  static bool shouldRetry(Failure failure) {
    // Don't retry on authentication errors
    if (failure.isAuthError) return false;
    
    // Retry on network and server errors
    if (failure.isNetworkError || failure.isServerError) return true;
    
    // Don't retry on client errors (4xx)
    if (failure.apiClientError != null) {
      return failure.apiClientError!.maybeWhen(
        badRequest: (_, __, ___) => false,
        unauthorizedRequest: (_, __, ___) => false,
        forbiddenRequest: (_, __, ___) => false,
        notFound: (_, __, ___) => false,
        methodNotAllowed: (_, __, ___) => false,
        notAcceptable: (_, __, ___) => false,
        orElse: () => true,
      );
    }
    
    return false;
  }

  /// Get user-friendly error message based on internal error code
  static String getUserFriendlyMessage(Failure failure) {
    if (failure.internalErrorCode != null) {
      return failure.internalErrorCode!.maybeWhen(
        authGeneral: () => 'Authentication failed. Please try again.',
        authNonActiveUserError: () => 'Your account is not active. Please contact support.',
        authDoNotHavePermissions: () => 'You don\'t have permission to perform this action.',
        authFailed: () => 'Authentication failed. Please check your credentials.',
        orElse: () => failure.message,
      );
    }
    
    // Fallback to API client error messages
    if (failure.apiClientError != null) {
      return failure.apiClientError!.maybeWhen(
        noInternetConnection: (_, __, ___) => 'No internet connection. Please check your network.',
        requestTimeout: (_, __, ___) => 'Request timed out. Please try again.',
        sendTimeout: (_, __, ___) => 'Request timed out. Please try again.',
        internalServerError: (_, __, ___) => 'Server error. Please try again later.',
        serviceUnavailable: (_, __, ___) => 'Service temporarily unavailable. Please try again later.',
        orElse: () => failure.message,
      );
    }
    
    return failure.message;
  }

  /// Log error for debugging purposes
  static void logError(Failure failure, {String? context}) {
    final contextInfo = context != null ? ' [$context]' : '';
    
    developer.log('API Error$contextInfo: ${failure.message}');
    if (failure.internalErrorCode != null) {
      developer.log('Internal Error Code: ${failure.internalErrorCode}');
    }
    if (failure.apiClientError != null) {
      developer.log('API Client Error: ${failure.apiClientError}');
    }
  }

  /// Create a standardized error response
  static Map<String, dynamic> createErrorResponse(Failure failure) {
    return {
      'success': false,
      'error': {
        'message': getUserFriendlyMessage(failure),
        'code': failure.internalErrorCode?.toString() ?? 'UNKNOWN',
        'type': _getErrorType(failure),
        'retryable': shouldRetry(failure),
      },
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// Get error type for categorization
  static String _getErrorType(Failure failure) {
    if (failure.isAuthError) return 'AUTHENTICATION';
    if (failure.isNetworkError) return 'NETWORK';
    if (failure.isServerError) return 'SERVER';
    return 'CLIENT';
  }
}
