import 'package:get_it/get_it.dart';
import 'package:ec_flavor/ec_flavor.dart';
import 'flavor_service_locator.dart';

/// Main service locator for the e-commerce application
/// This class provides centralized access to all application services
class EcLocator {
  static final GetIt _getIt = GetIt.instance;
  static bool _isInitialized = false;

  /// Initialize all application services
  /// This should be called once at app startup
  static Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    try {
      // Initialize flavor services first
      await FlavorServiceLocator.initialize();
      
      // Register core application services
      _registerCoreServices();
      
      // Register feature services (placeholder for future implementation)
      _registerFeatureServices();
      
      // Register API services (placeholder for future implementation)
      _registerApiServices();
      
      // Register business logic services (placeholder for future implementation)
      _registerBusinessServices();
      
      _isInitialized = true;
    } catch (e) {
      rethrow;
    }
  }

  /// Register core application services
  static void _registerCoreServices() {
    // Core services that are always available
    _getIt.registerLazySingleton<AppConfigService>(() => AppConfigService());
    _getIt.registerLazySingleton<AppStateService>(() => AppStateService());
    _getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  }

  /// Register feature flag and configuration services
  static void _registerFeatureServices() {
    // Feature flag service (placeholder - to be implemented)
    _getIt.registerLazySingleton<FeatureFlagService>(() => FeatureFlagService());
    
    // Configuration service (placeholder - to be implemented)
    _getIt.registerLazySingleton<ConfigurationService>(() => ConfigurationService());
    
    // Theme service (placeholder - to be implemented)
    _getIt.registerLazySingleton<ThemeService>(() => ThemeService());
  }

  /// Register API and network services
  static void _registerApiServices() {
    // HTTP client service (placeholder - to be implemented)
    _getIt.registerLazySingleton<HttpClientService>(() => HttpClientService());
    
    // Authentication service (placeholder - to be implemented)
    _getIt.registerLazySingleton<AuthService>(() => AuthService());
    
    // Network connectivity service (placeholder - to be implemented)
    _getIt.registerLazySingleton<NetworkService>(() => NetworkService());
  }

  /// Register business logic services
  static void _registerBusinessServices() {
    // User service (placeholder - to be implemented)
    _getIt.registerLazySingleton<UserService>(() => UserService());
    
    // Product service (placeholder - to be implemented)
    _getIt.registerLazySingleton<ProductService>(() => ProductService());
    
    // Order service (placeholder - to be implemented)
    _getIt.registerLazySingleton<OrderService>(() => OrderService());
    
    // Cart service (placeholder - to be implemented)
    _getIt.registerLazySingleton<CartService>(() => CartService());
    
    // Payment service (placeholder - to be implemented)
    _getIt.registerLazySingleton<PaymentService>(() => PaymentService());
  }

  /// Get a service instance
  static T get<T extends Object>() {
    if (!_isInitialized) {
      throw StateError('EcLocator is not initialized. Call initialize() first.');
    }
    
    if (!_getIt.isRegistered<T>()) {
      throw StateError('Service of type $T is not registered.');
    }
    
    return _getIt.get<T>();
  }

  /// Check if a service is registered
  static bool isRegistered<T extends Object>() {
    return _getIt.isRegistered<T>();
  }

  /// Get the current flavor configuration
  static FlavorEnvironment getCurrentConfig() {
    return FlavorServiceLocator.getCurrentConfig();
  }

  /// Check if a feature is enabled
  static bool isFeatureEnabled(String feature) {
    return FlavorServiceLocator.isFeatureEnabled(feature);
  }

  /// Get the current flavor
  static EcFlavor getCurrentFlavor() {
    return FlavorManager.currentFlavor;
  }

  /// Reset all services (useful for testing)
  static void reset() {
    _getIt.reset();
    _isInitialized = false;
  }

  /// Check if the locator is initialized
  static bool get isInitialized => _isInitialized;
}

// =============================================================================
// PLACEHOLDER SERVICE CLASSES (to be implemented in the future)
// =============================================================================

