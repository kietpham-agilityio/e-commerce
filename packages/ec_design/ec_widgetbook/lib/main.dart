import 'package:ec_themes/ec_design.dart';
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
        ZoomAddon(),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: EcDesignTheme.lightTheme),
            WidgetbookTheme(name: 'Dark', data: EcDesignTheme.darkTheme),
          ],
        ),
      ],
      directories: [WidgetbookCategory(name: 'Widget', children: [

          ],
        )],
    );
  }
}
