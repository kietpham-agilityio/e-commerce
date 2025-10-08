import 'package:get_it/get_it.dart';

import 'api_client_module.dart';
import 'auth_module.dart';
import 'service_module.dart';

/// Main dependency injection module for the application
class AppModule {
  static final GetIt _getIt = GetIt.instance;

  /// Initialize all dependencies
  static void initialize({
    String environment = 'dev',
    AuthImplementation authImplementation = AuthImplementation.mock,
  }) {
    // Register API client dependencies with specific environment
    ApiClientModule.registerDependencies(environment: environment);

    // Register service dependencies
    ServiceModule.registerServices();

    // Register authentication dependencies
    // Use Supabase for staging/production, mock for development
    AuthModule.registerDependencies(implementation: authImplementation);

    // Register other dependencies here as needed
    // Example:
    // DatabaseModule.registerDependencies();
    // RepositoryModule.registerDependencies();
  }

  /// Get the global GetIt instance
  static GetIt get getIt => _getIt;

  /// Reset all dependencies (useful for testing)
  static void reset() {
    _getIt.reset();
  }

  /// Check if all dependencies are registered
  static bool get isInitialized =>
      ApiClientModule.isRegistered &&
      ServiceModule.isRegistered &&
      AuthModule.isRegistered;
}
