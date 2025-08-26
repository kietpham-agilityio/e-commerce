import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent checkboxWidgetBooks() {
  return WidgetbookComponent(
    name: 'Checkbox',
    useCases: [
      WidgetbookUseCase(
        name: 'Checkbox',
        builder: (context) {
          // Create appropriate knobs for the current widget

          return ECUiWidgetbook(
            copyCode: '''
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          );
        },
      ),
    ],
  );
}
