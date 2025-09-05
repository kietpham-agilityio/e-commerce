// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'api_internal_error_code.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_client_error.freezed.dart';

///
/// Model for mapping backend api error response
///

class ApiBackendError {
  ApiBackendError({required this.message, required this.code});
  factory ApiBackendError.fromJson(String source) =>
      ApiBackendError.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ApiBackendError.fromMap(Map<String, dynamic> map) {
    return ApiBackendError(
      message: map['message'] as String,
      code: map['code'] is String ? map['code'] as String : '${map['code']}',
    );
  }
  final String message;
  final String code;

  ApiBackendError copyWith({String? message, String? code}) {
    return ApiBackendError(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'message': message, 'code': code};
  }

  String toJson() => json.encode(toMap());
}

@freezed
class ApiClientError with _$ApiClientError {
  const factory ApiClientError.userNotFound(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = UserNotFound;

  const factory ApiClientError.requestCancelled(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = RequestCancelled;

  const factory ApiClientError.unauthorizedRequest(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = UnauthorizedRequest;

  const factory ApiClientError.forbiddenRequest(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = ForbiddenRequest;

  const factory ApiClientError.badRequest(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = BadRequest;

  const factory ApiClientError.notFound(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = NotFound;

  const factory ApiClientError.methodNotAllowed(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = MethodNotAllowed;

  const factory ApiClientError.notAcceptable(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = NotAcceptable;

  const factory ApiClientError.requestTimeout(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = RequestTimeout;

  const factory ApiClientError.sendTimeout(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = SendTimeout;

  const factory ApiClientError.conflict(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = Conflict;

  const factory ApiClientError.internalServerError(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = InternalServerError;

  const factory ApiClientError.notImplemented(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = NotImplemented;

  const factory ApiClientError.serviceUnavailable(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = ServiceUnavailable;

  const factory ApiClientError.noInternetConnection(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = NoInternetConnection;

  const factory ApiClientError.formatException(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = FormatException;

  const factory ApiClientError.unableToProcess(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = UnableToProcess;

  const factory ApiClientError.defaultError(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = DefaultError;

  const factory ApiClientError.unexpectedError(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = UnexpectedError;

  const factory ApiClientError.badResponseMapping(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = BadResponseMappingError;

  const factory ApiClientError.pdfUnableGenerate(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = PdfUnableGenerate;
  const factory ApiClientError.authGeneral(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = AuthGeneralError;

  const factory ApiClientError.authNonActiveUserError(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = AuthNonActiveUserError;

  const factory ApiClientError.authDoNotHavePermissions(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = AuthDoNotHavePermissionsError;

  const factory ApiClientError.authFailed(
    Object originalError,
    ApiBackendError? developerResponseError, {
    StackTrace? stackTrace,
  }) = AuthFailedError;

  static ApiClientError handleResponse(DioException error, Response? response) {
    ApiBackendError? developerResponseError;
    if (error.response?.data is Map &&
        (error.response!.data as Map).containsKey('message')) {
      final mapError = <String, String>{};

      mapError['message'] = (error.response?.data as Map)['message'] as String;
      mapError['code'] =
          error.response?.statusMessage ??
          (error.response?.data as Map)['message'] as String;

      developerResponseError = ApiBackendError.fromMap(mapError);
    } else if (error.response?.data is Map &&
        (error.response!.data as Map).containsKey('errors')) {
      developerResponseError = ApiBackendError.fromMap(
        (error.response!.data as Map<String, dynamic>)['errors']
            as Map<String, dynamic>,
      );
    } else if (error.response?.data is String) {
      final data =
          json.decode(error.response?.data as String) as Map<String, dynamic>;
      final mapError = <String, String>{};

      mapError['message'] = data['message'] as String;
      mapError['code'] = data['message'] as String;

      developerResponseError = ApiBackendError.fromMap(mapError);
    } else if (error.response?.data is Uint8List) {
      // Check if the response contains PDF bytes data or not (API might
      // return raw bytes instead of JSON)
      final content = String.fromCharCodes(error.response?.data);
      final errorMessage = getErrorFromJsonString(content);

      final mapError = <String, String>{};

      mapError['message'] = errorMessage;
      mapError['code'] = errorMessage;

      developerResponseError = ApiBackendError.fromMap(mapError);
    }

    final internalErrorCode = ApiInternalErrorCode.fromInternalErrorMessage(
      developerResponseError?.message.split(':')[0],
    );

    if (internalErrorCode == null) {
      return ApiClientError.unexpectedError(error, developerResponseError);
    }

    return internalErrorCode.maybeWhen(
      authGeneral:
          () => ApiClientError.authGeneral(error, developerResponseError),
      authNonActiveUserError:
          () => ApiClientError.authNonActiveUserError(
            error,
            developerResponseError,
          ),
      authDoNotHavePermissions:
          () => ApiClientError.authDoNotHavePermissions(
            error,
            developerResponseError,
          ),
      authFailed:
          () => ApiClientError.authFailed(error, developerResponseError),

      // Default error
      orElse: () => ApiClientError.defaultError(error, developerResponseError),
    );
  }

  static String getErrorFromJsonString(String jsonString) {
    try {
      // Attempt to decode the string to a List
      final res = jsonDecode(jsonString);

      // Check if the first item in the list contains 'message'
      if (res.isNotEmpty &&
          res is Map<String, dynamic> &&
          res.containsKey('message')) {
        return res['message'];
      } else {
        return 'Something went wrong';
      }
    } on Exception catch (e) {
      log('Error decoding JSON: $e');
      // If decoding fails, it means the string is not valid JSON
      return 'Something went wrong';
    }
  }

  static ApiClientError convertApiClientErrorFromError(
    Object error,
    StackTrace stackTrace,
  ) {
    if (error is Exception) {
      try {
        late ApiClientError networkExceptions;

        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = ApiClientError.requestCancelled(error, null);

            case DioExceptionType.connectionTimeout:
              networkExceptions = ApiClientError.requestTimeout(error, null);

            case DioExceptionType.connectionError:
              networkExceptions = ApiClientError.noInternetConnection(
                error,
                null,
              );

            case DioExceptionType.unknown:
            case DioExceptionType.badCertificate:
              networkExceptions = ApiClientError.noInternetConnection(
                error,
                null,
              );

            case DioExceptionType.receiveTimeout:
              networkExceptions = ApiClientError.sendTimeout(error, null);

            case DioExceptionType.badResponse:
              networkExceptions = ApiClientError.handleResponse(
                error,
                error.response,
              );

            case DioExceptionType.sendTimeout:
              networkExceptions = ApiClientError.sendTimeout(error, null);
          }
        } else if (error is SocketException) {
          networkExceptions = ApiClientError.noInternetConnection(error, null);
        } else {
          networkExceptions = ApiClientError.unexpectedError(error, null);
        }

        return networkExceptions;
      } on FormatException {
        return ApiClientError.formatException(error, null);
      } on Exception catch (_) {
        return ApiClientError.unexpectedError(error, null);
      }
    } else {
      final errorString = error.toString();
      if (errorString.contains('is not a subtype of')) {
        return ApiClientError.badResponseMapping(
          error,
          null,
          stackTrace: stackTrace,
        );
      }

      if (errorString.contains('"Null check operator used on"')) {
        return ApiClientError.badResponseMapping(
          error,
          null,
          stackTrace: stackTrace,
        );
      }

      return ApiClientError.unexpectedError(
        error,
        null,
        stackTrace: stackTrace,
      );
    }
  }
}
