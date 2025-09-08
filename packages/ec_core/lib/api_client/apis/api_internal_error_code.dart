import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_internal_error_code.freezed.dart';

@freezed
class ApiInternalErrorCode with _$ApiInternalErrorCode {
  const ApiInternalErrorCode._();

  // ============================================================================
  // SUPABASE STORAGE ERROR CODES
  // ============================================================================

  // Resource Not Found Errors (404)
  factory ApiInternalErrorCode.noSuchBucket() = _NoSuchBucket;
  factory ApiInternalErrorCode.noSuchKey() = _NoSuchKey;
  factory ApiInternalErrorCode.noSuchUpload() = _NoSuchUpload;
  factory ApiInternalErrorCode.tenantNotFound() = _TenantNotFound;

  // Authentication Errors (401)
  factory ApiInternalErrorCode.invalidJWT() = _InvalidJWT;

  // Bad Request Errors (400)
  factory ApiInternalErrorCode.invalidRequest() = _InvalidRequest;
  factory ApiInternalErrorCode.invalidBucketName() = _InvalidBucketName;
  factory ApiInternalErrorCode.invalidKey() = _InvalidKey;
  factory ApiInternalErrorCode.invalidMimeType() = _InvalidMimeType;
  factory ApiInternalErrorCode.invalidUploadId() = _InvalidUploadId;
  factory ApiInternalErrorCode.missingParameter() = _MissingParameter;
  factory ApiInternalErrorCode.invalidChecksum() = _InvalidChecksum;
  factory ApiInternalErrorCode.missingPart() = _MissingPart;

  // Conflict Errors (409)
  factory ApiInternalErrorCode.resourceAlreadyExists() = _ResourceAlreadyExists;
  factory ApiInternalErrorCode.keyAlreadyExists() = _KeyAlreadyExists;
  factory ApiInternalErrorCode.bucketAlreadyExists() = _BucketAlreadyExists;

  // Forbidden Errors (403)
  factory ApiInternalErrorCode.accessDenied() = _AccessDenied;
  factory ApiInternalErrorCode.invalidSignature() = _InvalidSignature;
  factory ApiInternalErrorCode.signatureDoesNotMatch() = _SignatureDoesNotMatch;
  factory ApiInternalErrorCode.invalidUploadSignature() =
      _InvalidUploadSignature;
  factory ApiInternalErrorCode.s3InvalidAccessKeyId() = _S3InvalidAccessKeyId;

  // Payload Too Large (413)
  factory ApiInternalErrorCode.entityTooLarge() = _EntityTooLarge;

  // Range Not Satisfiable (416)
  factory ApiInternalErrorCode.invalidRange() = _InvalidRange;

  // Length Required (411)
  factory ApiInternalErrorCode.missingContentLength() = _MissingContentLength;

  // Locked (423)
  factory ApiInternalErrorCode.resourceLocked() = _ResourceLocked;
  factory ApiInternalErrorCode.lockTimeout() = _LockTimeout;

  // Too Many Requests (429)
  factory ApiInternalErrorCode.tooManyRequests() = _TooManyRequests;

  // Service Unavailable (503)
  factory ApiInternalErrorCode.slowDown() = _SlowDown;

  // Internal Server Errors (500)
  factory ApiInternalErrorCode.internalError() = _InternalError;
  factory ApiInternalErrorCode.databaseError() = _DatabaseError;
  factory ApiInternalErrorCode.databaseTimeout() = _DatabaseTimeout;

  // Gateway Timeout (504)
  factory ApiInternalErrorCode.gatewayTimeout() = _GatewayTimeout;

  // S3 Related Errors
  factory ApiInternalErrorCode.s3Error() = _S3Error;
  factory ApiInternalErrorCode.s3MaximumCredentialsLimit() =
      _S3MaximumCredentialsLimit;

  // Legacy Auth Errors (for backward compatibility)
  factory ApiInternalErrorCode.authGeneral() = _ApiInternalErrorCodeAuthGeneral;
  factory ApiInternalErrorCode.authNonActiveUserError() =
      _ApiInternalErrorCodeAuthNonActiveUserError;
  factory ApiInternalErrorCode.authDoNotHavePermissions() =
      _ApiInternalErrorCodeAuthDoNotHavePermissions;
  factory ApiInternalErrorCode.authFailed() = _ApiInternalErrorCodeAuthFailed;
  factory ApiInternalErrorCode.unsupported() = _ApiInternalErrorCodeUnSupported;

