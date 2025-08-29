import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent chipWidgetBooks() {
  return WidgetbookComponent(
    name: 'Chips',
    useCases: [
      WidgetbookUseCase(
        name: 'Tag/Ordinary',
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
      WidgetbookUseCase(
        name: 'Tag/Small',
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
      WidgetbookUseCase(
        name: 'Sale label',
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
      WidgetbookUseCase(
        name: 'New label',
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
      WidgetbookUseCase(
        name: 'Hot label',
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