/// Core application configuration service
class AppConfigService {
  AppConfigService();
  
  String get appVersion => '1.0.0';
  String get buildNumber => '1';
  bool get isDebugMode => true;
}

/// Application state management service
class AppStateService {
  AppStateService();
  
  void setState(String key, dynamic value) {
    // Placeholder implementation
  }
  
  T? getState<T>(String key) {
    // Placeholder implementation
    return null;
  }
}

/// Navigation service for app routing
class NavigationService {
  NavigationService();
  
  void navigateTo(String route) {
    // Placeholder implementation
  }
  
  void goBack() {
    // Placeholder implementation
  }
}

/// Feature flag service for managing app features
class FeatureFlagService {
  FeatureFlagService();
  
  bool isFeatureEnabled(String feature) {
    // Placeholder implementation - default to enabled
    return true;
  }
  
  void setFeatureFlag(String feature, bool enabled) {
    // Placeholder implementation
  }
}

/// Configuration service for app settings
class ConfigurationService {
  ConfigurationService();
  
  String getString(String key, {String defaultValue = ''}) {
    // Placeholder implementation
    return defaultValue;
  }
  
  int getInt(String key, {int defaultValue = 0}) {
    // Placeholder implementation
    return defaultValue;
  }
  
  bool getBool(String key, {bool defaultValue = false}) {
    // Placeholder implementation
    return defaultValue;
  }
}

/// Theme service for app theming
class ThemeService {
  ThemeService();
  
  String get currentTheme => 'light';
  
  void setTheme(String theme) {
    // Placeholder implementation
  }
  
  bool get isDarkMode => false;
}

/// HTTP client service for network requests
class HttpClientService {
  HttpClientService();
  
  Future<Map<String, dynamic>> get(String url) async {
    // Placeholder implementation
    return {'status': 'success', 'data': 'placeholder'};
  }
  
  Future<Map<String, dynamic>> post(String url, {Map<String, dynamic>? data}) async {
    // Placeholder implementation
    return {'status': 'success', 'data': 'placeholder'};
  }
}

/// Authentication service
class AuthService {
  AuthService();
  
  bool get isAuthenticated => false;
  
  Future<bool> login(String email, String password) async {
    // Placeholder implementation
    return false;
  }
  
  Future<void> logout() async {
    // Placeholder implementation
  }
}

/// Network connectivity service
class NetworkService {
  NetworkService();
  
  bool get isConnected => true;
  
  Stream<bool> get connectivityStream {
    return Stream.value(true);
  }
}

/// User management service
class UserService {
  UserService();
  
  Future<Map<String, dynamic>?> getCurrentUser() async {
    // Placeholder implementation
    return null;
  }
  
  Future<void> updateProfile(Map<String, dynamic> profile) async {
    // Placeholder implementation
  }
}

/// Product management service
class ProductService {
  ProductService();
  
  Future<List<Map<String, dynamic>>> getProducts() async {
    // Placeholder implementation
    return [];
  }
  
  Future<Map<String, dynamic>?> getProduct(String id) async {
    // Placeholder implementation
    return null;
  }
}

/// Order management service
class OrderService {
  OrderService();
  
  Future<List<Map<String, dynamic>>> getOrders() async {
    // Placeholder implementation
    return [];
  }
  
  Future<Map<String, dynamic>?> createOrder(Map<String, dynamic> orderData) async {
    // Placeholder implementation
    return null;
  }
}

/// Shopping cart service
class CartService {
  CartService();
  
  List<Map<String, dynamic>> get items => [];
  
  void addItem(Map<String, dynamic> item) {
    // Placeholder implementation
  }
  
  void removeItem(String itemId) {
    // Placeholder implementation
  }
}

/// Payment processing service
class PaymentService {
  PaymentService();
  
  Future<bool> processPayment(Map<String, dynamic> paymentData) async {
    // Placeholder implementation
    return false;
  }
  
  Future<Map<String, dynamic>> getPaymentMethods() async {
    // Placeholder implementation
    return {};
  }
}
