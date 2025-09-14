import 'package:get_it/get_it.dart';
import '../services/api_service.dart';

/// Service module for registering business logic services
class ServiceModule {
  static final GetIt _getIt = GetIt.instance;

  /// Register all services
  static void registerServices() {
    // Register ApiService as singleton
    _getIt.registerLazySingleton<ApiService>(
      () => ApiService(),
    );

    // Register other services here as needed
    // Example:
    // _getIt.registerLazySingleton<UserRepository>(
    //   () => UserRepository(),
    // );
    // _getIt.registerLazySingleton<AuthService>(
    //   () => AuthService(),
    // );
  }

  /// Get ApiService instance
  static ApiService get apiService => _getIt<ApiService>();

  /// Check if services are registered
  static bool get isRegistered => _getIt.isRegistered<ApiService>();

  /// Reset all services (useful for testing)
  static void reset() {
    if (_getIt.isRegistered<ApiService>()) {
      _getIt.unregister<ApiService>();
    }
  }
}
