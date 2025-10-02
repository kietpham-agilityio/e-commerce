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
      // Using the new Retrofit-based user API
      final response = await _apiClient.userApi.getCurrentUser();
      if (response.success) {
        return response.data.toJson();
      } else {
        throw Exception(
          'Failed to fetch user data: API returned unsuccessful response',
        );
      }
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
      // Using the new Retrofit-based user API for user registration
      final response = await _apiClient.userApi.register(
        RegisterRequestDto(
          email: userData['email'] ?? 'user@example.com',
          password: userData['password'] ?? 'password123',
          firstName: userData['firstName'] ?? 'John',
          lastName: userData['lastName'] ?? 'Doe',
          phoneNumber: userData['phoneNumber'],
        ),
      );
      if (response.success) {
        return response.data.toJson();
      } else {
        throw Exception(
          'Failed to create user: API returned unsuccessful response',
        );
      }
    } catch (e) {
      if (e is Failure) {
        throw Exception('Failed to create user: ${e.message}');
      }
      rethrow;
    }
  }

  /// Example method to update user data
  Future<Map<String, dynamic>> updateUser(
    String userId,
    Map<String, dynamic> userData,
  ) async {
    try {
      // For now, we'll use a simple approach since UpdateProfileRequestDto doesn't exist
      // In a real implementation, you would create the appropriate DTO or use a different method
      final response = await _apiClient.userApi.getCurrentUser();
      if (response.success) {
        // Return the current user data as an example
        return response.data.toJson();
      } else {
        throw Exception('Failed to get user data for update example');
      }
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
      // Using the new Retrofit-based user API for account deletion
      final response = await _apiClient.userApi.deleteAccount();
      if (!response.success) {
        throw Exception(
          'Failed to delete user: API returned unsuccessful response',
        );
      }
    } catch (e) {
      if (e is Failure) {
        throw Exception('Failed to delete user: ${e.message}');
      }
      rethrow;
    }
  }

  /// Example method to fetch posts using the integrated test API
  Future<List<dynamic>> fetchPosts() async {
    try {
      final response = await _apiClient.getApis();
      return response;
    } on Failure catch (e) {
      throw Exception('Failed to fetch posts: ${e.message}');
    }
  }

  /// Example method to fetch comments for a specific post
  Future<List<dynamic>> fetchComments(int postId) async {
    try {
      final response = await _apiClient.getComments(postId);
      return response;
    } on Failure catch (e) {
      throw Exception('Failed to fetch comments: ${e.message}');
    }
  }

  /// Example method to fetch products using the Retrofit product API
  Future<List<dynamic>> fetchProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? brand,
    String? search,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? sortOrder,
    bool? inStock,
    bool? featured,
  }) async {
    try {
      final response = await _apiClient.productApi.getProducts(
        page,
        limit,
        category,
        brand,
        search,
        minPrice,
        maxPrice,
        sortBy,
        sortOrder,
        inStock,
        featured,
      );
      if (response.success) {
        return response.data.map((product) => product.toJson()).toList();
      } else {
        throw Exception(
          'Failed to fetch products: API returned unsuccessful response',
        );
      }
    } on Failure catch (e) {
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }

  /// Example method to get cart contents using the Retrofit cart API
  Future<Map<String, dynamic>> getCart() async {
    try {
      final response = await _apiClient.cartApi.getCart();
      if (response.success) {
        return response.data.toJson();
      } else {
        throw Exception(
          'Failed to get cart: API returned unsuccessful response',
        );
      }
    } on Failure catch (e) {
      throw Exception('Failed to get cart: ${e.message}');
    }
  }

  /// Example method to get user orders using the Retrofit order API
  Future<List<dynamic>> getUserOrders({
    int page = 1,
    int limit = 10,
    String? status,
    String? dateFrom,
    String? dateTo,
  }) async {
    try {
      final response = await _apiClient.orderApi.getOrders(
        page,
        limit,
        status,
        dateFrom,
        dateTo,
      );
      if (response.success) {
        return response.data.map((order) => order.toJson()).toList();
      } else {
        throw Exception(
          'Failed to get orders: API returned unsuccessful response',
        );
      }
    } on Failure catch (e) {
      throw Exception('Failed to get orders: ${e.message}');
    }
  }

  /// Get the current API client instance
  ApiClient get apiClient => _apiClient;

  /// Get the base URL of the API client
  String get baseUrl => _apiClient.baseUrl;
}
