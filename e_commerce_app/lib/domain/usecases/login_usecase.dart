import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for user login with email and password
class LoginUseCase {
  const LoginUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// Execute login with email and password
  /// Returns [User] on success or throws [Failure] on error
  Future<User> call({required String email, required String password}) async {
    return await _authRepository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

/// Use case for Google OAuth login
class LoginWithGoogleUseCase {
  const LoginWithGoogleUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// Execute Google login
  /// Returns [User] on success or throws [Failure] on error
  Future<User> call() async {
    return await _authRepository.loginWithGoogle();
  }
}

/// Use case for Facebook OAuth login
class LoginWithFacebookUseCase {
  const LoginWithFacebookUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// Execute Facebook login
  /// Returns [User] on success or throws [Failure] on error
  Future<User> call() async {
    return await _authRepository.loginWithFacebook();
  }
}

/// Use case for password reset
class SendPasswordResetEmailUseCase {
  const SendPasswordResetEmailUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// Send password reset email
  Future<void> call({required String email}) async {
    return await _authRepository.sendPasswordResetEmail(email: email);
  }
}
