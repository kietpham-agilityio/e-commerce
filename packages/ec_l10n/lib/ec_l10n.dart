/// E-commerce Localization Package
///
/// This package provides localization support for the E-commerce app
/// using Flutter's built-in localization with ARB files.
///
/// Usage:
/// ```dart
/// import 'package:ec_l10n/ec_l10n.dart';
///
/// // In main.dart
/// MaterialApp(
///   supportedLocales: AppLocale.supportedLocales,
///   localizationsDelegates: AppLocale.localizationsDelegates,
///   // ... rest of your app
/// )
///
/// // In widgets
/// Text(AppLocale.of(context).welcome)
/// ```

library ec_l10n;

export 'generated/l10n.dart';
