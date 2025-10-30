import 'package:ec_l10n/generated/l10n.dart';
import 'package:ec_themes/themes/ec_theme_extension.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  AppLocale get l10n => AppLocale.of(this)!;

  ThemeData get ecTheme => Theme.of(this);

  TextTheme get textTheme => ecTheme.textTheme;

  ColorScheme get colorScheme => ecTheme.colorScheme;

  EcThemeExtension get ecThemeExt => ecTheme.extension<EcThemeExtension>()!;
}
