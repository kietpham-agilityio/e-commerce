import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_l10n/ec_l10n.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/app_module.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env.prod");

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  await Firebase.initializeApp();

  try {
    // Initialize dependency injection using ec_core DI system
    await DI.initializeProduction(
      flavor: EcFlavor.user, // or EcFlavor.admin for admin flavor
      customHeaders: {
        'X-App-Version': dotenv.env['APP_VERSION'] ?? '1.0.0',
        'X-Platform': 'mobile',
        'X-API-Key': dotenv.env['API_KEY'] ?? '',
      },
      databaseName: dotenv.env['DATABASE_NAME'] ?? 'e_commerce_prod.db',
      enableDatabaseInspector:
          dotenv.env['ENABLE_DATABASE_INSPECTOR'] == 'true',
    );

    // Initialize app-specific dependencies
    AppModule.initialize(environment: 'production');

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = EcFlavor.current;

    return BlocProvider(
      create: (context) => AppBloc(featureFlagService: getFeatureFlagService()),
      child: MaterialApp.router(
        title: 'E-Commerce Production - ${flavor.displayName}',
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
      title: 'E-Commerce Production - Error',
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
