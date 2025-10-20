import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration class
/// Loads and provides access to environment variables from .env files
class EnvConfig {
  EnvConfig._();

  // Supabase Configuration
  static String? get supabaseUrl =>
      dotenv.maybeGet('SUPABASE_URL', fallback: '');

  static String? get supabaseAnonKey =>
      dotenv.maybeGet('SUPABASE_ANON_KEY', fallback: '');

  // App Configuration
  static String? get appVersion =>
      dotenv.maybeGet('APP_VERSION', fallback: '1.0.0');

  static String? get apiKey => dotenv.maybeGet('API_KEY', fallback: '');

  // Database Configuration
  static String? databaseName(String environment) {
    return dotenv.maybeGet(
      'DATABASE_NAME',
      fallback: 'e_commerce_$environment.db',
    );
  }

  // Feature Flags
  static bool enableDatabaseInspector(String environment) {
    return dotenv.getBool(
      'ENABLE_DATABASE_INSPECTOR',
      fallback: environment == 'dev',
    );
  }

  static bool enableApiLogging(String environment) {
    return dotenv.getBool('API_LOGGING', fallback: environment != 'prod');
  }

  // Debug Features
  static bool enableDebugMode(String environment) {
    return dotenv.getBool('ENABLE_DEBUG_MODE', fallback: environment == 'dev');
  }

  /// Check if debug mode is currently enabled (reads from loaded .env)
  static bool get isDebugModeEnabled {
    return dotenv.getBool('ENABLE_DEBUG_MODE', fallback: false);
  }

  static bool get enableMockBackend {
    return dotenv.getBool('MOCK_BACKEND', fallback: false);
  }

  // Validation
  static bool get hasSupabaseCredentials {
    return supabaseUrl != null &&
        supabaseAnonKey != null &&
        supabaseUrl!.isNotEmpty &&
        supabaseAnonKey!.isNotEmpty;
  }

  // Custom Headers
  static Map<String, String> customHeaders() {
    return {
      if (appVersion != null) 'X-App-Version': appVersion!,
      'X-Platform': 'mobile',
      if (apiKey != null && apiKey!.isNotEmpty) 'X-API-Key': apiKey!,
    };
  }

  // Load environment file
  static Future<void> load(String fileName) async {
    await dotenv.load(fileName: fileName);
  }
}
