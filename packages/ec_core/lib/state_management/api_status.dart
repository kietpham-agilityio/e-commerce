import 'package:equatable/equatable.dart';
import '../api_client/apis/failure.dart';

/// API call status enum for maybeFetch operations
enum ApiStatus {
  /// Initial state - no API call has been made yet
  init,
  
  /// Loading state - API call is in progress
  loading,
  
  /// Success state - API call completed successfully
  success,
  
  /// Error state - API call failed
  error,
}

/// Extension methods for ApiStatus
extension ApiStatusExtension on ApiStatus {
  /// Check if the status is in loading state
  bool get isLoading => this == ApiStatus.loading;
  
  /// Check if the status is in success state
  bool get isSuccess => this == ApiStatus.success;
  
  /// Check if the status is in error state
  bool get isError => this == ApiStatus.error;
  
  /// Check if the status is in initial state
  bool get isInit => this == ApiStatus.init;
  
  /// Check if the status indicates a completed operation (success or error)
  bool get isCompleted => this == ApiStatus.success || this == ApiStatus.error;
}

/// Base state class for API operations with status tracking
abstract class ApiState<T> extends Equatable {
  const ApiState({
    required this.status,
    this.data,
    this.failure,
    this.isRefreshing = false,
  });

  /// Current status of the API operation
  final ApiStatus status;
  
  /// Data returned from successful API call
  final T? data;
  
  /// Failure information if the API call failed
  final Failure? failure;
  
  /// Whether the operation is refreshing (for pull-to-refresh scenarios)
  final bool isRefreshing;

  /// Create initial state
  const factory ApiState.init() = _ApiStateInit<T>;
  
  /// Create loading state
  const factory ApiState.loading({bool isRefreshing}) = _ApiStateLoading<T>;
  
  /// Create success state
  const factory ApiState.success(T data) = _ApiStateSuccess<T>;
  
  /// Create error state
  const factory ApiState.error(Failure failure) = _ApiStateError<T>;

  /// Check if the state is in loading state
  bool get isLoading => status.isLoading;
  
  /// Check if the state is in success state
  bool get isSuccess => status.isSuccess;
  
  /// Check if the state is in error state
  bool get isError => status.isError;
  
  /// Check if the state is in initial state
  bool get isInit => status.isInit;
  
  /// Check if the state indicates a completed operation
  bool get isCompleted => status.isCompleted;

  /// Get data safely (returns null if not in success state)
  T? get safeData => isSuccess ? data : null;
  
  /// Get error message safely
  String? get errorMessage => isError ? failure?.message : null;
  
  /// Get user-friendly error message
  String? get userFriendlyErrorMessage {
    if (!isError || failure == null) return null;
    
    // Use the existing error handler for user-friendly messages
    return _getUserFriendlyMessage(failure!);
  }
  
  /// Get user-friendly error message from failure
  String _getUserFriendlyMessage(Failure failure) {
    if (failure.internalErrorCode != null) {
      return failure.internalErrorCode!.maybeWhen(
        authGeneral: () => 'Authentication failed. Please try again.',
        authNonActiveUserError: () => 'Your account is not active. Please contact support.',
        authDoNotHavePermissions: () => 'You don\'t have permission to perform this action.',
        authFailed: () => 'Authentication failed. Please check your credentials.',
        orElse: () => failure.message,
      );
    }
    
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

  @override
  List<Object?> get props => [status, data, failure, isRefreshing];
}

/// Initial state implementation
class _ApiStateInit<T> extends ApiState<T> {
  const _ApiStateInit() : super(status: ApiStatus.init);
}

/// Loading state implementation
class _ApiStateLoading<T> extends ApiState<T> {
  const _ApiStateLoading({bool isRefreshing = false}) 
    : super(status: ApiStatus.loading, isRefreshing: isRefreshing);
}

/// Success state implementation
class _ApiStateSuccess<T> extends ApiState<T> {
  const _ApiStateSuccess(T data) : super(status: ApiStatus.success, data: data);
}

/// Error state implementation
class _ApiStateError<T> extends ApiState<T> {
  const _ApiStateError(Failure failure) : super(status: ApiStatus.error, failure: failure);
}

/// Utility class for creating API states
class ApiStateUtils {
  /// Create initial state
  static ApiState<T> init<T>() => const ApiState.init();
  
  /// Create loading state
  static ApiState<T> loading<T>({bool isRefreshing = false}) => 
    ApiState.loading(isRefreshing: isRefreshing);
  
  /// Create success state
  static ApiState<T> success<T>(T data) => ApiState.success(data);
  
  /// Create error state
  static ApiState<T> error<T>(Failure failure) => ApiState.error(failure);
  
  /// Create error state from exception
  static ApiState<T> errorFromException<T>(Exception exception) {
    if (exception is Failure) {
      return ApiState.error(exception as Failure<dynamic>);
    }
    
    return ApiState.error(
      Failure<dynamic>(
        exception.toString(),
        internalErrorCode: null,
      ),
    );
  }
}
