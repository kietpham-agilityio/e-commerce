import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../ec_flavor.dart';
import '../api_client/core/api_client.dart';
import '../services/core/base_service.dart';
import '../services/ec_local_store/ec_local_store.dart';
import '../feature_flags/feature_flag_service.dart';
import 'services/api_client_di.dart';
import 'services/logger_di.dart';
import 'services/environment_di.dart';
import 'services/local_storage_di.dart';

/// Unified Dependency Injection system for the E-Commerce application
/// Combines container management and initialization in a single, clean interface
class DependencyInjection {
  static final GetIt _getIt = GetIt.instance;

  // ============================================================================
  // CORE DI FUNCTIONALITY
  // ============================================================================

  /// Get the GetIt instance for advanced usage
  static GetIt get instance => _getIt;

  /// Initialize all dependencies with a single method
  static Future<void> initialize({
    EcFlavor? flavor,
    String environment = 'development',
    bool enableLogging = true,
    bool enableFileLogging = true,
    bool enableCrashReporting = false,
    Map<String, String>? customHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? customInterceptors,
    String? databaseName,
    bool enableDatabaseInspector = false,
  }) async {
    final currentFlavor = flavor ?? EcFlavor.current;

    try {
      // Reset container to avoid conflicts
      await _getIt.reset();

      // Register core services
      _registerCoreServices(
        flavor: currentFlavor,
        enableLogging: enableLogging,
      );

      // Register environment-specific services (this includes API clients and loggers)
      await _registerEnvironmentServices(
        flavor: currentFlavor,
        environment: environment,
        enableLogging: enableLogging,
        enableFileLogging: enableFileLogging,
        enableCrashReporting: enableCrashReporting,
        customHeaders: customHeaders,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
        customInterceptors: customInterceptors,
      );

      // Initialize local database
      await LocalStorageDI.initializeLocalDatabase(
        dbName: databaseName ?? 'ec_commerce.db',
        enableInspector: enableDatabaseInspector,
      );

      // Initialize all registered services
      await _initializeAllServices();

      LoggerDI.info(
        'DI initialization completed successfully for ${currentFlavor.displayName} flavor in $environment environment',
      );
    } catch (e, stackTrace) {
      LoggerDI.error(
        'Failed to initialize DI',
        exception: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Register core services that are common across all flavors
  static void _registerCoreServices({
    required EcFlavor flavor,
    required bool enableLogging,
  }) {
    // Register flavor as singleton
    _getIt.registerSingleton<EcFlavor>(flavor);

    // Register feature flag service
    registerFeatureFlagService();
  }

  /// Register environment-specific services
  static Future<void> _registerEnvironmentServices({
    required EcFlavor flavor,
    required String environment,
    required bool enableLogging,
    required bool enableFileLogging,
    required bool enableCrashReporting,
    Map<String, String>? customHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? customInterceptors,
  }) async {
    switch (environment.toLowerCase()) {
      case 'development':
        await EnvironmentDI.initializeDevelopment(
          flavor: flavor,
          customHeaders: customHeaders,
          enableLogging: enableLogging,
          enableFileLogging: enableFileLogging,
          enableCrashReporting: enableCrashReporting,
        );
        break;
      case 'staging':
        await EnvironmentDI.initializeStaging(
          flavor: flavor,
          customHeaders: customHeaders,
          enableLogging: enableLogging,
          enableFileLogging: enableFileLogging,
          enableCrashReporting: enableCrashReporting,
        );
        break;
      case 'production':
        await EnvironmentDI.initializeProduction(
          flavor: flavor,
          customHeaders: customHeaders,
          enableLogging: enableLogging,
          enableFileLogging: enableFileLogging,
          enableCrashReporting: enableCrashReporting,
        );
        break;
    }
  }

  /// Initialize all registered services
  static Future<void> _initializeAllServices() async {
    // Initialize feature flag service
    try {
      final featureFlagService = getFeatureFlagService();
      await featureFlagService.initialize();
    } catch (e, stackTrace) {
      LoggerDI.error(
        'Failed to initialize feature flag service',
        exception: e,
        stackTrace: stackTrace,
      );
    }

    // Get all registered services and initialize them
    final services = <BaseService>[];

    // Collect all registered services from environment DI
    // Services are registered by EnvironmentDI based on flavor and environment

    // Initialize all services
    for (final service in services) {
      try {
        await service.initialize();
      } catch (e, stackTrace) {
        LoggerDI.error(
          'Failed to initialize service: ${service.runtimeType}',
          exception: e,
          stackTrace: stackTrace,
        );
      }
    }
  }

  // ============================================================================
  // CONVENIENCE INITIALIZATION METHODS
  // ============================================================================

  /// Initialize with development configuration
  static Future<void> initializeDevelopment({
    EcFlavor? flavor,
    Map<String, String>? customHeaders,
    String? databaseName,
    bool enableDatabaseInspector = true,
  }) async {
    await initialize(
      flavor: flavor,
      environment: 'development',
      enableLogging: true,
      enableFileLogging: true,
      enableCrashReporting: false,
      customHeaders: {
        ...?customHeaders,
        'X-Environment': 'development',
        'X-Debug': 'true',
      },
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      databaseName: databaseName,
      enableDatabaseInspector: enableDatabaseInspector,
    );
  }

  /// Initialize with staging configuration
  static Future<void> initializeStaging({
    EcFlavor? flavor,
    Map<String, String>? customHeaders,
    String? databaseName,
    bool enableDatabaseInspector = false,
  }) async {
    await initialize(
      flavor: flavor,
      environment: 'staging',
      enableLogging: true,
      enableFileLogging: true,
      enableCrashReporting: true,
      customHeaders: {
        ...?customHeaders,
        'X-Environment': 'staging',
        'X-Debug': 'false',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      databaseName: databaseName,
      enableDatabaseInspector: enableDatabaseInspector,
    );
  }

  /// Initialize with production configuration
  static Future<void> initializeProduction({
    EcFlavor? flavor,
    Map<String, String>? customHeaders,
    String? databaseName,
    bool enableDatabaseInspector = false,
  }) async {
    await initialize(
      flavor: flavor,
      environment: 'production',
      enableLogging: false,
      enableFileLogging: true,
      enableCrashReporting: true,
      customHeaders: {
        ...?customHeaders,
        'X-Environment': 'production',
        'X-Debug': 'false',
      },
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      databaseName: databaseName,
      enableDatabaseInspector: enableDatabaseInspector,
    );
  }

  /// Initialize with admin flavor
  static Future<void> initializeAdmin({
    String environment = 'development',
    bool enableLogging = true,
    Map<String, String>? customHeaders,
    String? databaseName,
    bool enableDatabaseInspector = true,
  }) async {
    await initialize(
      flavor: EcFlavor.admin,
      environment: environment,
      enableLogging: enableLogging,
      enableFileLogging: true,
      enableCrashReporting: true,
      customHeaders: {...?customHeaders, 'X-Flavor': 'admin'},
      databaseName: databaseName,
      enableDatabaseInspector: enableDatabaseInspector,
    );
  }

  /// Initialize with user flavor
  static Future<void> initializeUser({
    String environment = 'production',
    bool enableLogging = false,
    Map<String, String>? customHeaders,
    String? databaseName,
    bool enableDatabaseInspector = false,
  }) async {
    await initialize(
      flavor: EcFlavor.user,
      environment: environment,
      enableLogging: enableLogging,
      enableFileLogging: true,
      enableCrashReporting: true,
      customHeaders: {...?customHeaders, 'X-Flavor': 'user'},
      databaseName: databaseName,
      enableDatabaseInspector: enableDatabaseInspector,
    );
  }

  // ============================================================================
  // SERVICE REGISTRATION METHODS
  // ============================================================================

  /// Register custom service
  static void registerService<T extends Object>(
    T service, {
    String? instanceName,
    bool override = false,
  }) {
    if (override && _getIt.isRegistered<T>(instanceName: instanceName)) {
      _getIt.unregister<T>(instanceName: instanceName);
    }

    _getIt.registerSingleton<T>(service, instanceName: instanceName);
  }

  /// Register factory for service
  static void registerFactory<T extends Object>(
    T Function() factory, {
    String? instanceName,
    bool override = false,
  }) {
    if (override && _getIt.isRegistered<T>(instanceName: instanceName)) {
      _getIt.unregister<T>(instanceName: instanceName);
    }

    _getIt.registerFactory<T>(factory, instanceName: instanceName);
  }

  /// Register lazy singleton
  static void registerLazySingleton<T extends Object>(
    T Function() factory, {
    String? instanceName,
    bool override = false,
  }) {
    if (override && _getIt.isRegistered<T>(instanceName: instanceName)) {
      _getIt.unregister<T>(instanceName: instanceName);
    }

    _getIt.registerLazySingleton<T>(factory, instanceName: instanceName);
  }

  // ============================================================================
  // SERVICE RETRIEVAL METHODS
  // ============================================================================

  /// Get service by type
  static T get<T extends Object>({String? instanceName}) {
    return _getIt.get<T>(instanceName: instanceName);
  }

  /// Check if service is registered
  static bool isRegistered<T extends Object>({String? instanceName}) {
    return _getIt.isRegistered<T>(instanceName: instanceName);
  }

  /// Unregister service
  static void unregister<T extends Object>({String? instanceName}) {
    if (_getIt.isRegistered<T>(instanceName: instanceName)) {
      _getIt.unregister<T>(instanceName: instanceName);
    }
  }

  // ============================================================================
  // CONVENIENCE GETTERS
  // ============================================================================

  /// Check if DI is initialized
  static bool get isInitialized {
    return _getIt.isRegistered<EcFlavor>() &&
        _getIt.isRegistered<ApiClient>(instanceName: 'main') &&
        _getIt.isRegistered<EcLocalDatabase>(instanceName: 'main');
  }

  /// Get current flavor
  static EcFlavor get currentFlavor {
    if (!isInitialized) {
      throw Exception('DI not initialized. Call DI.initialize() first.');
    }
    return _getIt.get<EcFlavor>();
  }

  /// Get main API client
  static ApiClient get apiClient {
    if (!isInitialized) {
      throw Exception('DI not initialized. Call DI.initialize() first.');
    }
    return ApiClientDI.mainApiClient;
  }

  /// Get main logger
  static Talker get logger {
    if (!isInitialized) {
      throw Exception('DI not initialized. Call DI.initialize() first.');
    }
    return LoggerDI.mainTalker;
  }

  /// Get local database
  static EcLocalDatabase get localDatabase {
    if (!isInitialized) {
      throw Exception('DI not initialized. Call DI.initialize() first.');
    }
    return LocalStorageDI.mainDatabase;
  }

  // ============================================================================
  // CLEANUP METHODS
  // ============================================================================

  /// Dispose all dependencies
  static Future<void> dispose() async {
    try {
      // Dispose all services
      final services = <BaseService>[];

      // Services are managed by EnvironmentDI

      // Dispose all services
      for (final service in services) {
        try {
          await service.dispose();
        } catch (e, stackTrace) {
          LoggerDI.error(
            'Failed to dispose service: ${service.runtimeType}',
            exception: e,
            stackTrace: stackTrace,
          );
        }
      }

      // Dispose API clients
      await ApiClientDI.disposeAllApiClients();

      // Dispose loggers
      await LoggerDI.disposeAllLoggers();

      // Dispose local databases
      await LocalStorageDI.disposeAllLocalDatabases();

      // Reset container
      await _getIt.reset();

      LoggerDI.info('DI disposal completed successfully');
    } catch (e, stackTrace) {
      LoggerDI.error(
        'Failed to dispose DI',
        exception: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Reset DI container
  static Future<void> reset() async {
    await _getIt.reset();
    LoggerDI.info('DI container reset completed');
  }
}

/// Convenience alias for DependencyInjection
typedef DI = DependencyInjection;
