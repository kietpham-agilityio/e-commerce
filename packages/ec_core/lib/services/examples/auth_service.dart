import 'package:ec_core/ec_core.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Example authentication service using DI
class AuthService extends BaseService {
  late final ApiClient _apiClient;
  late final Talker _logger;
  String? _currentToken;

  @override
  Future<void> initialize() async {
    _apiClient = DI.apiClient;
    _logger = DI.logger;

    _logger.info('AuthService initialized');
  }

  @override
  Future<void> dispose() async {
    _logger.info('AuthService disposed');
  }

  /// Login user
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      _logger.info('Attempting login for: ${request.email}');

      final response = await _apiClient.post<Map<String, dynamic>>(
        '/auth/login',
        data: request.toJson(),
      );

      final authResponse = AuthResponse.fromJson(response);
      _currentToken = authResponse.token;

      // Set authorization header for future requests
      _apiClient.setAuthorizationHeader('Bearer $_currentToken');

      _logger.info('Successfully logged in user: ${request.email}');
      return authResponse;
    } catch (e) {
      _logger.error('Failed to login user: ${request.email} - $e');
      rethrow;
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      _logger.info('Logging out user');

      if (_currentToken != null) {
        await _apiClient.post('/auth/logout', data: null);
        _apiClient.removeAuthorizationHeader();
        _currentToken = null;
      }

      _logger.info('Successfully logged out user');
    } catch (e) {
      _logger.error('Failed to logout user - $e');
      rethrow;
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated => _currentToken != null;

  /// Get current token
  String? get currentToken => _currentToken;
}

// Example data models
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class AuthResponse {
  final String token;
  final User user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
