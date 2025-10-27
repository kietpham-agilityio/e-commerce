import 'package:ec_themes/ec_design.dart';
import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent textWidgetBooks() {
  return WidgetbookComponent(
    name: 'Text',
    useCases: [
      WidgetbookUseCase(
        name: 'All text',
        builder: (context) {
          // Create appropriate knobs for the current widget
          return ECUiWidgetbook(
            copyCode: '''
            EcDisplayLargeText('Display Large'),
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcDisplayLargeText('Display Large'),
                  SizedBox(height: 8),
                  EcDisplayMediumText('Display Medium'),
                  SizedBox(height: 8),
                  EcDisplaySmallText('Display Small'),
                  SizedBox(height: 8),
                  EcHeadlineLargeText('Headline Large'),
                  SizedBox(height: 8),
                  EcHeadlineMediumText('Headline Medium'),
                  SizedBox(height: 8),
                  EcHeadlineSmallText('Headline Small'),
                  SizedBox(height: 8),
                  EcTitleLargeText('Title Large'),
                  SizedBox(height: 8),
                  EcTitleMediumText('Title Medium'),
                  SizedBox(height: 8),
                  EcTitleSmallText('Title Small'),
                  SizedBox(height: 8),
                  EcBodyLargeText('Body Large'),
                  SizedBox(height: 8),
                  EcBodyMediumText('Body Medium'),
                  SizedBox(height: 8),
                  EcBodySmallText('Body Small'),
                  SizedBox(height: 8),
                  EcLabelLargeText('Label Large'),
                  SizedBox(height: 8),
                  EcLabelMediumText('Label Medium'),
                  SizedBox(height: 8),
                  EcLabelSmallText('Label Small'),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}
