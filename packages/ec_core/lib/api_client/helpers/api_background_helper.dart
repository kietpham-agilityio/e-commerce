import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import '../apis/api_client_error.dart';
import '../apis/api_internal_error_code.dart';
import '../apis/failure.dart';

/// Helper class for background API calls with timeout and error handling
class ApiBackgroundHelper {
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
    apiCall()
        .then((T result) {
          timeoutTimer?.cancel();
          if (!completer.isCompleted) {
            completer.complete(result);
          }
        })
        .catchError((dynamic error) {
          timeoutTimer?.cancel();
          if (!completer.isCompleted) {
            // Use existing error handling patterns from ApiClient
            if (error is Failure) {
              completer.completeError(error);
              return;
            }

            if (error is DioException) {
              // Use the common error handling function from ApiClient
              final apiClientError =
                  ApiClientError.convertApiClientErrorFromError(
                    error,
                    StackTrace.current,
                  );
              completer.completeError(
                Failure.fromApiClientError(apiClientError),
              );
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

  /// Background API call with network connectivity check
  static Future<T> callApiWithConnectivityCheck<T>({
    required Future<T> Function() apiCall,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
    bool checkConnectivity = true,
  }) async {
    if (checkConnectivity) {
      try {
        // Check internet connectivity
        final result = await InternetAddress.lookup('google.com');
        if (result.isEmpty || result[0].rawAddress.isEmpty) {
          throw Failure(
            'No internet connection',
            internalErrorCode: ApiInternalErrorCode.unsupported(),
          );
        }
      } on SocketException catch (_) {
        throw Failure(
          'No internet connection',
          internalErrorCode: ApiInternalErrorCode.unsupported(),
        );
      }
    }

    return callApiRunBackground<T>(
      apiCall: apiCall,
      errorContext: errorContext,
      timeout: timeout,
    );
  }

  /// Background API call with retry logic
  static Future<T> callApiWithRetry<T>({
    required Future<T> Function() apiCall,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
    bool Function(Exception)? shouldRetry,
  }) async {
    int attempts = 0;
    Exception? lastError;

    while (attempts <= maxRetries) {
      try {
        return await callApiRunBackground<T>(
          apiCall: apiCall,
          errorContext: errorContext,
          timeout: timeout,
        );
      } on Exception catch (e) {
        lastError = e;
        attempts++;

        // Check if we should retry
        if (attempts > maxRetries || (shouldRetry != null && !shouldRetry(e))) {
          break;
        }

        // Don't retry on authentication errors
        if (e is Failure && (e as Failure).isAuthError) {
          break;
        }

        // Wait before retrying
        if (attempts <= maxRetries) {
          await Future.delayed(retryDelay * attempts);
        }
      }
    }

    throw lastError ??
        Failure(
          'API call failed after $maxRetries attempts',
          internalErrorCode: ApiInternalErrorCode.unsupported(),
        );
  }

  /// Background API call with exponential backoff
  static Future<T> callApiWithExponentialBackoff<T>({
    required Future<T> Function() apiCall,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
    int maxRetries = 3,
    Duration baseDelay = const Duration(milliseconds: 500),
    double backoffMultiplier = 2.0,
    Duration maxDelay = const Duration(seconds: 30),
    bool Function(Exception)? shouldRetry,
  }) async {
    int attempts = 0;
    Exception? lastError;
    Duration currentDelay = baseDelay;

    while (attempts <= maxRetries) {
      try {
        return await callApiRunBackground<T>(
          apiCall: apiCall,
          errorContext: errorContext,
          timeout: timeout,
        );
      } on Exception catch (e) {
        lastError = e;
        attempts++;

        // Check if we should retry
        if (attempts > maxRetries || (shouldRetry != null && !shouldRetry(e))) {
          break;
        }

        // Don't retry on authentication errors
        if (e is Failure && (e as Failure).isAuthError) {
          break;
        }

        // Wait before retrying with exponential backoff
        if (attempts <= maxRetries) {
          await Future.delayed(currentDelay);
          currentDelay = Duration(
            milliseconds: (currentDelay.inMilliseconds * backoffMultiplier)
                .round()
                .clamp(0, maxDelay.inMilliseconds),
          );
        }
      }
    }

    throw lastError ??
        Failure(
          'API call failed after $maxRetries attempts',
          internalErrorCode: ApiInternalErrorCode.unsupported(),
        );
  }
}

/// Extension on Failure to check if it's an authentication error
extension FailureAuthCheckBackground on Failure {
  bool get isAuthError {
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
