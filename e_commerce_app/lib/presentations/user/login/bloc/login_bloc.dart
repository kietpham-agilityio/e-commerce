import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_themes/themes/widgets/textfield/form_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

/// BLoC for managing login page state and business logic
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginUseCase loginUseCase,
    required LoginWithGoogleUseCase loginWithGoogleUseCase,
    required LoginWithFacebookUseCase loginWithFacebookUseCase,
  }) : _loginUseCase = loginUseCase,
       _loginWithGoogleUseCase = loginWithGoogleUseCase,
       _loginWithFacebookUseCase = loginWithFacebookUseCase,
       super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginEmailUnfocused>(_onEmailUnfocused);
    on<LoginPasswordUnfocused>(_onPasswordUnfocused);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginWithGooglePressed>(_onGoogleLoginPressed);
    on<LoginWithFacebookPressed>(_onFacebookLoginPressed);
    on<LoginForgotPasswordPressed>(_onForgotPasswordPressed);
  }

  final LoginUseCase _loginUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;
  final LoginWithFacebookUseCase _loginWithFacebookUseCase;

  /// Handle email input change
  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = EcEmailInput.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: _isFormValid(email, state.password),
        errorMessage: null,
      ),
    );
  }

  /// Handle password input change
  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = EcPasswordInput.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: _isFormValid(state.email, password),
        errorMessage: null,
      ),
    );
  }

  /// Handle email field losing focus
  void _onEmailUnfocused(LoginEmailUnfocused event, Emitter<LoginState> emit) {
    final email = EcEmailInput.dirty(state.email.value);
    emit(
      state.copyWith(
        email: email,
        isValid: _isFormValid(email, state.password),
      ),
    );
  }

  /// Handle password field losing focus
  void _onPasswordUnfocused(
    LoginPasswordUnfocused event,
    Emitter<LoginState> emit,
  ) {
    final password = EcPasswordInput.dirty(state.password.value);
    emit(
      state.copyWith(
        password: password,
        isValid: _isFormValid(state.email, password),
      ),
    );
  }

  /// Handle login form submission
  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    // Validate form before submission
    final email = EcEmailInput.dirty(state.email.value);
    final password = EcPasswordInput.dirty(state.password.value);

    emit(
      state.copyWith(
        email: email,
        password: password,
        isValid: _isFormValid(email, password),
      ),
    );

    if (!state.isValid) {
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));

    try {
      await _loginUseCase(
        email: state.email.value,
        password: state.password.value,
      );

      emit(state.copyWith(status: LoginStatus.success));
    } on Failure catch (failure) {
      // Handle different error types based on use case requirements
      String errorMessage = 'Login failed. Please try again.';

      if (failure.isAuthError) {
        errorMessage = 'Invalid email or password.';
      } else if (failure.isNetworkError) {
        errorMessage =
            'Unable to connect. Please check your internet connection.';
      } else if (failure.isServerError) {
        errorMessage =
            'Login service is temporarily unavailable. Try again later.';
      }

      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: errorMessage),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  /// Handle Google login
  Future<void> _onGoogleLoginPressed(
    LoginWithGooglePressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));

    try {
      await _loginWithGoogleUseCase();
      emit(state.copyWith(status: LoginStatus.success));
    } on Failure catch (failure) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage:
              failure.isNetworkError
                  ? 'Unable to connect. Please check your internet connection.'
                  : 'Login with Google failed. Please try again.',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Login with Google failed. Please try again.',
        ),
      );
    }
  }

  /// Handle Facebook login
  Future<void> _onFacebookLoginPressed(
    LoginWithFacebookPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));

    try {
      await _loginWithFacebookUseCase();
      emit(state.copyWith(status: LoginStatus.success));
    } on Failure catch (failure) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage:
              failure.isNetworkError
                  ? 'Unable to connect. Please check your internet connection.'
                  : 'Login with Facebook failed. Please try again.',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Login with Facebook failed. Please try again.',
        ),
      );
    }
  }

  /// Handle forgot password press
  void _onForgotPasswordPressed(
    LoginForgotPasswordPressed event,
    Emitter<LoginState> emit,
  ) {
    // This event is handled by navigation in the UI
    // The BLoC just acknowledges it without state change
  }

  /// Check if form is valid
  bool _isFormValid(EcEmailInput email, EcPasswordInput password) {
    return email.validator(email.value) == null &&
        password.validator(password.value) == null;
  }
}
