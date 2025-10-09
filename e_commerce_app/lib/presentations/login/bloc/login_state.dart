part of 'login_bloc.dart';

/// Status of login operation
enum LoginStatus {
  /// Initial state
  initial,

  /// Login in progress
  loading,

  /// Login successful
  success,

  /// Login failed
  failure,
}

/// State for login page
class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.email = const EcEmailInput.pure(),
    this.password = const EcPasswordInput.pure(),
    this.errorMessage,
    this.isValid = false,
  });

  /// Current login status
  final LoginStatus status;

  /// Email input state with validation
  final EcEmailInput email;

  /// Password input state with validation
  final EcPasswordInput password;

  /// Error message to display
  final String? errorMessage;

  /// Whether the form is valid
  final bool isValid;

  /// Create a copy with updated fields
  LoginState copyWith({
    LoginStatus? status,
    EcEmailInput? email,
    EcPasswordInput? password,
    String? errorMessage,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [status, email, password, errorMessage, isValid];
}
