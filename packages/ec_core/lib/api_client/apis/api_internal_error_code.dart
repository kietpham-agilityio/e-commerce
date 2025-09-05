import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_internal_error_code.freezed.dart';

@freezed
class ApiInternalErrorCode with _$ApiInternalErrorCode {
  const ApiInternalErrorCode._();

  factory ApiInternalErrorCode.authGeneral() = _ApiInternalErrorCodeAuthGeneral;
  factory ApiInternalErrorCode.authNonActiveUserError() =
      _ApiInternalErrorCodeAuthNonActiveUserError;
  factory ApiInternalErrorCode.authDoNotHavePermissions() =
      _ApiInternalErrorCodeAuthDoNotHavePermissions;
  factory ApiInternalErrorCode.authFailed() = _ApiInternalErrorCodeAuthFailed;
  factory ApiInternalErrorCode.unsupported() = _ApiInternalErrorCodeUnSupported;

  static ApiInternalErrorCode? fromInternalErrorMessage(String? code) {
    final codes = {
      'E101': ApiInternalErrorCode.authGeneral(),
      'E102': ApiInternalErrorCode.authGeneral(),
      'E103': ApiInternalErrorCode.authGeneral(),
      'E104': ApiInternalErrorCode.authGeneral(),
      'E105': ApiInternalErrorCode.authNonActiveUserError(),
      'E106': ApiInternalErrorCode.authDoNotHavePermissions(),
      'E107': ApiInternalErrorCode.authGeneral(),
    };

    return codes[code];
  }
}
