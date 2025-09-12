import '../../ec_flavor.dart';
import '../di_initializer.dart';
import 'api_client_di.dart';
import 'logger_di.dart';
import 'package:dio/dio.dart';

/// Environment-specific dependency injection configurations
/// Provides different DI setups for development, staging, and production
class EnvironmentDI {
  /// Initialize development environment dependencies
  static Future<void> initializeDevelopment({
    EcFlavor? flavor,
    Map<String, String>? customHeaders,
    bool enableLogging = true,
    bool enableFileLogging = true,
    bool enableCrashReporting = false,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? customInterceptors,
  }) async {
    final currentFlavor = flavor ?? EcFlavor.current;

    // Register logger services for development
    LoggerDI.registerLoggerServices(
      flavor: currentFlavor,
      enableConsoleLogs: true,
      enableHistory: true,
      maxHistoryItems: 200,
      enableFileLogging: enableFileLogging,
      enableCrashReporting: enableCrashReporting,
    );

    // Register API clients for development
    ApiClientDI.registerApiClients(
      flavor: currentFlavor,
      customHeaders: {
        ...?customHeaders,
        'X-Environment': 'development',
        'X-Debug': 'true',
      },
      connectTimeout: connectTimeout ?? const Duration(seconds: 60),
      receiveTimeout: receiveTimeout ?? const Duration(seconds: 60),
      sendTimeout: sendTimeout,
      customInterceptors: customInterceptors,
      enableLogging: enableLogging,
    );
  }

  /// Initialize staging environment dependencies
  static Future<void> initializeStaging({
    EcFlavor? flavor,
    Map<String, String>? customHeaders,
    bool enableLogging = true,
    bool enableFileLogging = true,
    bool enableCrashReporting = true,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? customInterceptors,
  }) async {
    final currentFlavor = flavor ?? EcFlavor.current;

    // Register logger services for staging
    LoggerDI.registerLoggerServices(
      flavor: currentFlavor,
      enableConsoleLogs: false, // No console logs in staging
      enableHistory: true,
      maxHistoryItems: 100,
      enableFileLogging: enableFileLogging,
      enableCrashReporting: enableCrashReporting,
    );

    // Register API clients for staging
    ApiClientDI.registerApiClients(
      flavor: currentFlavor,
      customHeaders: {
        ...?customHeaders,
        'X-Environment': 'staging',
        'X-Debug': 'false',
      },
      connectTimeout: connectTimeout ?? const Duration(seconds: 30),
      receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
      sendTimeout: sendTimeout,
      customInterceptors: customInterceptors,
      enableLogging: enableLogging,
    );

    // Register staging-specific services
    _registerStagingServices(currentFlavor);
  }

  /// Initialize production environment dependencies
  static Future<void> initializeProduction({
    EcFlavor? flavor,
    Map<String, String>? customHeaders,
    bool enableLogging = false,
    bool enableFileLogging = true,
    bool enableCrashReporting = true,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? customInterceptors,
  }) async {
    final currentFlavor = flavor ?? EcFlavor.current;

    // Register logger services for production
    LoggerDI.registerLoggerServices(
      flavor: currentFlavor,
      enableConsoleLogs: false, // No console logs in production
      enableHistory: true,
      maxHistoryItems: 50,
      enableFileLogging: enableFileLogging,
      enableCrashReporting: enableCrashReporting,
    );

    // Register API clients for production
    ApiClientDI.registerApiClients(
      flavor: currentFlavor,
      customHeaders: {
        ...?customHeaders,
        'X-Environment': 'production',
        'X-Debug': 'false',
      },
      connectTimeout: connectTimeout ?? const Duration(seconds: 15),
      receiveTimeout: receiveTimeout ?? const Duration(seconds: 15),
      sendTimeout: sendTimeout,
      customInterceptors: customInterceptors,
      enableLogging: enableLogging,
    );

    // Register production-specific services
    _registerProductionServices(currentFlavor);
  }

  /// Register development-specific services

  /// Register staging-specific services
  static void _registerStagingServices(EcFlavor flavor) {
    // Staging-specific services can be registered here
    // Example: DI.registerService<StagingService>(StagingService());
  }

  /// Register production-specific services
  static void _registerProductionServices(EcFlavor flavor) {
    // Production-specific services can be registered here
    // Example: DI.registerService<ProductionService>(ProductionService());
  }

  /// Get environment-specific service
  static T getEnvironmentService<T extends Object>() {
    return DI.get<T>();
  }

  /// Check if environment service is registered
  static bool isEnvironmentServiceRegistered<T extends Object>() {
    return DI.isRegistered<T>();
  }

  /// Dispose all environment-specific services
  static Future<void> disposeEnvironmentServices() async {
    // Dispose all registered services
    await DI.dispose();
  }
}
