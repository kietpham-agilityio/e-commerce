import 'package:e_commerce_app/config/app_config.dart';
import 'package:e_commerce_app/core/initialization/app_initializer.dart';
import 'package:e_commerce_app/core/di/di.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_l10n/ec_l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentations/user/shared/error_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await AppInitializer.initialize(
      envFile: '.env.stag',
      environment: 'stag',
      flavor: EcFlavor.user,
      appEnvironment: 'staging',
    );

    runApp(
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppConfig.getSystemUiOverlayStyle(),
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('Failed to initialize app: $e');
    debugPrint('Stack trace: $stackTrace');

    runApp(
      ErrorApp(
        error: e,
        onRetry: () => main(),
        title: 'E-Commerce Stag - Error',
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocModule.appBloc,
      child: MaterialApp.router(
        title: 'E-Commerce Staging - ${EcFlavor.current.displayName}',
        theme: AppConfig.getTheme(),
        darkTheme: AppConfig.getDarkTheme(),
        themeMode: ThemeMode.system,
        supportedLocales: AppLocale.supportedLocales,
        localizationsDelegates: AppLocale.localizationsDelegates,
        routerConfig: AppConfig.getRouter(),
      ),
    );
  }
}
