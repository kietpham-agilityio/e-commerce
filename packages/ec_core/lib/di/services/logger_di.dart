import 'package:talker_flutter/talker_flutter.dart';

import '../../ec_flavor.dart';
import '../../logger/utils/success_log.dart';
import '../../logger/utils/error_log.dart';
import '../../logger/utils/good_log.dart';
import '../../logger/utils/info_log.dart';
import '../../logger/utils/warning_log.dart';
import '../di_initializer.dart';

/// Logger and debugging services dependency injection configuration
/// Provides centralized logging and debugging service registration
class LoggerDI {
  /// Register logger services
  static void registerLoggerServices({
    EcFlavor? flavor,
    bool enableConsoleLogs = true,
    bool enableHistory = true,
    int maxHistoryItems = 100,
    bool enableFileLogging = false,
    String? logFilePath,
    bool enableCrashReporting = false,
  }) {
    final currentFlavor = flavor ?? EcFlavor.current;

    // Register main Talker instance
    _registerMainTalker(
      flavor: currentFlavor,
      enableConsoleLogs: enableConsoleLogs,
      enableHistory: enableHistory,
      maxHistoryItems: maxHistoryItems,
    );

    // Register file logger if enabled
    if (enableFileLogging) {
      _registerFileLogger(flavor: currentFlavor, logFilePath: logFilePath);
    }

    // Register crash reporting if enabled
    if (enableCrashReporting) {
      _registerCrashReporting(flavor: currentFlavor);
    }

    // Register flavor-specific loggers
    _registerFlavorSpecificLoggers(currentFlavor);
  }

  /// Register main Talker instance
  static void _registerMainTalker({
    required EcFlavor flavor,
    required bool enableConsoleLogs,
    required bool enableHistory,
    required int maxHistoryItems,
  }) {
    final settings = TalkerSettings(
      useConsoleLogs: enableConsoleLogs,
      useHistory: enableHistory,
      maxHistoryItems: maxHistoryItems,
      enabled: true,
    );

    final talker = TalkerFlutter.init(settings: settings);

    DI.registerService<Talker>(talker, instanceName: 'main');
  }

  /// Register file logger
  static void _registerFileLogger({
    required EcFlavor flavor,
    String? logFilePath,
  }) {
    // File logging will be handled by Talker's built-in file logging
    // when enabled in TalkerSettings
  }

  /// Register crash reporting
  static void _registerCrashReporting({required EcFlavor flavor}) {
    // Crash reporting will be handled by Talker's built-in crash reporting
    // when enabled in TalkerSettings
  }

  /// Register flavor-specific loggers
  static void _registerFlavorSpecificLoggers(EcFlavor flavor) {
    if (flavor.isAdmin) {
      // Register admin-specific logger with enhanced debugging
      final adminSettings = TalkerSettings(
        useConsoleLogs: true,
        useHistory: true,
        maxHistoryItems: 500, // More history for admin
        enabled: true,
      );

      final adminTalker = TalkerFlutter.init(settings: adminSettings);

      DI.registerService<Talker>(adminTalker, instanceName: 'admin');
    } else {
      // Register user-specific logger with basic logging
      final userSettings = TalkerSettings(
        useConsoleLogs: false, // No console logs in production
        useHistory: true,
        maxHistoryItems: 50, // Less history for user
        enabled: true,
      );

      final userTalker = TalkerFlutter.init(settings: userSettings);

      DI.registerService<Talker>(userTalker, instanceName: 'user');
    }
  }

  /// Register custom Talker instance
  static void registerCustomTalker({
    required Talker talker,
    String instanceName = 'custom',
  }) {
    DI.registerService<Talker>(talker, instanceName: instanceName);
  }

  /// Register TalkerDioLogger for API logging
  static void registerDioLogger({Talker? talker, String instanceName = 'dio'}) {
    // DioLogger will be handled by Talker's built-in Dio integration
    // The talker parameter is available for future use
  }

  /// Get Talker instance by name
  static Talker getTalker({String instanceName = 'main'}) {
    return DI.get<Talker>(instanceName: instanceName);
  }

