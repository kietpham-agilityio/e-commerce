import 'package:e_commerce_app/config/env_config.dart';
import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/domain/repositories/feature_flag_repository.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_core/services/ec_notifications/ec_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Handles all app initialization logic
class AppInitializer {
  AppInitializer._();

  /// Initialize the app with the given environment
  static Future<void> initialize({
    required String envFile,
    required String environment,
    required EcFlavor flavor,
    String? appEnvironment,
  }) async {
    // Load environment variables
    await EnvConfig.load(envFile);

    // Initialize Supabase
    if (EnvConfig.hasSupabaseCredentials) {
      await Supabase.initialize(
        url: EnvConfig.supabaseUrl!,
        anonKey: EnvConfig.supabaseAnonKey!,
      );
    }

    // Initialize Firebase
    await Firebase.initializeApp();

    // Initialize dependency injection
    await DI.initializeWithEnvironment(
      environment: environment,
      flavor: flavor,
      enableDatabaseInspector: EnvConfig.enableDatabaseInspector(environment),
      enableLogging: EnvConfig.enableApiLogging(environment),
      enableDebugMode: EnvConfig.enableDebugMode(environment),
    );

    // Initialize app-specific dependencies
    AppModule.initialize(environment: appEnvironment ?? environment);

    // Setup notifications
    await NotificationsService.setNotificationListeners();
    ServiceModule.notificationsService;

    // Fetch feature flags in the background
    _fetchFeatureFlagsInBackground();
  }

  /// Fetches feature flags in the background when app starts
  static void _fetchFeatureFlagsInBackground() {
    FetchBackgroundUtils.fetchBackground(
          apiCall: () async {
            final repository = AppModule.getIt<FeatureFlagRepository>();
            return await repository.getFeatureFlags();
          },
          errorContext: 'fetching feature flags',
          checkConnectivity: true,
          timeout: const Duration(seconds: 30),
        )
        .then((flags) {
          // Update FeatureFlagService with fetched flags
          final featureFlagService = BlocModule.featureFlagService;
          featureFlagService.updateFlags(flags);

          if (kDebugMode) {
            debugPrint('✅ Feature flags fetched successfully in background');
          }
        })
        .catchError((error) {
          // Handle error - log it but don't affect app startup
          if (kDebugMode) {
            debugPrint('❌ Failed to fetch feature flags in background: $error');
          }

          // FeatureFlagService will use default environment flags as fallback
        });
  }
}
