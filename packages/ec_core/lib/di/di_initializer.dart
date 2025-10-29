import 'dart:developer' show log;

import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../ec_flavor.dart';
import '../api_client/core/api_client.dart';
import '../services/ec_local_store/ec_local_store.dart';
import '../feature_flags/feature_flag_service.dart';
import 'services/api_client_di.dart';
import 'services/logger_di.dart';
import 'services/environment_di.dart';
import 'services/local_storage_di.dart';

/// Unified Dependency Injection system for the E-Commerce application
class DependencyInjection {
  DependencyInjection._();

  static final GetIt _getIt = GetIt.instance;

  /// Get the GetIt instance for advanced usage
  static GetIt get instance => _getIt;

  /// Unified initialization method for all environments
  static Future<void> initializeWithEnvironment({
    required String environment,
    EcFlavor? flavor,
    Map<String, String>? customHeaders,
    String? databaseName,
    bool? enableDatabaseInspector,
    bool? enableLogging,
    bool? enableFileLogging,
    bool? enableCrashReporting,
    bool? enableDebugMode,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) async {
    // Set current environment for EcFlavor
    final envLower = environment.toLowerCase();
    EcFlavor.setEnvironment(envLower);

    // Environment-specific defaults
    final isDev = envLower == 'dev' || envLower == 'development';
    final isStaging = envLower == 'stag' || envLower == 'staging';
    final isProd = envLower == 'prod' || envLower == 'production';

    // Apply environment-specific defaults
    final logging = enableLogging ?? (isProd ? false : true);
    final fileLogging = enableFileLogging ?? true;
    final crashReporting = enableCrashReporting ?? (isDev ? false : true);
    final dbInspector = enableDatabaseInspector ?? (isProd ? false : isDev);
    final debugMode = enableDebugMode ?? isDev;

    // Environment-specific timeouts
    const defaultConnectTimeout = Duration(seconds: 60);
    const defaultReceiveTimeout = Duration(seconds: 60);

    final currentFlavor = flavor ?? EcFlavor.current;
    final normalizedEnvironment =
        isDev ? 'development' : (isStaging ? 'staging' : 'production');

    try {
      // Reset container to avoid conflicts
      await _getIt.reset();

      // Register core services
      _getIt.registerSingleton<EcFlavor>(currentFlavor);
      registerFeatureFlagService();

      // Register logger services early
      if (logging) {
        _registerLoggerServices(
          flavor: currentFlavor,
          enableFileLogging: fileLogging,
          enableCrashReporting: crashReporting,
        );
      }

      // Register environment-specific services
      await _registerEnvironmentServices(
        flavor: currentFlavor,
        environment: normalizedEnvironment,
        enableLogging: logging,
        enableFileLogging: fileLogging,
        enableCrashReporting: crashReporting,
        customHeaders: {
          ...?customHeaders,
          'X-Environment': normalizedEnvironment,
          'X-Debug': debugMode.toString(),
        },
        connectTimeout: connectTimeout ?? defaultConnectTimeout,
        receiveTimeout: receiveTimeout ?? defaultReceiveTimeout,
      );

      // Initialize local database
      await LocalStorageDI.initializeLocalDatabase(
        dbName: databaseName ?? 'ec_commerce.db',
        enableInspector: dbInspector,
      );

      // Initialize feature flag service
      try {
        final featureFlagService = getFeatureFlagService();
        await featureFlagService.initialize();
      } catch (e, stackTrace) {
        _logError(
          'Failed to initialize feature flag service',
          exception: e,
          stackTrace: stackTrace,
        );
      }

      // Log completion
      _logInfo(
        'DI initialization completed for ${currentFlavor.displayName} in $normalizedEnvironment',
      );

      if (debugMode) {
        _logInfo('Debug mode is ENABLED for $environment environment');
      }
    } catch (e, stackTrace) {
      _logError(
        'Failed to initialize DI',
        exception: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Register logger services
  static void _registerLoggerServices({
    required EcFlavor flavor,
    required bool enableFileLogging,
    required bool enableCrashReporting,
  }) {
    final mainTalker = TalkerFlutter.init(
      settings: TalkerSettings(
        useConsoleLogs: true,
        useHistory: true,
        maxHistoryItems: 200,
        enabled: true,
      ),
    );
    _getIt.registerSingleton<Talker>(mainTalker, instanceName: 'main');

    // Register flavor-specific Talker instance
    if (flavor.isAdmin) {
      final adminTalker = TalkerFlutter.init(
        settings: TalkerSettings(
          useConsoleLogs: true,
          useHistory: true,
          maxHistoryItems: 500,
          enabled: true,
        ),
      );
      _getIt.registerSingleton<Talker>(adminTalker, instanceName: 'admin');
    } else {
      final userTalker = TalkerFlutter.init(
        settings: TalkerSettings(
          useConsoleLogs: false,
          useHistory: true,
          maxHistoryItems: 50,
          enabled: true,
        ),
      );
      _getIt.registerSingleton<Talker>(userTalker, instanceName: 'user');
    }
  }

  /// Register environment-specific services
  static Future<void> _registerEnvironmentServices({
    required EcFlavor flavor,
    required String environment,
    required bool enableLogging,
    required bool enableFileLogging,
    required bool enableCrashReporting,
    required Map<String, String> customHeaders,
    required Duration connectTimeout,
    required Duration receiveTimeout,
  }) async {
    switch (environment) {
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

  /// Fallback logging method
  static void _logInfo(String message) {
    try {
      if (_getIt.isRegistered<Talker>(instanceName: 'main')) {
        _getIt.get<Talker>(instanceName: 'main').info(message);
      } else {
        log('[INFO] $message');
      }
    } catch (e) {
      log('[INFO] $message');
    }
  }

  /// Fallback error logging method
  static void _logError(
    String message, {
    Object? exception,
    StackTrace? stackTrace,
  }) {
    try {
      if (_getIt.isRegistered<Talker>(instanceName: 'main')) {
        _getIt
            .get<Talker>(instanceName: 'main')
            .error(message, exception, stackTrace);
      } else {
        log('[ERROR] $message');
        if (exception != null) log('[ERROR] Exception: $exception');
        if (stackTrace != null) log('[ERROR] StackTrace: $stackTrace');
      }
    } catch (e) {
      log('[ERROR] $message');
      if (exception != null) log('[ERROR] Exception: $exception');
      if (stackTrace != null) log('[ERROR] StackTrace: $stackTrace');
    }
  }

  // ============================================================================
  // SERVICE REGISTRATION & RETRIEVAL
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

  /// Check if DI is initialized
  static bool get isInitialized {
    return _getIt.isRegistered<EcFlavor>() &&
        _getIt.isRegistered<ApiClient>(instanceName: 'main') &&
        _getIt.isRegistered<EcLocalDatabase>(instanceName: 'main');
  }

  // ============================================================================
  // CLEANUP METHODS
  // ============================================================================

  /// Dispose all dependencies
  static Future<void> dispose() async {
    try {
      // Dispose API clients
      await ApiClientDI.disposeAllApiClients();

      // Dispose loggers
      await LoggerDI.disposeAllLoggers();

      // Dispose local databases
      await LocalStorageDI.disposeAllLocalDatabases();

      // Reset container
      await _getIt.reset();

      _logInfo('DI disposal completed successfully');
    } catch (e, stackTrace) {
      _logError('Failed to dispose DI', exception: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Reset DI container
  static Future<void> reset() async {
    await _getIt.reset();
    _logInfo('DI container reset completed');
  }
}

/// Convenience alias for DependencyInjection
typedef DI = DependencyInjection;