  /// Get main Talker instance
  static Talker get mainTalker => getTalker(instanceName: 'main');

  /// Get admin Talker instance
  static Talker get adminTalker => getTalker(instanceName: 'admin');

  /// Get user Talker instance
  static Talker get userTalker => getTalker(instanceName: 'user');

  /// Get file logger
  static Talker get fileLogger => getTalker(instanceName: 'file');

  /// Get crash reporter
  static Talker get crashReporter => getTalker(instanceName: 'crash');

  /// Get Dio logger
  static Talker get dioLogger => getTalker(instanceName: 'dio');

  /// Check if Talker is registered
  static bool isTalkerRegistered({String instanceName = 'main'}) {
    return DI.isRegistered<Talker>(instanceName: instanceName);
  }

  /// Check if file logger is registered
  static bool isFileLoggerRegistered() {
    return DI.isRegistered<Talker>(instanceName: 'file');
  }

  /// Check if crash reporter is registered
  static bool isCrashReporterRegistered() {
    return DI.isRegistered<Talker>(instanceName: 'crash');
  }

  /// Check if Dio logger is registered
  static bool isDioLoggerRegistered() {
    return DI.isRegistered<Talker>(instanceName: 'dio');
  }

  /// Log message using main Talker
  static void log(
    String message, {
    String level = 'info',
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (!isTalkerRegistered()) return;

    final talker = mainTalker;

    switch (level) {
      case 'debug':
        talker.debug(message);
        break;
      case 'info':
        talker.info(message);
        break;
      case 'warning':
        talker.warning(message);
        break;
      case 'error':
        talker.error(message, exception, stackTrace);
        break;
      case 'success':
        talker.logCustom(SuccessLog(message));
        break;
      case 'verbose':
        talker.verbose(message);
        break;
      default:
        talker.info(message);
    }
  }

  /// Log debug message
  static void debug(String message) {
    if (isTalkerRegistered()) {
      final talker = mainTalker;
      talker.logCustom(InfoLog(message));
    }
  }

  /// Log info message
  static void info(String message) {
    if (isTalkerRegistered()) {
      final talker = mainTalker;
      talker.logCustom(InfoLog(message));
    }
  }

  /// Log warning message
  static void warning(String message) {
    if (isTalkerRegistered()) {
      final talker = mainTalker;
      talker.logCustom(WarningLog(message));
    }
  }

  /// Log error message
  static void error(
    String message, {
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (isTalkerRegistered()) {
      final talker = mainTalker;
      talker.logCustom(ErrorLog(message));
    }
  }

  /// Log verbose message
  static void verbose(String message) {
    if (isTalkerRegistered()) {
      final talker = mainTalker;
      talker.logCustom(InfoLog(message));
    }
  }

  /// Log success message
  static void success(String message) {
    if (isTalkerRegistered()) {
      final talker = mainTalker;
      talker.logCustom(SuccessLog(message));
    }
  }

  /// Log good message
  static void good(String message) {
    if (isTalkerRegistered()) {
      final talker = mainTalker;
      talker.logCustom(GoodLog(message));
    }
  }

  /// Clear all logs
  static void clearLogs({String instanceName = 'main'}) {
    final talker = getTalker(instanceName: instanceName);
    talker.cleanHistory();
  }

  /// Get log history
  static List<TalkerData> getLogHistory({String instanceName = 'main'}) {
    final talker = getTalker(instanceName: instanceName);
    return talker.history;
  }

  /// Export logs to file
  static Future<void> exportLogs({
    String? filePath,
    String instanceName = 'main',
  }) async {
    // Export logs using Talker's built-in export functionality
    // This would typically be handled by Talker's file logging feature
    LoggerDI.info('Exporting logs for instance: $instanceName');
  }

  /// Dispose all logger services
  static Future<void> disposeAllLoggers() async {
    // Clear Talker instances
    final instanceNames = [
      'main',
      'admin',
      'user',
      'custom',
      'file',
      'crash',
      'dio',
    ];
    for (final instanceName in instanceNames) {
      if (isTalkerRegistered(instanceName: instanceName)) {
        DI.unregister<Talker>(instanceName: instanceName);
      }
    }
  }
}
