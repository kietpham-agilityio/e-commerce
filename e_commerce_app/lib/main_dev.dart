import 'package:e_commerce_app/core/di/service_module.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_core/services/ec_notifications/ec_notifications.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/di/app_module.dart';
import 'presentations/pages/example_navigation.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env.dev");

  await Firebase.initializeApp();

  try {
    // Initialize dependency injection using ec_core DI system
    await DI.initializeDevelopment(
      flavor: EcFlavor.user, // or EcFlavor.admin for admin flavor
      customHeaders: {'X-App-Version': '1.0.0', 'X-Platform': 'mobile'},
      databaseName: 'e_commerce_dev.db',
      enableDatabaseInspector: true,
    );

    // Initialize app-specific dependencies
    AppModule.initialize();

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = EcFlavor.current;

    return MaterialApp(
      title: 'E-Commerce Dev - ${flavor.displayName}',
      theme: EcDesignTheme.lightTheme,
      darkTheme: EcDesignTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const ExamplePage(),
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
      home: Scaffold(
        appBar: AppBar(
          title: const EcTitleMediumText('Initialization Error'),
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
                const EcHeadlineSmallText(
                  'Failed to initialize the application',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                EcBodyMediumText('Error: $error', textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Restart the app
                    main();
                  },
                  child: const EcLabelMediumText('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
