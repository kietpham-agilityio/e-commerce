import 'package:ec_core/ec_core.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Example user service using DI
class UserService extends BaseService {
  late final ApiClient _apiClient;
  late final Talker _logger;

  @override
  Future<void> initialize() async {
    _apiClient = DI.apiClient;
    _logger = DI.logger;

    _logger.info('UserService initialized');
  }

  @override
  Future<void> dispose() async {
    _logger.info('UserService disposed');
  }

  /// Fetch all users
  Future<List<User>> getUsers() async {
    try {
      _logger.info('Fetching users...');

      final response = await _apiClient.get<List<dynamic>>('/users');
      final users = response.map((json) => User.fromJson(json)).toList();

      _logger.info('Successfully fetched ${users.length} users');
      return users;
    } catch (e) {
      _logger.error('Failed to fetch users: $e');
      rethrow;
    }
  }

  /// Fetch user by ID
  Future<User?> getUserById(String id) async {
    try {
      _logger.info('Fetching user: $id');

      final response = await _apiClient.get<Map<String, dynamic>>('/users/$id');
      final user = User.fromJson(response);

      _logger.info('Successfully fetched user: ${user.name}');
      return user;
    } catch (e) {
      _logger.error('Failed to fetch user: $id - $e');
      return null;
    }
  }

  /// Create new user
  Future<User> createUser(CreateUserRequest request) async {
    try {
      _logger.info('Creating user: ${request.name}');

      final response = await _apiClient.post<Map<String, dynamic>>(
        '/users',
        data: request.toJson(),
      );
      final user = User.fromJson(response);

      _logger.info('Successfully created user: ${user.name}');
      return user;
    } catch (e) {
      _logger.error('Failed to create user: ${request.name} - $e');
      rethrow;
    }
  }

  /// Update user
  Future<User> updateUser(String id, UpdateUserRequest request) async {
    try {
      _logger.info('Updating user: $id');

      final response = await _apiClient.put<Map<String, dynamic>>(
        '/users/$id',
        data: request.toJson(),
      );
      final user = User.fromJson(response);

      _logger.info('Successfully updated user: ${user.name}');
      return user;
    } catch (e) {
      _logger.error('Failed to update user: $id - $e');
      rethrow;
    }
  }

  /// Delete user
  Future<void> deleteUser(String id) async {
    try {
      _logger.info('Deleting user: $id');

      await _apiClient.delete('/users/$id', data: null);

      _logger.info('Successfully deleted user: $id');
    } catch (e) {
      _logger.error('Failed to delete user: $id - $e');
      rethrow;
    }
  }
}

// Example data models
class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], email: json['email']);
  }
}

class CreateUserRequest {
  final String name;
  final String email;

  CreateUserRequest({required this.name, required this.email});

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email};
  }
}

class UpdateUserRequest {
  final String? name;
  final String? email;

  UpdateUserRequest({this.name, this.email});

  Map<String, dynamic> toJson() {
    return {if (name != null) 'name': name, if (email != null) 'email': email};
  }
}
