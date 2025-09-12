import 'package:ec_core/ec_core.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Example service implementations demonstrating DI usage patterns
/// These services show how to properly integrate with the DI system

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

/// Example product service using DI
class ProductService extends BaseService {
  late final ApiClient _apiClient;
  late final Talker _logger;

  @override
  Future<void> initialize() async {
    _apiClient = DI.apiClient;
    _logger = DI.logger;

    _logger.info('ProductService initialized');
  }

  @override
  Future<void> dispose() async {
    _logger.info('ProductService disposed');
  }

  /// Fetch all products with pagination
  Future<PaginatedResponse<Product>> getProducts({
    int page = 1,
    int limit = 10,
    String? category,
    String? search,
  }) async {
    try {
      _logger.info('Fetching products - page: $page, limit: $limit');

      final queryParams = <String, dynamic>{'page': page, 'limit': limit};

      if (category != null) queryParams['category'] = category;
      if (search != null) queryParams['search'] = search;

      final response = await _apiClient.get<Map<String, dynamic>>(
        '/products',
        queryParameters: queryParams,
      );

      final products = _apiClient.handlePaginatedResponse<Product>(
        response,
        (json) => Product.fromJson(json),
      );

      _logger.info('Successfully fetched ${products.length} products');
      return products;
    } catch (e) {
      _logger.error('Failed to fetch products - $e');
      rethrow;
    }
  }

  /// Fetch product by ID
  Future<Product?> getProductById(String id) async {
    try {
      _logger.info('Fetching product: $id');

      final response = await _apiClient.get<Map<String, dynamic>>(
        '/products/$id',
      );
      final product = Product.fromJson(response);

      _logger.info('Successfully fetched product: ${product.name}');
      return product;
    } catch (e) {
      _logger.error('Failed to fetch product: $id - $e');
      return null;
    }
  }

  /// Create new product
  Future<Product> createProduct(CreateProductRequest request) async {
    try {
      _logger.info('Creating product: ${request.name}');

      final response = await _apiClient.post<Map<String, dynamic>>(
        '/products',
        data: request.toJson(),
      );
      final product = Product.fromJson(response);

      _logger.info('Successfully created product: ${product.name}');
      return product;
    } catch (e) {
      _logger.error('Failed to create product: ${request.name} - $e');
      rethrow;
    }
  }
}

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

/// Example analytics service using DI
class AnalyticsService extends BaseService {
  late final Talker _logger;
  late final EcFlavor _flavor;

  @override
  Future<void> initialize() async {
    _logger = DI.logger;
    _flavor = DI.currentFlavor;

    _logger.info('AnalyticsService initialized for ${_flavor.displayName}');
  }

  @override
  Future<void> dispose() async {
    _logger.info('AnalyticsService disposed');
  }

  /// Track user event
  void trackEvent(String eventName, Map<String, dynamic> properties) {
    _logger.info('Tracking event: $eventName with properties: $properties');

    // Different tracking based on flavor
    if (_flavor.isAdmin) {
      _trackAdminEvent(eventName, properties);
    } else {
      _trackUserEvent(eventName, properties);
    }
  }

  /// Track admin-specific event
  void _trackAdminEvent(String eventName, Map<String, dynamic> properties) {
    _logger.debug('Admin event tracked: $eventName');
    // Admin-specific tracking logic
  }

  /// Track user-specific event
  void _trackUserEvent(String eventName, Map<String, dynamic> properties) {
    _logger.debug('User event tracked: $eventName');
    // User-specific tracking logic
  }

  /// Track page view
  void trackPageView(String pageName) {
    trackEvent('page_view', {'page': pageName});
  }

  /// Track user action
  void trackUserAction(String action, Map<String, dynamic> properties) {
    trackEvent('user_action', {'action': action, ...properties});
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

class Product {
  final String id;
  final String name;
  final double price;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      category: json['category'],
    );
  }
}

class CreateProductRequest {
  final String name;
  final double price;
  final String category;

  CreateProductRequest({
    required this.name,
    required this.price,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'category': category};
  }
}

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
