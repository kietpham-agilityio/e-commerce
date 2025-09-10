import 'package:get_it/get_it.dart';
import 'api_client_module.dart';
import 'service_module.dart';

/// Main dependency injection module for the application
class AppModule {
  static final GetIt _getIt = GetIt.instance;

  /// Initialize all dependencies
  static void initialize() {
    // Register API client dependencies
    ApiClientModule.registerDependencies();
    
    // Register service dependencies
    ServiceModule.registerServices();
    
    // Register other dependencies here as needed
    // Example:
    // AuthModule.registerDependencies();
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
    ApiClientModule.isRegistered && ServiceModule.isRegistered;
}
