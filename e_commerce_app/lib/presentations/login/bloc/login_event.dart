part of 'login_bloc.dart';

/// Base class for all login events
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

/// Event when email input changes
class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

/// Event when password input changes
class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

/// Event when email field loses focus (for validation)
class LoginEmailUnfocused extends LoginEvent {
  const LoginEmailUnfocused();
}

/// Event when password field loses focus (for validation)
class LoginPasswordUnfocused extends LoginEvent {
  const LoginPasswordUnfocused();
}

/// Event when login form is submitted
class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

/// Event when Google login button is pressed
class LoginWithGooglePressed extends LoginEvent {
  const LoginWithGooglePressed();
}

/// Event when Facebook login button is pressed
class LoginWithFacebookPressed extends LoginEvent {
  const LoginWithFacebookPressed();
}

/// Event when forgot password is pressed
class LoginForgotPasswordPressed extends LoginEvent {
  const LoginForgotPasswordPressed();
}
