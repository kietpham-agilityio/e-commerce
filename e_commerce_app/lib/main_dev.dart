import 'package:e_commerce_app/config/env_config.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/domain/usecases/fetch_feature_flags_use_case.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_core/services/ec_notifications/ec_notifications.dart';
import 'package:ec_l10n/ec_l10n.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/di.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await EnvConfig.load('.env.dev');

  // Initialize Supabase
  if (EnvConfig.hasSupabaseCredentials) {
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl!,
      anonKey: EnvConfig.supabaseAnonKey!,
    );
  }

  await Firebase.initializeApp();

  try {
    // Initialize dependency injection using ec_core DI system
    await DI.initializeWithEnvironment(
      environment: 'dev',
      flavor: EcFlavor.user, // or EcFlavor.admin for admin flavor
      customHeaders: EnvConfig.customHeaders(),
      databaseName: EnvConfig.databaseName('dev'),
      enableDatabaseInspector: EnvConfig.enableDatabaseInspector('dev'),
      enableLogging: EnvConfig.enableApiLogging('dev'),
      enableDebugMode: EnvConfig.enableDebugMode('dev'),
    );

    // Initialize app-specific dependencies (this will override the API client)
    AppModule.initialize(environment: 'dev');

    // Fetch feature flags from server
    await _fetchFeatureFlagsFromServer();

    await NotificationsService.setNotificationListeners();
    ServiceModule.notificationsService;

    runApp(
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness:
              ThemeMode.system == ThemeMode.light
                  ? Brightness.light
                  : Brightness.dark,
        ),
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    // Handle initialization errors
    debugPrint('Failed to initialize app: $e');
    debugPrint('Stack trace: $stackTrace');

    // Run app anyway with error handling
    runApp(ErrorApp(error: e));
  }
}

/// Fetch feature flags from server and update the service
Future<void> _fetchFeatureFlagsFromServer() async {
  try {
    final fetchUseCase = GetIt.instance<FetchFeatureFlagsUseCase>();
    final featureFlagService = getFeatureFlagService();

    final flags = await fetchUseCase.execute();
    featureFlagService.updateFlags(flags);

    debugPrint('🎯 Feature flags fetched from server successfully');
  } catch (e) {
    // If fetching fails, use default flags (already set during initialization)
    debugPrint('⚠️ Failed to fetch feature flags from server: $e');
    debugPrint('Using default feature flags');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = EcFlavor.current;

    return BlocProvider(
      create: (context) => BlocModule.appBloc,
      child: MaterialApp.router(
        title: 'E-Commerce Dev - ${flavor.displayName}',
        theme: EcDesignTheme.lightTheme,
        darkTheme: EcDesignTheme.darkTheme,
        themeMode: ThemeMode.system,
        supportedLocales: AppLocale.supportedLocales,
        localizationsDelegates: AppLocale.localizationsDelegates,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

/// Error app widget to display initialization errors
class ErrorApp extends StatelessWidget {
  final Object error;

  const ErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce Dev - Error',
      theme: EcDesignTheme.lightTheme,
      darkTheme: EcDesignTheme.darkTheme,
      themeMode: ThemeMode.system,
      supportedLocales: AppLocale.supportedLocales,
      localizationsDelegates: AppLocale.localizationsDelegates,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocale.of(context)?.errorRegistrationFailed ??
                'Initialization Error',
          ),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  AppLocale.of(context)?.errorServer ??
                      'Failed to initialize the application',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text('Error: $error', textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Restart the app
                    main();
                  },
                  child: Text(
                    AppLocale.of(context)?.generalRetryBtn ?? 'Retry',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
