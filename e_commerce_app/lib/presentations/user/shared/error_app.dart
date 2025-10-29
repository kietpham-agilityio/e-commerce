import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:flutter/material.dart';

/// Error app widget to display initialization errors
class ErrorApp extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;
  final String title;

  const ErrorApp({
    super.key,
    required this.error,
    required this.onRetry,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
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
                  onPressed: onRetry,
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
