import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Simple environment configuration for feature flags
class EcEnv {
  // Debug and Development Features
  static bool get enableDebugMode =>
      dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';

  static bool get enableApiLogging =>
      dotenv.env['API_LOGGING']?.toLowerCase() == 'true';

  static bool get enableMockBackend =>
      dotenv.env['MOCK_BACKEND']?.toLowerCase() == 'true';

  static bool get enableDatabaseInspector =>
      dotenv.env['DATABASE_INSPECTOR']?.toLowerCase() == 'true';

  // Admin-specific features
  static bool get enableAdminDebugPanel =>
      dotenv.env['ADMIN_DEBUG_PANEL']?.toLowerCase() == 'true';

  static bool get enableUserImpersonation =>
      dotenv.env['USER_IMPERSONATION']?.toLowerCase() == 'true';

  // Analytics and Monitoring
  static bool get enableAnalytics =>
      dotenv.env['ANALYTICS_ENABLED']?.toLowerCase() == 'true';

  static bool get enableCrashReporting =>
      dotenv.env['CRASH_REPORTING']?.toLowerCase() == 'true';

  static bool get enablePerformanceMonitoring =>
      dotenv.env['PERFORMANCE_MONITORING']?.toLowerCase() == 'true';

  // API Configuration
  static int get apiTimeout =>
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '0') ?? 0;

  static int get apiRetryCount =>
      int.tryParse(dotenv.env['API_RETRY_COUNT'] ?? '0') ?? 0;

  static bool get enableApiCache =>
      dotenv.env['API_CACHE_ENABLED']?.toLowerCase() == 'true';

  // UI Features
  static bool get enableDarkMode =>
      dotenv.env['DARK_MODE_ENABLED']?.toLowerCase() == 'true';

  static bool get enableAnimations =>
      dotenv.env['ANIMATIONS_ENABLED']?.toLowerCase() == 'true';

  static bool get enableDebugOverlay =>
      dotenv.env['DEBUG_OVERLAY_ENABLED']?.toLowerCase() == 'true';

  // Feature Toggles
  static bool get enableNewCheckoutFlow =>
      dotenv.env['NEW_CHECKOUT_FLOW']?.toLowerCase() == 'true';

  static bool get enableSocialLogin =>
      dotenv.env['SOCIAL_LOGIN_ENABLED']?.toLowerCase() == 'true';

  static bool get enablePushNotifications =>
      dotenv.env['PUSH_NOTIFICATIONS_ENABLED']?.toLowerCase() == 'true';
}