  /// Get HTTP status code for this error
  int get statusCode {
    return when(
      // 404 Not Found
      noSuchBucket: () => 404,
      noSuchKey: () => 404,
      noSuchUpload: () => 404,
      tenantNotFound: () => 404,

      // 401 Unauthorized
      invalidJWT: () => 401,

      // 400 Bad Request
      invalidRequest: () => 400,
      invalidBucketName: () => 400,
      invalidKey: () => 400,
      invalidMimeType: () => 400,
      invalidUploadId: () => 400,
      missingParameter: () => 400,
      invalidChecksum: () => 400,
      missingPart: () => 400,
      s3MaximumCredentialsLimit: () => 400,

      // 409 Conflict
      resourceAlreadyExists: () => 409,
      keyAlreadyExists: () => 409,
      bucketAlreadyExists: () => 409,

      // 403 Forbidden
      accessDenied: () => 403,
      invalidSignature: () => 403,
      signatureDoesNotMatch: () => 403,
      invalidUploadSignature: () => 403,
      s3InvalidAccessKeyId: () => 403,

      // 413 Payload Too Large
      entityTooLarge: () => 413,

      // 416 Range Not Satisfiable
      invalidRange: () => 416,

      // 411 Length Required
      missingContentLength: () => 411,

      // 423 Locked
      resourceLocked: () => 423,
      lockTimeout: () => 423,

      // 429 Too Many Requests
      tooManyRequests: () => 429,

      // 503 Service Unavailable
      slowDown: () => 503,

      // 500 Internal Server Error
      internalError: () => 500,
      databaseError: () => 500,

      // 504 Gateway Timeout
      databaseTimeout: () => 504,
      gatewayTimeout: () => 504,

      // S3 Error (varies)
      s3Error: () => 500,

      // Legacy auth errors
      authGeneral: () => 401,
      authNonActiveUserError: () => 401,
      authDoNotHavePermissions: () => 403,
      authFailed: () => 401,
      unsupported: () => 500,
    );
  }

  /// Get error code string
  String get code {
    return when(
      noSuchBucket: () => 'NoSuchBucket',
      noSuchKey: () => 'NoSuchKey',
      noSuchUpload: () => 'NoSuchUpload',
      tenantNotFound: () => 'TenantNotFound',
      invalidJWT: () => 'InvalidJWT',
      invalidRequest: () => 'InvalidRequest',
      invalidBucketName: () => 'InvalidBucketName',
      invalidKey: () => 'InvalidKey',
      invalidMimeType: () => 'InvalidMimeType',
      invalidUploadId: () => 'InvalidUploadId',
      missingParameter: () => 'MissingParameter',
      invalidChecksum: () => 'InvalidChecksum',
      missingPart: () => 'MissingPart',
      resourceAlreadyExists: () => 'ResourceAlreadyExists',
      keyAlreadyExists: () => 'KeyAlreadyExists',
      bucketAlreadyExists: () => 'BucketAlreadyExists',
      accessDenied: () => 'AccessDenied',
      invalidSignature: () => 'InvalidSignature',
      signatureDoesNotMatch: () => 'SignatureDoesNotMatch',
      invalidUploadSignature: () => 'InvalidUploadSignature',
      s3InvalidAccessKeyId: () => 'S3InvalidAccessKeyId',
      entityTooLarge: () => 'EntityTooLarge',
      invalidRange: () => 'InvalidRange',
      missingContentLength: () => 'MissingContentLength',
      resourceLocked: () => 'ResourceLocked',
      lockTimeout: () => 'LockTimeout',
      tooManyRequests: () => 'TooManyRequests',
      slowDown: () => 'SlowDown',
      internalError: () => 'InternalError',
      databaseError: () => 'DatabaseError',
      databaseTimeout: () => 'DatabaseTimeout',
      gatewayTimeout: () => 'GatewayTimeout',
      s3Error: () => 'S3Error',
      s3MaximumCredentialsLimit: () => 'S3MaximumCredentialsLimit',
      authGeneral: () => 'AuthGeneral',
      authNonActiveUserError: () => 'AuthNonActiveUserError',
      authDoNotHavePermissions: () => 'AuthDoNotHavePermissions',
      authFailed: () => 'AuthFailed',
      unsupported: () => 'Unsupported',
    );
  }

  /// Get human-readable description
  String get description {
    return when(
      noSuchBucket: () => 'The specified bucket does not exist.',
      noSuchKey: () => 'The specified key does not exist.',
      noSuchUpload: () => 'The specified upload does not exist.',
      tenantNotFound: () => 'The specified tenant does not exist.',
      invalidJWT: () => 'The provided JWT (JSON Web Token) is invalid.',
      invalidRequest: () => 'The request is not properly formed.',
      invalidBucketName: () => 'The specified bucket name is invalid.',
      invalidKey: () => 'The specified key is invalid.',
      invalidMimeType: () => 'The specified MIME type is not valid.',
      invalidUploadId: () => 'The specified upload ID is invalid.',
      missingParameter: () => 'A required parameter is missing in the request.',
      invalidChecksum: () => 'The checksum of the entity does not match.',
      missingPart: () => 'A part of the entity is missing.',
      resourceAlreadyExists: () => 'The specified resource already exists.',
      keyAlreadyExists: () => 'The specified key already exists.',
      bucketAlreadyExists: () => 'The specified bucket already exists.',
      accessDenied: () => 'Access to the specified resource is denied.',
      invalidSignature:
          () =>
              'The signature provided does not match the calculated signature.',
      signatureDoesNotMatch:
          () =>
              'The request signature does not match the calculated signature.',
      invalidUploadSignature: () => 'The provided upload signature is invalid.',
      s3InvalidAccessKeyId: () => 'The provided AWS access key ID is invalid.',
      entityTooLarge: () => 'The entity being uploaded is too large.',
      invalidRange: () => 'The specified range is not valid.',
      missingContentLength: () => 'The Content-Length header is missing.',
      resourceLocked: () => 'The specified resource is locked.',
      lockTimeout: () => 'Timeout occurred while waiting for a lock.',
      tooManyRequests: () => 'Too many requests have been made.',
      slowDown: () => 'The request rate is too high and has been throttled.',
      internalError: () => 'An internal server error occurred.',
      databaseError: () => 'An error occurred while accessing the database.',
      databaseTimeout: () => 'Timeout occurred while accessing the database.',
      gatewayTimeout: () => 'Gateway timeout occurred.',
      s3Error: () => 'An error occurred related to Amazon S3.',
      s3MaximumCredentialsLimit:
          () => 'The maximum number of credentials has been reached.',
      authGeneral: () => 'General authentication error.',
      authNonActiveUserError: () => 'User account is not active.',
      authDoNotHavePermissions:
          () => 'User does not have required permissions.',
      authFailed: () => 'Authentication failed.',
      unsupported: () => 'Unsupported error type.',
    );
  }

