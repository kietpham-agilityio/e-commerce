import 'package:ec_core/api_client/apis/dtos/user_dto.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/api_client/enums/supabase_enums.dart';
import 'package:ec_core/services/ec_local_store/ec_local_store.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:supabase_flutter/supabase_flutter.dart' as supabase show User;

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Supabase implementation of AuthRepository using Supabase Flutter SDK
class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository({
    required ApiClient apiClient,
    required UserSessionBox userSessionBox,
    required SupabaseClient supabaseClient,
  }) : _apiClient = apiClient,
       _userSessionBox = userSessionBox,
       _supabase = supabaseClient {
    // Load tokens from local storage on initialization
    _loadStoredSession();

    // Set up auth state listener
    _setupAuthStateListener();
  }

  final ApiClient _apiClient;
  final UserSessionBox _userSessionBox;
  final SupabaseClient _supabase;

  User? _currentUser;

  /// Set up auth state change listener
  void _setupAuthStateListener() {
    _supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      final user = session?.user;

      if (user != null) {
        // User logged in or session refreshed
        _handleAuthStateChange(user, session!);
      } else {
        // User logged out
        _currentUser = null;
        _clearSession();
      }
    });
  }

  /// Handle auth state change
  Future<void> _handleAuthStateChange(
    supabase.User user,
    Session session,
  ) async {
    // Convert Supabase user to domain User
    final userDto = _convertSupabaseUserToDto(user);
    _currentUser = _toDomainUser(userDto);

    // Update access token in ApiClient for backend API calls
    _apiClient.setAuthorizationHeader('Bearer ${session.accessToken}');

    // Save session to local storage
    await _saveSession(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken ?? '',
      user: _currentUser!,
      expiresAt:
          session.expiresAt != null
              ? DateTime.fromMillisecondsSinceEpoch(
                session.expiresAt! * 1000,
              ).toIso8601String()
              : null,
    );
  }

  /// Load stored session from local storage
  Future<void> _loadStoredSession() async {
    try {
      final session = await _userSessionBox.getCurrentSession();
      if (session?.sessionToken != null && session!.userID != null) {
        // Reconstruct user from stored session
        _currentUser = User(
          id: session.userID.toString(),
          email: session.email ?? '',
          fullName: session.displayName,
        );

        // Set token in ApiClient for backend API calls
        final accessToken = session.sessionToken!.accessToken;
        if (accessToken.isNotEmpty) {
          _apiClient.setAuthorizationHeader('Bearer $accessToken');
        }
      }
    } catch (e) {
      // If loading fails, just start fresh
      _currentUser = null;
    }
  }

  /// Save session to local storage
  Future<void> _saveSession({
    required String accessToken,
    required String refreshToken,
    required User user,
    String? expiresAt,
  }) async {
    try {
      // Save tokens
      final tokenModel = SessionTokenDbModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expirationAt: expiresAt ?? '',
        idToken: '',
        tokenType: 'Bearer',
      );

      await _userSessionBox.setToken(tokenModel);

      // Save user attributes
      final userId = int.tryParse(user.id);
      if (userId != null) {
        await _userSessionBox.setUserAttributes(
          userID: userId,
          displayName: user.fullName ?? user.email,
          loginID: user.email,
        );
      }
    } catch (e) {
      // Log error but don't fail the operation
      throw Failure('Failed to save session: ${e.toString()}');
    }
  }

  /// Clear session from local storage
  Future<void> _clearSession() async {
    try {
      final session = await _userSessionBox.getCurrentSession();
      if (session != null) {
        session
          ..sessionToken = null
          ..userID = null
          ..displayName = null
          ..loginID = null
          ..email = null;

        await _userSessionBox.setToken(
          SessionTokenDbModel(
            accessToken: '',
            refreshToken: '',
            expirationAt: '',
            idToken: '',
          ),
        );
      }

      // Remove authorization header from ApiClient
      _apiClient.removeAuthorizationHeader();
    } catch (e) {
      // Ignore errors when clearing
    }
  }

  /// Convert Supabase user to UserDto
  UserDto _convertSupabaseUserToDto(supabase.User user) {
    // Extract role from user metadata, default to customer if not set
    UserRole role = UserRole.customer;
    final roleString = user.userMetadata?['role'] as String?;
    if (roleString != null) {
      if (roleString == 'admin') {
        role = UserRole.admin;
      } else if (roleString == 'customer') {
        role = UserRole.customer;
      }
    }

    return UserDto(
      id: user.id,
      email: user.email,
      fullName: user.userMetadata?['full_name'] as String?,
      phone: user.phone,
      role: role,
      createdAt: DateTime.parse(user.createdAt),
      avatar: user.userMetadata?['avatar_url'] as String?,
      isEmailVerified: user.emailConfirmedAt != null,
      isPhoneVerified: user.phoneConfirmedAt != null,
    );
  }

  /// Convert UserDto to domain User entity
  User _toDomainUser(UserDto userDto) {
    return User(
      id: userDto.id,
      email: userDto.email ?? '',
      fullName: userDto.fullName,
      phone: userDto.phone,
      role: userDto.role,
      createdAt: userDto.createdAt,
      avatar: userDto.avatar,
      isEmailVerified: userDto.isEmailVerified ?? false,
      isPhoneVerified: userDto.isPhoneVerified ?? false,
    );
  }

  @override
  Future<User> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const Failure('Invalid response from authentication service');
      }

      // Convert Supabase user to domain User
      final userDto = _convertSupabaseUserToDto(response.user!);
      _currentUser = _toDomainUser(userDto);

      // Session is automatically saved by auth state listener
      // But we'll manually save to ensure it's persisted immediately
      if (response.session != null) {
        await _saveSession(
          accessToken: response.session!.accessToken,
          refreshToken: response.session!.refreshToken ?? '',
          user: _currentUser!,
          expiresAt:
              response.session!.expiresAt != null
                  ? DateTime.fromMillisecondsSinceEpoch(
                    response.session!.expiresAt! * 1000,
                  ).toIso8601String()
                  : null,
        );

        // Set token in ApiClient for backend API calls
        _apiClient.setAuthorizationHeader(
          'Bearer ${response.session!.accessToken}',
        );
      }

      return _currentUser!;
    } on AuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<User> loginWithGoogle() async {
    try {
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'your-app-scheme://login-callback',
      );

      if (!response) {
        throw const Failure('Google login cancelled or failed');
      }

      // Wait for auth state change to get user
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw const Failure('Failed to get user after Google login');
      }

      final userDto = _convertSupabaseUserToDto(user);
      _currentUser = _toDomainUser(userDto);

      return _currentUser!;
    } on AuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure('Google login failed: ${e.toString()}');
    }
  }

  @override
  Future<User> loginWithFacebook() async {
    try {
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo: 'your-app-scheme://login-callback',
      );

      if (!response) {
        throw const Failure('Facebook login cancelled or failed');
      }

      // Wait for auth state change to get user
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw const Failure('Failed to get user after Facebook login');
      }

      final userDto = _convertSupabaseUserToDto(user);
      _currentUser = _toDomainUser(userDto);

      return _currentUser!;
    } on AuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure('Facebook login failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();

      // Clear local state
      _currentUser = null;

      // Clear session from local storage
      await _clearSession();
    } catch (e) {
      // Even if logout fails on server, clear local state
      _currentUser = null;
      await _clearSession();

      if (e is AuthException) {
        throw _handleAuthException(e);
      }
      throw Failure('Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    // First check memory cache
    if (_currentUser != null) {
      return _currentUser;
    }

    // Try to get from Supabase session
    final supabaseUser = _supabase.auth.currentUser;
    if (supabaseUser != null) {
      final userDto = _convertSupabaseUserToDto(supabaseUser);
      _currentUser = _toDomainUser(userDto);
      return _currentUser;
    }

    // Try to recover from local storage
    final session = await _userSessionBox.getCurrentSession();
    if (session?.userID != null) {
      // Session exists in storage, verify with Supabase
      try {
        final supabaseUser = _supabase.auth.currentUser;
        if (supabaseUser != null) {
          final userDto = _convertSupabaseUserToDto(supabaseUser);
          _currentUser = _toDomainUser(userDto);
          return _currentUser;
        }
      } catch (e) {
        // Clear invalid session
        await _clearSession();
      }
    }

    return null;
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure('Failed to send password reset email: ${e.toString()}');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    // Check if Supabase session is valid
    final session = _supabase.auth.currentSession;
    if (session != null) {
      // Session exists, verify it's not expired
      final expiresAt = session.expiresAt;
      if (expiresAt != null) {
        final expiryDate = DateTime.fromMillisecondsSinceEpoch(
          expiresAt * 1000,
        );
        if (DateTime.now().isBefore(expiryDate)) {
          return true;
        }
      }
    }

    // Try to get current user
    try {
      final user = await getCurrentUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }

  /// Handle Supabase AuthException and convert to Failure
  Failure _handleAuthException(AuthException error) {
    // Extract error message
    final message = error.message;

    // Handle specific error types
    switch (error.statusCode) {
      case '400':
      case '401':
        return Failure(
          message.contains('Invalid') ? 'Invalid email or password' : message,
        );
      case '422':
        return Failure(
          message.isNotEmpty
              ? message
              : 'Invalid input. Please check your credentials.',
        );
      case '429':
        return Failure(
          message.isNotEmpty
              ? message
              : 'Too many requests. Please try again later.',
        );
      case '500':
      case '502':
      case '503':
        return Failure(
          message.isNotEmpty
              ? message
              : 'Login service is temporarily unavailable. Try again later.',
        );
      default:
        // Check for network-related errors
        if (message.toLowerCase().contains('network') ||
            message.toLowerCase().contains('connection')) {
          return const Failure(
            'Unable to connect. Please check your internet connection.',
          );
        }
        return Failure(message.isNotEmpty ? message : 'An error occurred');
    }
  }
}
