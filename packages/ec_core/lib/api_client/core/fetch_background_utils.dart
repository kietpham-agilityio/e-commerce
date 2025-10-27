import 'dart:async';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../apis/api_client_error.dart';
import '../apis/api_internal_error_code.dart';
import '../apis/failure.dart';

/// Utility class for background API fetching using Completer
class FetchBackgroundUtils {
  /// Fetches API data in the background using Completer
  ///
  /// This function wraps any API call in a Completer to handle it asynchronously
  /// in the background, providing better control over the execution flow.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await FetchBackgroundUtils.fetchBackground(
  ///   apiCall: () => apiClient.getFeatureFlags(),
  ///   errorContext: 'fetching feature flags',
  /// );
  /// ```
  static Future<T> fetchBackground<T>({
    required Future<T> Function() apiCall,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
    bool checkConnectivity = false,
  }) async {
    final completer = Completer<T>();

    // Optional connectivity check - only check for no internet connection
    if (checkConnectivity) {
      try {
        final connectivityResult = await Connectivity().checkConnectivity();

        // Check if no network connection is available
        if (connectivityResult.contains(ConnectivityResult.none)) {
          completer.completeError(
            Failure(
              'No internet connection${errorContext != null ? ' for $errorContext' : ''}',
              internalErrorCode: ApiInternalErrorCode.unsupported(),
            ),
          );
          return completer.future;
        }
      } catch (e) {
        completer.completeError(
          Failure(
            'Failed to check connectivity${errorContext != null ? ' for $errorContext' : ''}: ${e.toString()}',
            internalErrorCode: ApiInternalErrorCode.unsupported(),
          ),
        );
        return completer.future;
      }
    }

    // Set timeout timer
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

    // Execute the API call
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
            _handleError(error, errorContext, completer);
          }
        });

    return completer.future;
  }

  /// Handles different types of errors and converts them to Failure objects
  static void _handleError<T>(
    dynamic error,
    String? errorContext,
    Completer<T> completer,
  ) {
    if (error is Failure) {
      completer.completeError(error);
      return;
    }

    if (error is DioException) {
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
      Failure(message, internalErrorCode: ApiInternalErrorCode.unsupported()),
    );
  }
}