  static ApiInternalErrorCode? fromInternalErrorMessage(String? code) {
    final codes = {
      // Supabase Storage Error Codes
      'NoSuchBucket': ApiInternalErrorCode.noSuchBucket(),
      'NoSuchKey': ApiInternalErrorCode.noSuchKey(),
      'NoSuchUpload': ApiInternalErrorCode.noSuchUpload(),
      'TenantNotFound': ApiInternalErrorCode.tenantNotFound(),
      'InvalidJWT': ApiInternalErrorCode.invalidJWT(),
      'InvalidRequest': ApiInternalErrorCode.invalidRequest(),
      'InvalidBucketName': ApiInternalErrorCode.invalidBucketName(),
      'InvalidKey': ApiInternalErrorCode.invalidKey(),
      'InvalidMimeType': ApiInternalErrorCode.invalidMimeType(),
      'InvalidUploadId': ApiInternalErrorCode.invalidUploadId(),
      'MissingParameter': ApiInternalErrorCode.missingParameter(),
      'InvalidChecksum': ApiInternalErrorCode.invalidChecksum(),
      'MissingPart': ApiInternalErrorCode.missingPart(),
      'ResourceAlreadyExists': ApiInternalErrorCode.resourceAlreadyExists(),
      'KeyAlreadyExists': ApiInternalErrorCode.keyAlreadyExists(),
      'BucketAlreadyExists': ApiInternalErrorCode.bucketAlreadyExists(),
      'AccessDenied': ApiInternalErrorCode.accessDenied(),
      'InvalidSignature': ApiInternalErrorCode.invalidSignature(),
      'SignatureDoesNotMatch': ApiInternalErrorCode.signatureDoesNotMatch(),
      'InvalidUploadSignature': ApiInternalErrorCode.invalidUploadSignature(),
      'S3InvalidAccessKeyId': ApiInternalErrorCode.s3InvalidAccessKeyId(),
      'EntityTooLarge': ApiInternalErrorCode.entityTooLarge(),
      'InvalidRange': ApiInternalErrorCode.invalidRange(),
      'MissingContentLength': ApiInternalErrorCode.missingContentLength(),
      'ResourceLocked': ApiInternalErrorCode.resourceLocked(),
      'LockTimeout': ApiInternalErrorCode.lockTimeout(),
      'TooManyRequests': ApiInternalErrorCode.tooManyRequests(),
      'SlowDown': ApiInternalErrorCode.slowDown(),
      'InternalError': ApiInternalErrorCode.internalError(),
      'DatabaseError': ApiInternalErrorCode.databaseError(),
      'DatabaseTimeout': ApiInternalErrorCode.databaseTimeout(),
      'GatewayTimeout': ApiInternalErrorCode.gatewayTimeout(),
      'S3Error': ApiInternalErrorCode.s3Error(),
      'S3MaximumCredentialsLimit':
          ApiInternalErrorCode.s3MaximumCredentialsLimit(),
    };

    return codes[code];
  }

  /// Create error code from HTTP status code
  static ApiInternalErrorCode? fromStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return ApiInternalErrorCode.invalidRequest();
      case 401:
        return ApiInternalErrorCode.invalidJWT();
      case 403:
        return ApiInternalErrorCode.accessDenied();
      case 404:
        return ApiInternalErrorCode.noSuchKey();
      case 409:
        return ApiInternalErrorCode.resourceAlreadyExists();
      case 411:
        return ApiInternalErrorCode.missingContentLength();
      case 413:
        return ApiInternalErrorCode.entityTooLarge();
      case 416:
        return ApiInternalErrorCode.invalidRange();
      case 423:
        return ApiInternalErrorCode.resourceLocked();
      case 429:
        return ApiInternalErrorCode.tooManyRequests();
      case 500:
        return ApiInternalErrorCode.internalError();
      case 503:
        return ApiInternalErrorCode.slowDown();
      case 504:
        return ApiInternalErrorCode.databaseTimeout();
      default:
        return ApiInternalErrorCode.unsupported();
    }
  }
}
