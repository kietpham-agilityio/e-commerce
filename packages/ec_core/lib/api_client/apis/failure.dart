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

  /// Create a failure from Supabase error response
  factory Failure.fromSupabaseError(Map<String, dynamic> errorResponse) {
    final code = errorResponse['code'] as String?;
    final message = errorResponse['message'] as String?;

    final internalErrorCode = ApiInternalErrorCode.fromInternalErrorMessage(
      code,
    );

    return Failure<T>(
      message ?? 'Unknown Supabase error',
      internalErrorCode:
          internalErrorCode ?? ApiInternalErrorCode.unsupported(),
    );
  }

  /// Create a failure from HTTP status code
  factory Failure.fromStatusCode(int statusCode, {String? customMessage}) {
    final internalErrorCode = ApiInternalErrorCode.fromStatusCode(statusCode);
    final message =
        customMessage ??
        internalErrorCode?.description ??
        'HTTP Error $statusCode';

    return Failure<T>(
      message,
      internalErrorCode:
          internalErrorCode ?? ApiInternalErrorCode.unsupported(),
    );
  }

  /// Check if this is an authentication error
  bool get isAuthError {
    return internalErrorCode?.when(
          // Supabase auth errors
          invalidJWT: () => true,
          accessDenied: () => true,
          invalidSignature: () => true,
          signatureDoesNotMatch: () => true,
          invalidUploadSignature: () => true,
          s3InvalidAccessKeyId: () => true,
          // Legacy auth errors
          authGeneral: () => true,
          authNonActiveUserError: () => true,
          authDoNotHavePermissions: () => true,
          authFailed: () => true,
          // Admin access errors
          adminAccessDenied: () => true,
          // All other errors
          noSuchBucket: () => false,
          noSuchKey: () => false,
          noSuchUpload: () => false,
          tenantNotFound: () => false,
          invalidRequest: () => false,
          invalidBucketName: () => false,
          invalidKey: () => false,
          invalidMimeType: () => false,
          invalidUploadId: () => false,
          missingParameter: () => false,
          invalidChecksum: () => false,
          missingPart: () => false,
          resourceAlreadyExists: () => false,
          keyAlreadyExists: () => false,
          bucketAlreadyExists: () => false,
          entityTooLarge: () => false,
          invalidRange: () => false,
          missingContentLength: () => false,
          resourceLocked: () => false,
          lockTimeout: () => false,
          tooManyRequests: () => false,
          slowDown: () => false,
          internalError: () => false,
          databaseError: () => false,
          databaseTimeout: () => false,
          gatewayTimeout: () => false,
          s3Error: () => false,
          s3MaximumCredentialsLimit: () => false,
          unsupported: () => false,
        ) ??
        false;
  }

  /// Check if this is a network error
  bool get isNetworkError {
    return internalErrorCode?.when(
          // Network/timeout errors
          databaseTimeout: () => true,
          gatewayTimeout: () => true,
          slowDown: () => true,
          tooManyRequests: () => true,
          // All other errors
          noSuchBucket: () => false,
          noSuchKey: () => false,
          noSuchUpload: () => false,
          tenantNotFound: () => false,
          invalidJWT: () => false,
          invalidRequest: () => false,
          invalidBucketName: () => false,
          invalidKey: () => false,
          invalidMimeType: () => false,
          invalidUploadId: () => false,
          missingParameter: () => false,
          invalidChecksum: () => false,
          missingPart: () => false,
          resourceAlreadyExists: () => false,
          keyAlreadyExists: () => false,
          bucketAlreadyExists: () => false,
          accessDenied: () => false,
          invalidSignature: () => false,
          signatureDoesNotMatch: () => false,
          invalidUploadSignature: () => false,
          s3InvalidAccessKeyId: () => false,
          entityTooLarge: () => false,
          invalidRange: () => false,
          missingContentLength: () => false,
          resourceLocked: () => false,
          lockTimeout: () => false,
          internalError: () => false,
          databaseError: () => false,
          s3Error: () => false,
          s3MaximumCredentialsLimit: () => false,
          authGeneral: () => false,
          authNonActiveUserError: () => false,
          authDoNotHavePermissions: () => false,
          authFailed: () => false,
          adminAccessDenied: () => false,
          unsupported: () => false,
        ) ??
        false;
  }

  /// Check if this is a client error (4xx)
  bool get isClientError {
    final statusCode = internalErrorCode?.statusCode ?? 500;
    return statusCode >= 400 && statusCode < 500;
  }

  /// Check if this is a server error (5xx)
  bool get isServerError {
    final statusCode = internalErrorCode?.statusCode ?? 500;
    return statusCode >= 500;
  }

  /// Get HTTP status code
  int get statusCode {
    return internalErrorCode?.statusCode ?? 500;
  }

  /// Get error code string
  String get errorCode {
    return internalErrorCode?.code ?? 'Unsupported';
  }

  /// Get detailed error description
  String get detailedDescription {
    return internalErrorCode?.description ?? message;
  }

  /// Extract internal error code from API client error
  static ApiInternalErrorCode? _extractInternalErrorCode(ApiClientError error) {
    return error.maybeWhen(
      // Legacy auth errors
      authGeneral: (_, __, ___) => ApiInternalErrorCode.authGeneral(),
      authNonActiveUserError:
          (_, __, ___) => ApiInternalErrorCode.authNonActiveUserError(),
      authDoNotHavePermissions:
          (_, __, ___) => ApiInternalErrorCode.authDoNotHavePermissions(),
      authFailed: (_, __, ___) => ApiInternalErrorCode.authFailed(),
      // All other errors default to unsupported
      orElse: () => ApiInternalErrorCode.unsupported(),
    );
  }

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
