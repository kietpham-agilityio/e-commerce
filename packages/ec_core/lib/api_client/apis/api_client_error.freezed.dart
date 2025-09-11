// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_client_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiClientError {

 Object get originalError; ApiBackendError? get developerResponseError; StackTrace? get stackTrace;
/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiClientErrorCopyWith<ApiClientError> get copyWith => _$ApiClientErrorCopyWithImpl<ApiClientError>(this as ApiClientError, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiClientError&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $ApiClientErrorCopyWith<$Res>  {
  factory $ApiClientErrorCopyWith(ApiClientError value, $Res Function(ApiClientError) _then) = _$ApiClientErrorCopyWithImpl;
@useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$ApiClientErrorCopyWithImpl<$Res>
    implements $ApiClientErrorCopyWith<$Res> {
  _$ApiClientErrorCopyWithImpl(this._self, this._then);

  final ApiClientError _self;
  final $Res Function(ApiClientError) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(_self.copyWith(
originalError: null == originalError ? _self.originalError : originalError ,developerResponseError: freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiClientError].
extension ApiClientErrorPatterns on ApiClientError {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserNotFound value)?  userNotFound,TResult Function( RequestCancelled value)?  requestCancelled,TResult Function( UnauthorizedRequest value)?  unauthorizedRequest,TResult Function( ForbiddenRequest value)?  forbiddenRequest,TResult Function( BadRequest value)?  badRequest,TResult Function( NotFound value)?  notFound,TResult Function( MethodNotAllowed value)?  methodNotAllowed,TResult Function( NotAcceptable value)?  notAcceptable,TResult Function( RequestTimeout value)?  requestTimeout,TResult Function( SendTimeout value)?  sendTimeout,TResult Function( Conflict value)?  conflict,TResult Function( InternalServerError value)?  internalServerError,TResult Function( NotImplemented value)?  notImplemented,TResult Function( ServiceUnavailable value)?  serviceUnavailable,TResult Function( NoInternetConnection value)?  noInternetConnection,TResult Function( FormatException value)?  formatException,TResult Function( UnableToProcess value)?  unableToProcess,TResult Function( DefaultError value)?  defaultError,TResult Function( UnexpectedError value)?  unexpectedError,TResult Function( BadResponseMappingError value)?  badResponseMapping,TResult Function( PdfUnableGenerate value)?  pdfUnableGenerate,TResult Function( AuthGeneralError value)?  authGeneral,TResult Function( AuthNonActiveUserError value)?  authNonActiveUserError,TResult Function( AuthDoNotHavePermissionsError value)?  authDoNotHavePermissions,TResult Function( AuthFailedError value)?  authFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserNotFound() when userNotFound != null:
return userNotFound(_that);case RequestCancelled() when requestCancelled != null:
return requestCancelled(_that);case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest(_that);case ForbiddenRequest() when forbiddenRequest != null:
return forbiddenRequest(_that);case BadRequest() when badRequest != null:
return badRequest(_that);case NotFound() when notFound != null:
return notFound(_that);case MethodNotAllowed() when methodNotAllowed != null:
return methodNotAllowed(_that);case NotAcceptable() when notAcceptable != null:
return notAcceptable(_that);case RequestTimeout() when requestTimeout != null:
return requestTimeout(_that);case SendTimeout() when sendTimeout != null:
return sendTimeout(_that);case Conflict() when conflict != null:
return conflict(_that);case InternalServerError() when internalServerError != null:
return internalServerError(_that);case NotImplemented() when notImplemented != null:
return notImplemented(_that);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that);case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection(_that);case FormatException() when formatException != null:
return formatException(_that);case UnableToProcess() when unableToProcess != null:
return unableToProcess(_that);case DefaultError() when defaultError != null:
return defaultError(_that);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that);case BadResponseMappingError() when badResponseMapping != null:
return badResponseMapping(_that);case PdfUnableGenerate() when pdfUnableGenerate != null:
return pdfUnableGenerate(_that);case AuthGeneralError() when authGeneral != null:
return authGeneral(_that);case AuthNonActiveUserError() when authNonActiveUserError != null:
return authNonActiveUserError(_that);case AuthDoNotHavePermissionsError() when authDoNotHavePermissions != null:
return authDoNotHavePermissions(_that);case AuthFailedError() when authFailed != null:
return authFailed(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserNotFound value)  userNotFound,required TResult Function( RequestCancelled value)  requestCancelled,required TResult Function( UnauthorizedRequest value)  unauthorizedRequest,required TResult Function( ForbiddenRequest value)  forbiddenRequest,required TResult Function( BadRequest value)  badRequest,required TResult Function( NotFound value)  notFound,required TResult Function( MethodNotAllowed value)  methodNotAllowed,required TResult Function( NotAcceptable value)  notAcceptable,required TResult Function( RequestTimeout value)  requestTimeout,required TResult Function( SendTimeout value)  sendTimeout,required TResult Function( Conflict value)  conflict,required TResult Function( InternalServerError value)  internalServerError,required TResult Function( NotImplemented value)  notImplemented,required TResult Function( ServiceUnavailable value)  serviceUnavailable,required TResult Function( NoInternetConnection value)  noInternetConnection,required TResult Function( FormatException value)  formatException,required TResult Function( UnableToProcess value)  unableToProcess,required TResult Function( DefaultError value)  defaultError,required TResult Function( UnexpectedError value)  unexpectedError,required TResult Function( BadResponseMappingError value)  badResponseMapping,required TResult Function( PdfUnableGenerate value)  pdfUnableGenerate,required TResult Function( AuthGeneralError value)  authGeneral,required TResult Function( AuthNonActiveUserError value)  authNonActiveUserError,required TResult Function( AuthDoNotHavePermissionsError value)  authDoNotHavePermissions,required TResult Function( AuthFailedError value)  authFailed,}){
final _that = this;
switch (_that) {
case UserNotFound():
return userNotFound(_that);case RequestCancelled():
return requestCancelled(_that);case UnauthorizedRequest():
return unauthorizedRequest(_that);case ForbiddenRequest():
return forbiddenRequest(_that);case BadRequest():
return badRequest(_that);case NotFound():
return notFound(_that);case MethodNotAllowed():
return methodNotAllowed(_that);case NotAcceptable():
return notAcceptable(_that);case RequestTimeout():
return requestTimeout(_that);case SendTimeout():
return sendTimeout(_that);case Conflict():
return conflict(_that);case InternalServerError():
return internalServerError(_that);case NotImplemented():
return notImplemented(_that);case ServiceUnavailable():
return serviceUnavailable(_that);case NoInternetConnection():
return noInternetConnection(_that);case FormatException():
return formatException(_that);case UnableToProcess():
return unableToProcess(_that);case DefaultError():
return defaultError(_that);case UnexpectedError():
return unexpectedError(_that);case BadResponseMappingError():
return badResponseMapping(_that);case PdfUnableGenerate():
return pdfUnableGenerate(_that);case AuthGeneralError():
return authGeneral(_that);case AuthNonActiveUserError():
return authNonActiveUserError(_that);case AuthDoNotHavePermissionsError():
return authDoNotHavePermissions(_that);case AuthFailedError():
return authFailed(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserNotFound value)?  userNotFound,TResult? Function( RequestCancelled value)?  requestCancelled,TResult? Function( UnauthorizedRequest value)?  unauthorizedRequest,TResult? Function( ForbiddenRequest value)?  forbiddenRequest,TResult? Function( BadRequest value)?  badRequest,TResult? Function( NotFound value)?  notFound,TResult? Function( MethodNotAllowed value)?  methodNotAllowed,TResult? Function( NotAcceptable value)?  notAcceptable,TResult? Function( RequestTimeout value)?  requestTimeout,TResult? Function( SendTimeout value)?  sendTimeout,TResult? Function( Conflict value)?  conflict,TResult? Function( InternalServerError value)?  internalServerError,TResult? Function( NotImplemented value)?  notImplemented,TResult? Function( ServiceUnavailable value)?  serviceUnavailable,TResult? Function( NoInternetConnection value)?  noInternetConnection,TResult? Function( FormatException value)?  formatException,TResult? Function( UnableToProcess value)?  unableToProcess,TResult? Function( DefaultError value)?  defaultError,TResult? Function( UnexpectedError value)?  unexpectedError,TResult? Function( BadResponseMappingError value)?  badResponseMapping,TResult? Function( PdfUnableGenerate value)?  pdfUnableGenerate,TResult? Function( AuthGeneralError value)?  authGeneral,TResult? Function( AuthNonActiveUserError value)?  authNonActiveUserError,TResult? Function( AuthDoNotHavePermissionsError value)?  authDoNotHavePermissions,TResult? Function( AuthFailedError value)?  authFailed,}){
final _that = this;
switch (_that) {
case UserNotFound() when userNotFound != null:
return userNotFound(_that);case RequestCancelled() when requestCancelled != null:
return requestCancelled(_that);case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest(_that);case ForbiddenRequest() when forbiddenRequest != null:
return forbiddenRequest(_that);case BadRequest() when badRequest != null:
return badRequest(_that);case NotFound() when notFound != null:
return notFound(_that);case MethodNotAllowed() when methodNotAllowed != null:
return methodNotAllowed(_that);case NotAcceptable() when notAcceptable != null:
return notAcceptable(_that);case RequestTimeout() when requestTimeout != null:
return requestTimeout(_that);case SendTimeout() when sendTimeout != null:
return sendTimeout(_that);case Conflict() when conflict != null:
return conflict(_that);case InternalServerError() when internalServerError != null:
return internalServerError(_that);case NotImplemented() when notImplemented != null:
return notImplemented(_that);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that);case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection(_that);case FormatException() when formatException != null:
return formatException(_that);case UnableToProcess() when unableToProcess != null:
return unableToProcess(_that);case DefaultError() when defaultError != null:
return defaultError(_that);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that);case BadResponseMappingError() when badResponseMapping != null:
return badResponseMapping(_that);case PdfUnableGenerate() when pdfUnableGenerate != null:
return pdfUnableGenerate(_that);case AuthGeneralError() when authGeneral != null:
return authGeneral(_that);case AuthNonActiveUserError() when authNonActiveUserError != null:
return authNonActiveUserError(_that);case AuthDoNotHavePermissionsError() when authDoNotHavePermissions != null:
return authDoNotHavePermissions(_that);case AuthFailedError() when authFailed != null:
return authFailed(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  userNotFound,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  requestCancelled,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  unauthorizedRequest,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  forbiddenRequest,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  badRequest,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  notFound,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  methodNotAllowed,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  notAcceptable,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  requestTimeout,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  sendTimeout,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  conflict,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  internalServerError,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  notImplemented,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  serviceUnavailable,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  noInternetConnection,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  formatException,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  unableToProcess,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  defaultError,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  unexpectedError,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  badResponseMapping,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  pdfUnableGenerate,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  authGeneral,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  authNonActiveUserError,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  authDoNotHavePermissions,TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  authFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserNotFound() when userNotFound != null:
return userNotFound(_that.originalError,_that.developerResponseError,_that.stackTrace);case RequestCancelled() when requestCancelled != null:
return requestCancelled(_that.originalError,_that.developerResponseError,_that.stackTrace);case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest(_that.originalError,_that.developerResponseError,_that.stackTrace);case ForbiddenRequest() when forbiddenRequest != null:
return forbiddenRequest(_that.originalError,_that.developerResponseError,_that.stackTrace);case BadRequest() when badRequest != null:
return badRequest(_that.originalError,_that.developerResponseError,_that.stackTrace);case NotFound() when notFound != null:
return notFound(_that.originalError,_that.developerResponseError,_that.stackTrace);case MethodNotAllowed() when methodNotAllowed != null:
return methodNotAllowed(_that.originalError,_that.developerResponseError,_that.stackTrace);case NotAcceptable() when notAcceptable != null:
return notAcceptable(_that.originalError,_that.developerResponseError,_that.stackTrace);case RequestTimeout() when requestTimeout != null:
return requestTimeout(_that.originalError,_that.developerResponseError,_that.stackTrace);case SendTimeout() when sendTimeout != null:
return sendTimeout(_that.originalError,_that.developerResponseError,_that.stackTrace);case Conflict() when conflict != null:
return conflict(_that.originalError,_that.developerResponseError,_that.stackTrace);case InternalServerError() when internalServerError != null:
return internalServerError(_that.originalError,_that.developerResponseError,_that.stackTrace);case NotImplemented() when notImplemented != null:
return notImplemented(_that.originalError,_that.developerResponseError,_that.stackTrace);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that.originalError,_that.developerResponseError,_that.stackTrace);case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection(_that.originalError,_that.developerResponseError,_that.stackTrace);case FormatException() when formatException != null:
return formatException(_that.originalError,_that.developerResponseError,_that.stackTrace);case UnableToProcess() when unableToProcess != null:
return unableToProcess(_that.originalError,_that.developerResponseError,_that.stackTrace);case DefaultError() when defaultError != null:
return defaultError(_that.originalError,_that.developerResponseError,_that.stackTrace);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that.originalError,_that.developerResponseError,_that.stackTrace);case BadResponseMappingError() when badResponseMapping != null:
return badResponseMapping(_that.originalError,_that.developerResponseError,_that.stackTrace);case PdfUnableGenerate() when pdfUnableGenerate != null:
return pdfUnableGenerate(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthGeneralError() when authGeneral != null:
return authGeneral(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthNonActiveUserError() when authNonActiveUserError != null:
return authNonActiveUserError(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthDoNotHavePermissionsError() when authDoNotHavePermissions != null:
return authDoNotHavePermissions(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthFailedError() when authFailed != null:
return authFailed(_that.originalError,_that.developerResponseError,_that.stackTrace);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  userNotFound,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  requestCancelled,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  unauthorizedRequest,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  forbiddenRequest,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  badRequest,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  notFound,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  methodNotAllowed,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  notAcceptable,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  requestTimeout,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  sendTimeout,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  conflict,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  internalServerError,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  notImplemented,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  serviceUnavailable,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  noInternetConnection,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  formatException,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  unableToProcess,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  defaultError,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  unexpectedError,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  badResponseMapping,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  pdfUnableGenerate,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  authGeneral,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  authNonActiveUserError,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  authDoNotHavePermissions,required TResult Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)  authFailed,}) {final _that = this;
switch (_that) {
case UserNotFound():
return userNotFound(_that.originalError,_that.developerResponseError,_that.stackTrace);case RequestCancelled():
return requestCancelled(_that.originalError,_that.developerResponseError,_that.stackTrace);case UnauthorizedRequest():
return unauthorizedRequest(_that.originalError,_that.developerResponseError,_that.stackTrace);case ForbiddenRequest():
return forbiddenRequest(_that.originalError,_that.developerResponseError,_that.stackTrace);case BadRequest():
return badRequest(_that.originalError,_that.developerResponseError,_that.stackTrace);case NotFound():
return notFound(_that.originalError,_that.developerResponseError,_that.stackTrace);case MethodNotAllowed():
return methodNotAllowed(_that.originalError,_that.developerResponseError,_that.stackTrace);case NotAcceptable():
return notAcceptable(_that.originalError,_that.developerResponseError,_that.stackTrace);case RequestTimeout():
return requestTimeout(_that.originalError,_that.developerResponseError,_that.stackTrace);case SendTimeout():
return sendTimeout(_that.originalError,_that.developerResponseError,_that.stackTrace);case Conflict():
return conflict(_that.originalError,_that.developerResponseError,_that.stackTrace);case InternalServerError():
return internalServerError(_that.originalError,_that.developerResponseError,_that.stackTrace);case NotImplemented():
return notImplemented(_that.originalError,_that.developerResponseError,_that.stackTrace);case ServiceUnavailable():
return serviceUnavailable(_that.originalError,_that.developerResponseError,_that.stackTrace);case NoInternetConnection():
return noInternetConnection(_that.originalError,_that.developerResponseError,_that.stackTrace);case FormatException():
return formatException(_that.originalError,_that.developerResponseError,_that.stackTrace);case UnableToProcess():
return unableToProcess(_that.originalError,_that.developerResponseError,_that.stackTrace);case DefaultError():
return defaultError(_that.originalError,_that.developerResponseError,_that.stackTrace);case UnexpectedError():
return unexpectedError(_that.originalError,_that.developerResponseError,_that.stackTrace);case BadResponseMappingError():
return badResponseMapping(_that.originalError,_that.developerResponseError,_that.stackTrace);case PdfUnableGenerate():
return pdfUnableGenerate(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthGeneralError():
return authGeneral(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthNonActiveUserError():
return authNonActiveUserError(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthDoNotHavePermissionsError():
return authDoNotHavePermissions(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthFailedError():
return authFailed(_that.originalError,_that.developerResponseError,_that.stackTrace);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  userNotFound,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  requestCancelled,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  unauthorizedRequest,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  forbiddenRequest,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  badRequest,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  notFound,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  methodNotAllowed,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  notAcceptable,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  requestTimeout,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  sendTimeout,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  conflict,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  internalServerError,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  notImplemented,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  serviceUnavailable,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  noInternetConnection,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  formatException,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  unableToProcess,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  defaultError,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  unexpectedError,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  badResponseMapping,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  pdfUnableGenerate,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  authGeneral,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  authNonActiveUserError,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  authDoNotHavePermissions,TResult? Function( Object originalError,  ApiBackendError? developerResponseError,  StackTrace? stackTrace)?  authFailed,}) {final _that = this;
switch (_that) {
case UserNotFound() when userNotFound != null:
return userNotFound(_that.originalError,_that.developerResponseError,_that.stackTrace);case RequestCancelled() when requestCancelled != null:
return requestCancelled(_that.originalError,_that.developerResponseError,_that.stackTrace);case UnauthorizedRequest() when unauthorizedRequest != null:
return unauthorizedRequest(_that.originalError,_that.developerResponseError,_that.stackTrace);case ForbiddenRequest() when forbiddenRequest != null:
return forbiddenRequest(_that.originalError,_that.developerResponseError,_that.stackTrace);case BadRequest() when badRequest != null:
return badRequest(_that.originalError,_that.developerResponseError,_that.stackTrace);case NotFound() when notFound != null:
return notFound(_that.originalError,_that.developerResponseError,_that.stackTrace);case MethodNotAllowed() when methodNotAllowed != null:
return methodNotAllowed(_that.originalError,_that.developerResponseError,_that.stackTrace);case NotAcceptable() when notAcceptable != null:
return notAcceptable(_that.originalError,_that.developerResponseError,_that.stackTrace);case RequestTimeout() when requestTimeout != null:
return requestTimeout(_that.originalError,_that.developerResponseError,_that.stackTrace);case SendTimeout() when sendTimeout != null:
return sendTimeout(_that.originalError,_that.developerResponseError,_that.stackTrace);case Conflict() when conflict != null:
return conflict(_that.originalError,_that.developerResponseError,_that.stackTrace);case InternalServerError() when internalServerError != null:
return internalServerError(_that.originalError,_that.developerResponseError,_that.stackTrace);case NotImplemented() when notImplemented != null:
return notImplemented(_that.originalError,_that.developerResponseError,_that.stackTrace);case ServiceUnavailable() when serviceUnavailable != null:
return serviceUnavailable(_that.originalError,_that.developerResponseError,_that.stackTrace);case NoInternetConnection() when noInternetConnection != null:
return noInternetConnection(_that.originalError,_that.developerResponseError,_that.stackTrace);case FormatException() when formatException != null:
return formatException(_that.originalError,_that.developerResponseError,_that.stackTrace);case UnableToProcess() when unableToProcess != null:
return unableToProcess(_that.originalError,_that.developerResponseError,_that.stackTrace);case DefaultError() when defaultError != null:
return defaultError(_that.originalError,_that.developerResponseError,_that.stackTrace);case UnexpectedError() when unexpectedError != null:
return unexpectedError(_that.originalError,_that.developerResponseError,_that.stackTrace);case BadResponseMappingError() when badResponseMapping != null:
return badResponseMapping(_that.originalError,_that.developerResponseError,_that.stackTrace);case PdfUnableGenerate() when pdfUnableGenerate != null:
return pdfUnableGenerate(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthGeneralError() when authGeneral != null:
return authGeneral(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthNonActiveUserError() when authNonActiveUserError != null:
return authNonActiveUserError(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthDoNotHavePermissionsError() when authDoNotHavePermissions != null:
return authDoNotHavePermissions(_that.originalError,_that.developerResponseError,_that.stackTrace);case AuthFailedError() when authFailed != null:
return authFailed(_that.originalError,_that.developerResponseError,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class UserNotFound extends ApiClientError {
  const UserNotFound(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserNotFoundCopyWith<UserNotFound> get copyWith => _$UserNotFoundCopyWithImpl<UserNotFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserNotFound&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.userNotFound(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $UserNotFoundCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $UserNotFoundCopyWith(UserNotFound value, $Res Function(UserNotFound) _then) = _$UserNotFoundCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$UserNotFoundCopyWithImpl<$Res>
    implements $UserNotFoundCopyWith<$Res> {
  _$UserNotFoundCopyWithImpl(this._self, this._then);

  final UserNotFound _self;
  final $Res Function(UserNotFound) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(UserNotFound(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class RequestCancelled extends ApiClientError {
  const RequestCancelled(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestCancelledCopyWith<RequestCancelled> get copyWith => _$RequestCancelledCopyWithImpl<RequestCancelled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestCancelled&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.requestCancelled(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $RequestCancelledCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $RequestCancelledCopyWith(RequestCancelled value, $Res Function(RequestCancelled) _then) = _$RequestCancelledCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$RequestCancelledCopyWithImpl<$Res>
    implements $RequestCancelledCopyWith<$Res> {
  _$RequestCancelledCopyWithImpl(this._self, this._then);

  final RequestCancelled _self;
  final $Res Function(RequestCancelled) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(RequestCancelled(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class UnauthorizedRequest extends ApiClientError {
  const UnauthorizedRequest(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnauthorizedRequestCopyWith<UnauthorizedRequest> get copyWith => _$UnauthorizedRequestCopyWithImpl<UnauthorizedRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedRequest&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.unauthorizedRequest(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $UnauthorizedRequestCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $UnauthorizedRequestCopyWith(UnauthorizedRequest value, $Res Function(UnauthorizedRequest) _then) = _$UnauthorizedRequestCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$UnauthorizedRequestCopyWithImpl<$Res>
    implements $UnauthorizedRequestCopyWith<$Res> {
  _$UnauthorizedRequestCopyWithImpl(this._self, this._then);

  final UnauthorizedRequest _self;
  final $Res Function(UnauthorizedRequest) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(UnauthorizedRequest(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class ForbiddenRequest extends ApiClientError {
  const ForbiddenRequest(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForbiddenRequestCopyWith<ForbiddenRequest> get copyWith => _$ForbiddenRequestCopyWithImpl<ForbiddenRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForbiddenRequest&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.forbiddenRequest(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $ForbiddenRequestCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $ForbiddenRequestCopyWith(ForbiddenRequest value, $Res Function(ForbiddenRequest) _then) = _$ForbiddenRequestCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$ForbiddenRequestCopyWithImpl<$Res>
    implements $ForbiddenRequestCopyWith<$Res> {
  _$ForbiddenRequestCopyWithImpl(this._self, this._then);

  final ForbiddenRequest _self;
  final $Res Function(ForbiddenRequest) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(ForbiddenRequest(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class BadRequest extends ApiClientError {
  const BadRequest(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BadRequestCopyWith<BadRequest> get copyWith => _$BadRequestCopyWithImpl<BadRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BadRequest&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.badRequest(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $BadRequestCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $BadRequestCopyWith(BadRequest value, $Res Function(BadRequest) _then) = _$BadRequestCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$BadRequestCopyWithImpl<$Res>
    implements $BadRequestCopyWith<$Res> {
  _$BadRequestCopyWithImpl(this._self, this._then);

  final BadRequest _self;
  final $Res Function(BadRequest) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(BadRequest(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class NotFound extends ApiClientError {
  const NotFound(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotFoundCopyWith<NotFound> get copyWith => _$NotFoundCopyWithImpl<NotFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFound&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.notFound(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $NotFoundCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $NotFoundCopyWith(NotFound value, $Res Function(NotFound) _then) = _$NotFoundCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$NotFoundCopyWithImpl<$Res>
    implements $NotFoundCopyWith<$Res> {
  _$NotFoundCopyWithImpl(this._self, this._then);

  final NotFound _self;
  final $Res Function(NotFound) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(NotFound(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class MethodNotAllowed extends ApiClientError {
  const MethodNotAllowed(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MethodNotAllowedCopyWith<MethodNotAllowed> get copyWith => _$MethodNotAllowedCopyWithImpl<MethodNotAllowed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MethodNotAllowed&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.methodNotAllowed(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $MethodNotAllowedCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $MethodNotAllowedCopyWith(MethodNotAllowed value, $Res Function(MethodNotAllowed) _then) = _$MethodNotAllowedCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$MethodNotAllowedCopyWithImpl<$Res>
    implements $MethodNotAllowedCopyWith<$Res> {
  _$MethodNotAllowedCopyWithImpl(this._self, this._then);

  final MethodNotAllowed _self;
  final $Res Function(MethodNotAllowed) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(MethodNotAllowed(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class NotAcceptable extends ApiClientError {
  const NotAcceptable(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotAcceptableCopyWith<NotAcceptable> get copyWith => _$NotAcceptableCopyWithImpl<NotAcceptable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotAcceptable&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.notAcceptable(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $NotAcceptableCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $NotAcceptableCopyWith(NotAcceptable value, $Res Function(NotAcceptable) _then) = _$NotAcceptableCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$NotAcceptableCopyWithImpl<$Res>
    implements $NotAcceptableCopyWith<$Res> {
  _$NotAcceptableCopyWithImpl(this._self, this._then);

  final NotAcceptable _self;
  final $Res Function(NotAcceptable) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(NotAcceptable(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class RequestTimeout extends ApiClientError {
  const RequestTimeout(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestTimeoutCopyWith<RequestTimeout> get copyWith => _$RequestTimeoutCopyWithImpl<RequestTimeout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestTimeout&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.requestTimeout(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $RequestTimeoutCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $RequestTimeoutCopyWith(RequestTimeout value, $Res Function(RequestTimeout) _then) = _$RequestTimeoutCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$RequestTimeoutCopyWithImpl<$Res>
    implements $RequestTimeoutCopyWith<$Res> {
  _$RequestTimeoutCopyWithImpl(this._self, this._then);

  final RequestTimeout _self;
  final $Res Function(RequestTimeout) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(RequestTimeout(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class SendTimeout extends ApiClientError {
  const SendTimeout(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendTimeoutCopyWith<SendTimeout> get copyWith => _$SendTimeoutCopyWithImpl<SendTimeout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendTimeout&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.sendTimeout(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $SendTimeoutCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $SendTimeoutCopyWith(SendTimeout value, $Res Function(SendTimeout) _then) = _$SendTimeoutCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$SendTimeoutCopyWithImpl<$Res>
    implements $SendTimeoutCopyWith<$Res> {
  _$SendTimeoutCopyWithImpl(this._self, this._then);

  final SendTimeout _self;
  final $Res Function(SendTimeout) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(SendTimeout(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class Conflict extends ApiClientError {
  const Conflict(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConflictCopyWith<Conflict> get copyWith => _$ConflictCopyWithImpl<Conflict>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conflict&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.conflict(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $ConflictCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $ConflictCopyWith(Conflict value, $Res Function(Conflict) _then) = _$ConflictCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$ConflictCopyWithImpl<$Res>
    implements $ConflictCopyWith<$Res> {
  _$ConflictCopyWithImpl(this._self, this._then);

  final Conflict _self;
  final $Res Function(Conflict) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(Conflict(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class InternalServerError extends ApiClientError {
  const InternalServerError(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InternalServerErrorCopyWith<InternalServerError> get copyWith => _$InternalServerErrorCopyWithImpl<InternalServerError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InternalServerError&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.internalServerError(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $InternalServerErrorCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $InternalServerErrorCopyWith(InternalServerError value, $Res Function(InternalServerError) _then) = _$InternalServerErrorCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$InternalServerErrorCopyWithImpl<$Res>
    implements $InternalServerErrorCopyWith<$Res> {
  _$InternalServerErrorCopyWithImpl(this._self, this._then);

  final InternalServerError _self;
  final $Res Function(InternalServerError) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(InternalServerError(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class NotImplemented extends ApiClientError {
  const NotImplemented(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotImplementedCopyWith<NotImplemented> get copyWith => _$NotImplementedCopyWithImpl<NotImplemented>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotImplemented&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.notImplemented(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $NotImplementedCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $NotImplementedCopyWith(NotImplemented value, $Res Function(NotImplemented) _then) = _$NotImplementedCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$NotImplementedCopyWithImpl<$Res>
    implements $NotImplementedCopyWith<$Res> {
  _$NotImplementedCopyWithImpl(this._self, this._then);

  final NotImplemented _self;
  final $Res Function(NotImplemented) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(NotImplemented(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class ServiceUnavailable extends ApiClientError {
  const ServiceUnavailable(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceUnavailableCopyWith<ServiceUnavailable> get copyWith => _$ServiceUnavailableCopyWithImpl<ServiceUnavailable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceUnavailable&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.serviceUnavailable(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $ServiceUnavailableCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $ServiceUnavailableCopyWith(ServiceUnavailable value, $Res Function(ServiceUnavailable) _then) = _$ServiceUnavailableCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$ServiceUnavailableCopyWithImpl<$Res>
    implements $ServiceUnavailableCopyWith<$Res> {
  _$ServiceUnavailableCopyWithImpl(this._self, this._then);

  final ServiceUnavailable _self;
  final $Res Function(ServiceUnavailable) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(ServiceUnavailable(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class NoInternetConnection extends ApiClientError {
  const NoInternetConnection(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoInternetConnectionCopyWith<NoInternetConnection> get copyWith => _$NoInternetConnectionCopyWithImpl<NoInternetConnection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoInternetConnection&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.noInternetConnection(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $NoInternetConnectionCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $NoInternetConnectionCopyWith(NoInternetConnection value, $Res Function(NoInternetConnection) _then) = _$NoInternetConnectionCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$NoInternetConnectionCopyWithImpl<$Res>
    implements $NoInternetConnectionCopyWith<$Res> {
  _$NoInternetConnectionCopyWithImpl(this._self, this._then);

  final NoInternetConnection _self;
  final $Res Function(NoInternetConnection) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(NoInternetConnection(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class FormatException extends ApiClientError {
  const FormatException(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormatExceptionCopyWith<FormatException> get copyWith => _$FormatExceptionCopyWithImpl<FormatException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormatException&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.formatException(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $FormatExceptionCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $FormatExceptionCopyWith(FormatException value, $Res Function(FormatException) _then) = _$FormatExceptionCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$FormatExceptionCopyWithImpl<$Res>
    implements $FormatExceptionCopyWith<$Res> {
  _$FormatExceptionCopyWithImpl(this._self, this._then);

  final FormatException _self;
  final $Res Function(FormatException) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(FormatException(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class UnableToProcess extends ApiClientError {
  const UnableToProcess(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnableToProcessCopyWith<UnableToProcess> get copyWith => _$UnableToProcessCopyWithImpl<UnableToProcess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnableToProcess&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.unableToProcess(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $UnableToProcessCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $UnableToProcessCopyWith(UnableToProcess value, $Res Function(UnableToProcess) _then) = _$UnableToProcessCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$UnableToProcessCopyWithImpl<$Res>
    implements $UnableToProcessCopyWith<$Res> {
  _$UnableToProcessCopyWithImpl(this._self, this._then);

  final UnableToProcess _self;
  final $Res Function(UnableToProcess) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(UnableToProcess(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class DefaultError extends ApiClientError {
  const DefaultError(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DefaultErrorCopyWith<DefaultError> get copyWith => _$DefaultErrorCopyWithImpl<DefaultError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefaultError&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.defaultError(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $DefaultErrorCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $DefaultErrorCopyWith(DefaultError value, $Res Function(DefaultError) _then) = _$DefaultErrorCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$DefaultErrorCopyWithImpl<$Res>
    implements $DefaultErrorCopyWith<$Res> {
  _$DefaultErrorCopyWithImpl(this._self, this._then);

  final DefaultError _self;
  final $Res Function(DefaultError) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(DefaultError(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class UnexpectedError extends ApiClientError {
  const UnexpectedError(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnexpectedErrorCopyWith<UnexpectedError> get copyWith => _$UnexpectedErrorCopyWithImpl<UnexpectedError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnexpectedError&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.unexpectedError(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $UnexpectedErrorCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $UnexpectedErrorCopyWith(UnexpectedError value, $Res Function(UnexpectedError) _then) = _$UnexpectedErrorCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$UnexpectedErrorCopyWithImpl<$Res>
    implements $UnexpectedErrorCopyWith<$Res> {
  _$UnexpectedErrorCopyWithImpl(this._self, this._then);

  final UnexpectedError _self;
  final $Res Function(UnexpectedError) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(UnexpectedError(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class BadResponseMappingError extends ApiClientError {
  const BadResponseMappingError(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BadResponseMappingErrorCopyWith<BadResponseMappingError> get copyWith => _$BadResponseMappingErrorCopyWithImpl<BadResponseMappingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BadResponseMappingError&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.badResponseMapping(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $BadResponseMappingErrorCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $BadResponseMappingErrorCopyWith(BadResponseMappingError value, $Res Function(BadResponseMappingError) _then) = _$BadResponseMappingErrorCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$BadResponseMappingErrorCopyWithImpl<$Res>
    implements $BadResponseMappingErrorCopyWith<$Res> {
  _$BadResponseMappingErrorCopyWithImpl(this._self, this._then);

  final BadResponseMappingError _self;
  final $Res Function(BadResponseMappingError) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(BadResponseMappingError(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class PdfUnableGenerate extends ApiClientError {
  const PdfUnableGenerate(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PdfUnableGenerateCopyWith<PdfUnableGenerate> get copyWith => _$PdfUnableGenerateCopyWithImpl<PdfUnableGenerate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PdfUnableGenerate&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.pdfUnableGenerate(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $PdfUnableGenerateCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $PdfUnableGenerateCopyWith(PdfUnableGenerate value, $Res Function(PdfUnableGenerate) _then) = _$PdfUnableGenerateCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$PdfUnableGenerateCopyWithImpl<$Res>
    implements $PdfUnableGenerateCopyWith<$Res> {
  _$PdfUnableGenerateCopyWithImpl(this._self, this._then);

  final PdfUnableGenerate _self;
  final $Res Function(PdfUnableGenerate) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(PdfUnableGenerate(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class AuthGeneralError extends ApiClientError {
  const AuthGeneralError(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthGeneralErrorCopyWith<AuthGeneralError> get copyWith => _$AuthGeneralErrorCopyWithImpl<AuthGeneralError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthGeneralError&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.authGeneral(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $AuthGeneralErrorCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $AuthGeneralErrorCopyWith(AuthGeneralError value, $Res Function(AuthGeneralError) _then) = _$AuthGeneralErrorCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$AuthGeneralErrorCopyWithImpl<$Res>
    implements $AuthGeneralErrorCopyWith<$Res> {
  _$AuthGeneralErrorCopyWithImpl(this._self, this._then);

  final AuthGeneralError _self;
  final $Res Function(AuthGeneralError) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(AuthGeneralError(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class AuthNonActiveUserError extends ApiClientError {
  const AuthNonActiveUserError(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthNonActiveUserErrorCopyWith<AuthNonActiveUserError> get copyWith => _$AuthNonActiveUserErrorCopyWithImpl<AuthNonActiveUserError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthNonActiveUserError&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.authNonActiveUserError(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $AuthNonActiveUserErrorCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $AuthNonActiveUserErrorCopyWith(AuthNonActiveUserError value, $Res Function(AuthNonActiveUserError) _then) = _$AuthNonActiveUserErrorCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$AuthNonActiveUserErrorCopyWithImpl<$Res>
    implements $AuthNonActiveUserErrorCopyWith<$Res> {
  _$AuthNonActiveUserErrorCopyWithImpl(this._self, this._then);

  final AuthNonActiveUserError _self;
  final $Res Function(AuthNonActiveUserError) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(AuthNonActiveUserError(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class AuthDoNotHavePermissionsError extends ApiClientError {
  const AuthDoNotHavePermissionsError(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthDoNotHavePermissionsErrorCopyWith<AuthDoNotHavePermissionsError> get copyWith => _$AuthDoNotHavePermissionsErrorCopyWithImpl<AuthDoNotHavePermissionsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthDoNotHavePermissionsError&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.authDoNotHavePermissions(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $AuthDoNotHavePermissionsErrorCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $AuthDoNotHavePermissionsErrorCopyWith(AuthDoNotHavePermissionsError value, $Res Function(AuthDoNotHavePermissionsError) _then) = _$AuthDoNotHavePermissionsErrorCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$AuthDoNotHavePermissionsErrorCopyWithImpl<$Res>
    implements $AuthDoNotHavePermissionsErrorCopyWith<$Res> {
  _$AuthDoNotHavePermissionsErrorCopyWithImpl(this._self, this._then);

  final AuthDoNotHavePermissionsError _self;
  final $Res Function(AuthDoNotHavePermissionsError) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(AuthDoNotHavePermissionsError(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

/// @nodoc


class AuthFailedError extends ApiClientError {
  const AuthFailedError(this.originalError, this.developerResponseError, {this.stackTrace}): super._();
  

@override final  Object originalError;
@override final  ApiBackendError? developerResponseError;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFailedErrorCopyWith<AuthFailedError> get copyWith => _$AuthFailedErrorCopyWithImpl<AuthFailedError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailedError&&const DeepCollectionEquality().equals(other.originalError, originalError)&&(identical(other.developerResponseError, developerResponseError) || other.developerResponseError == developerResponseError)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(originalError),developerResponseError,stackTrace);

@override
String toString() {
  return 'ApiClientError.authFailed(originalError: $originalError, developerResponseError: $developerResponseError, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $AuthFailedErrorCopyWith<$Res> implements $ApiClientErrorCopyWith<$Res> {
  factory $AuthFailedErrorCopyWith(AuthFailedError value, $Res Function(AuthFailedError) _then) = _$AuthFailedErrorCopyWithImpl;
@override @useResult
$Res call({
 Object originalError, ApiBackendError? developerResponseError, StackTrace? stackTrace
});




}
/// @nodoc
class _$AuthFailedErrorCopyWithImpl<$Res>
    implements $AuthFailedErrorCopyWith<$Res> {
  _$AuthFailedErrorCopyWithImpl(this._self, this._then);

  final AuthFailedError _self;
  final $Res Function(AuthFailedError) _then;

/// Create a copy of ApiClientError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalError = null,Object? developerResponseError = freezed,Object? stackTrace = freezed,}) {
  return _then(AuthFailedError(
null == originalError ? _self.originalError : originalError ,freezed == developerResponseError ? _self.developerResponseError : developerResponseError // ignore: cast_nullable_to_non_nullable
as ApiBackendError?,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

// dart format on
