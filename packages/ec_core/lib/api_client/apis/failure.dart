import 'package:equatable/equatable.dart';
import 'api_internal_error_code.dart';
import 'api_client_error.dart';

class Failure<T> extends Equatable {
  const Failure(
    this.message, {
    this.noConnectionData,
    this.internalErrorCode,
    this.apiClientError,
  });
  
  final String message;
  final T? noConnectionData;
  final ApiInternalErrorCode? internalErrorCode;
  final ApiClientError? apiClientError;

  /// Create a failure from an API client error
  factory Failure.fromApiClientError(ApiClientError error) {
    return Failure<T>(
      error.toString(),
      apiClientError: error,
      internalErrorCode: _extractInternalErrorCode(error),
    );
  }

  /// Create a failure from an exception
  factory Failure.fromException(Exception exception) {
    if (exception is Failure) {
      // Cast to the same generic type
      final failure = exception as Failure;
      return Failure<T>(
        failure.message,
        noConnectionData: failure.noConnectionData,
        internalErrorCode: failure.internalErrorCode,
        apiClientError: failure.apiClientError,
      );
    }
    
    return Failure<T>(
      exception.toString(),
      internalErrorCode: ApiInternalErrorCode.unsupported(),
    );
  }

  /// Extract internal error code from API client error
  static ApiInternalErrorCode? _extractInternalErrorCode(ApiClientError error) {
    return error.maybeWhen(
      authGeneral: (_, __, ___) => ApiInternalErrorCode.authGeneral(),
      authNonActiveUserError: (_, __, ___) => ApiInternalErrorCode.authNonActiveUserError(),
      authDoNotHavePermissions: (_, __, ___) => ApiInternalErrorCode.authDoNotHavePermissions(),
      authFailed: (_, __, ___) => ApiInternalErrorCode.authFailed(),
      orElse: () => ApiInternalErrorCode.unsupported(),
    );
  }

  /// Check if this is an authentication error
  bool get isAuthError => internalErrorCode != null && 
    (internalErrorCode!.maybeWhen(
      authGeneral: () => true,
      authNonActiveUserError: () => true,
      authDoNotHavePermissions: () => true,
      authFailed: () => true,
      orElse: () => false,
    ));

  /// Check if this is a network error
  bool get isNetworkError => apiClientError != null && 
    (apiClientError!.maybeWhen(
      noInternetConnection: (_, __, ___) => true,
      requestTimeout: (_, __, ___) => true,
      sendTimeout: (_, __, ___) => true,
      orElse: () => false,
    ));

  /// Check if this is a server error
  bool get isServerError => apiClientError != null && 
    (apiClientError!.maybeWhen(
      internalServerError: (_, __, ___) => true,
      serviceUnavailable: (_, __, ___) => true,
      notImplemented: (_, __, ___) => true,
      orElse: () => false,
    ));

  @override
  List<Object> get props => [
        message,
        if (noConnectionData != null) noConnectionData!,
        if (internalErrorCode != null) internalErrorCode!,
        if (apiClientError != null) apiClientError!,
      ];

  @override
  String toString() => message;
}
