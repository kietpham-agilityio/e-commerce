import 'package:ec_core/ec_core.dart';
import '../di/api_client_module.dart';

/// Example service class that uses GetIt for dependency injection
class ApiService {
  late final ApiClient _apiClient;

  /// Constructor that gets ApiClient from GetIt
  ApiService() {
    _apiClient = ApiClientModule.apiClient;
  }

  /// Example method to fetch user data
  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      final response = await _apiClient.get('/users/$userId');
      return response as Map<String, dynamic>;
    } catch (e) {
      if (e is Failure) {
        throw Exception('Failed to fetch user data: ${e.message}');
      }
      rethrow;
    }
  }

  /// Example method to create a new user
  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    try {
      final response = await _apiClient.post('/users', data: userData);
      return response as Map<String, dynamic>;
    } catch (e) {
      if (e is Failure) {
        throw Exception('Failed to create user: ${e.message}');
      }
      rethrow;
    }
  }

  /// Example method to update user data
  Future<Map<String, dynamic>> updateUser(String userId, Map<String, dynamic> userData) async {
    try {
      final response = await _apiClient.put('/users/$userId', data: userData);
      return response as Map<String, dynamic>;
    } catch (e) {
      if (e is Failure) {
        throw Exception('Failed to update user: ${e.message}');
      }
      rethrow;
    }
  }

  /// Example method to delete a user
  Future<void> deleteUser(String userId) async {
    try {
      await _apiClient.delete('/users/$userId');
    } catch (e) {
      if (e is Failure) {
        throw Exception('Failed to delete user: ${e.message}');
      }
      rethrow;
    }
  }

  /// Get the current API client instance
  ApiClient get apiClient => _apiClient;

  /// Get the base URL of the API client
  String get baseUrl => _apiClient.baseUrl;
}
