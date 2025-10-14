import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for getting current authenticated user
class GetCurrentUserUseCase {
  const GetCurrentUserUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// Get currently authenticated user
  /// Returns [User] if authenticated, null otherwise
  Future<User?> call() async {
    return await _authRepository.getCurrentUser();
  }
}

/// Use case for checking if user is authenticated
class IsAuthenticatedUseCase {
  const IsAuthenticatedUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// Check if user is authenticated
  /// Returns true if authenticated, false otherwise
  Future<bool> call() async {
    return await _authRepository.isAuthenticated();
  }
}

/// Use case for logging out
class LogoutUseCase {
  const LogoutUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// Logout current user
  Future<void> call() async {
    return await _authRepository.logout();
  }
}

