import 'dart:async';
import 'package:dio/dio.dart';
import '../apis/api_client_error.dart';
import '../apis/api_internal_error_code.dart';
import '../apis/failure.dart';

/// Helper class for handling different fetch strategies with Retrofit API calls
class ApiFetchHelper {
  /// Maybe fetch wrapper with enhanced error handling
  /// Returns data if successful, throws Failure if error occurs
  /// May use cached data if available, uncertain outcome
  ///
  /// Optional parameters:
  /// - [errorHandler]: Custom error handler function
  /// - [maxRetries]: Maximum number of retry attempts (default: 0, no retry)
  /// - [delay]: Delay between retry attempts (default: 1 second)
  /// - [shouldRetry]: Function to determine if a failure should trigger a retry
  static Future<T> maybeFetch<T>(
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
            throw _handleError(e);
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

  /// Force fetch wrapper that bypasses any caching and always makes fresh API calls
  /// Returns data if successful, throws Failure if error occurs
  /// Use this when you need to ensure you get the latest data from the server
  ///
  /// Optional parameters:
  /// - [errorHandler]: Custom error handler function
  /// - [maxRetries]: Maximum number of retry attempts (default: 0, no retry)
  /// - [delay]: Delay between retry attempts (default: 1 second)
  /// - [shouldRetry]: Function to determine if a failure should trigger a retry
  static Future<T> forceFetch<T>(
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
            throw _handleError(e);
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

  /// Handle error response with internal error code conversion
  static Failure _handleError(Exception error) {
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
}

/// Extension on Failure to check if it's an authentication error
extension FailureAuthCheck on Failure {
  bool get isAuthError {
    // Add logic to check if this is an authentication error
    // This could be based on error codes, messages, or types
    return internalErrorCode?.maybeWhen(
          authGeneral: () => true,
          authNonActiveUserError: () => true,
          authDoNotHavePermissions: () => true,
          authFailed: () => true,
          orElse: () => false,
        ) ??
        false;
  }
}
