import 'package:ec_core/api_client/apis/failure.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Mock implementation of AuthRepository for testing and development
class MockAuthRepository implements AuthRepository {
  User? _currentUser;
  bool _isAuthenticated = false;

  @override
  Future<User> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation - accept any valid email format with password length > 8
    if (email.isEmpty || password.isEmpty) {
      throw const Failure('Email and password are required');
    }

    if (password.length < 8) {
      throw const Failure('Invalid email or password');
    }

    // Create mock user
    _currentUser = User(
      id: 'mock-user-123',
      email: email,
      fullName: 'Mock User',
      createdAt: DateTime.now(),
    );

    _isAuthenticated = true;

    return _currentUser!;
  }

  @override
  Future<User> loginWithGoogle() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Create mock user from Google
    _currentUser = User(
      id: 'google-user-123',
      email: 'user@gmail.com',
      fullName: 'Google User',
      avatar: 'https://example.com/avatar.jpg',
      createdAt: DateTime.now(),
    );

    _isAuthenticated = true;

    return _currentUser!;
  }

  @override
  Future<User> loginWithFacebook() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Create mock user from Facebook
    _currentUser = User(
      id: 'facebook-user-123',
      email: 'user@facebook.com',
      fullName: 'Facebook User',
      avatar: 'https://example.com/avatar.jpg',
      createdAt: DateTime.now(),
    );

    _isAuthenticated = true;

    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
    _isAuthenticated = false;
  }

  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _currentUser;
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty) {
      throw const Failure('Email is required');
    }

    // Mock successful password reset email sent
  }

  @override
  Future<bool> isAuthenticated() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _isAuthenticated;
  }
}
