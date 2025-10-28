import 'package:ec_l10n/ec_l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:ec_widgetbook/widget/color.dart';
import 'package:ec_widgetbook/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        ViewportAddon(Viewports.all),
        InspectorAddon(),
        GridAddon(100),
        AlignmentAddon(),
        // ZoomAddon(),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: EcDesignTheme.lightTheme),
            WidgetbookTheme(name: 'Dark', data: EcDesignTheme.darkTheme),
          ],
        ),
        LocalizationAddon(
          locales: AppLocale.supportedLocales,
          localizationsDelegates: AppLocale.localizationsDelegates,
          initialLocale: AppLocale.supportedLocales.last,
        ),
      ],
      directories: [
        WidgetbookCategory(
          name: 'Common',
          children: [
            // The example is provided for reference on how to use it
            textWidgetBooks(),
            buttonWidgetBooks(),
            cardWidgetBooks(),
            textfieldWidgetBooks(),
            labelWidgetBooks(),
            checkboxWidgetBooks(),
            iconsWidgetBooks(),
            switchWidgetBooks(),
            colorWidgetBooks(),
          ],
        ),
      ],
    );
  }
}
