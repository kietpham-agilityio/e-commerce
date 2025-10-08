import 'package:ec_core/api_client/apis/failure.dart';
import '../entities/user.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Login with email and password
  /// Returns [User] on success or [Failure] on error
  Future<User> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Login with Google OAuth
  /// Returns [User] on success or [Failure] on error
  Future<User> loginWithGoogle();

  /// Login with Facebook OAuth
  /// Returns [User] on success or [Failure] on error
  Future<User> loginWithFacebook();

  /// Logout current user
  Future<void> logout();

  /// Get currently authenticated user
  Future<User?> getCurrentUser();

  /// Send password reset email
  Future<void> sendPasswordResetEmail({required String email});

  /// Check if user is authenticated
  Future<bool> isAuthenticated();
}
