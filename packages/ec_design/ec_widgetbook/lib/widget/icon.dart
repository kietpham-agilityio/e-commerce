import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent iconsWidgetBooks() {
  return WidgetbookComponent(
    name: 'Icons',
    useCases: [
      WidgetbookUseCase(
        name: 'Icons',
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
