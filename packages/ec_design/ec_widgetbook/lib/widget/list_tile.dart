import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent listTileWidgetBooks() {
  return WidgetbookComponent(
    name: 'ListTile',
    useCases: [
      WidgetbookUseCase(
        name: 'List Tile',
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
