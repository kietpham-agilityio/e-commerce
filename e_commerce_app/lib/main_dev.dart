import 'package:e_commerce_app/config/env_config.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_core/services/ec_notifications/ec_notifications.dart';
import 'package:ec_l10n/ec_l10n.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/di.dart';
import 'presentations/user/shared/error_app.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
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

    // Initialize dependency injection using ec_core DI system
    await DI.initializeWithEnvironment(
      environment: 'dev',
      flavor: EcFlavor.user, // or EcFlavor.admin for admin flavor
      databaseName: EnvConfig.databaseName('dev'),
    );

    // Initialize app-specific dependencies (this will override the API client)
    AppModule.initialize(environment: 'dev');

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

    runApp(
      ErrorApp(
        error: e,
        onRetry: () => main(),
        title: 'E-Commerce Dev - Error',
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = EcFlavor.current;

    final routerConfig = switch (flavor.isAdmin) {
      true => AppRouter.adminRouter,
      false => AppRouter.router,
    };

    final theme = switch (flavor.isAdmin) {
      true => EcDesignTheme.adminLightTheme,
      false => EcDesignTheme.lightTheme,
    };

    final darkTheme = switch (flavor.isAdmin) {
      true => EcDesignTheme.adminDarkTheme,
      false => EcDesignTheme.darkTheme,
    };

    return BlocProvider(
      create: (context) => BlocModule.appBloc,
      child: MaterialApp.router(
        theme: theme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        supportedLocales: AppLocale.supportedLocales,
        localizationsDelegates: AppLocale.localizationsDelegates,
        routerConfig: routerConfig,
      ),
    );
  }
}
