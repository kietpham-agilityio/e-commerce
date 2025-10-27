import 'package:ec_themes/ec_design.dart';
import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent labelWidgetBooks() {
  return WidgetbookComponent(
    name: 'Labels',
    useCases: [
      WidgetbookUseCase(
        name: 'Tag/Ordinary',
        builder: (context) {
          final text = context.knobs.string(
            label: 'Text',
            initialValue: 'Shoes',
          );
          final style = context.knobs.object.dropdown(
            label: 'Style',
            options: [EcLabelStyle.primary, EcLabelStyle.secondary],
            labelBuilder:
                (value) =>
                    value == EcLabelStyle.primary ? 'Primary' : 'Secondary',
          );

          return ECUiWidgetbook(
            copyCode: '''
EcLabel(
  text: '$text',
  style: EcLabelStyle.${style.name},
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcLabel(text: text, style: style),
                  const SizedBox(height: 16),
                  EcLabelRow(
                    labels: [
                      EcLabel(text: text, style: EcLabelStyle.primary),
                      EcLabel(text: text, style: EcLabelStyle.secondary),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Tag/Small',
        builder: (context) {
          final text = context.knobs.string(label: 'Text', initialValue: 'Tag');
          final style = context.knobs.object.dropdown(
            label: 'Style',
            options: [EcLabelStyle.primary, EcLabelStyle.secondary],
            labelBuilder:
                (value) =>
                    value == EcLabelStyle.primary ? 'Primary' : 'Secondary',
          );
          final padding = context.knobs.double.slider(
            label: 'Padding',
            initialValue: 4,
            min: 0,
            max: 20,
          );
          final borderRadius = context.knobs.double.slider(
            label: 'Border Radius',
            initialValue: 15,
            min: 0,
            max: 40,
          );

          return ECUiWidgetbook(
            copyCode: '''
EcLabel(
  text: '$text',
  style: EcLabelStyle.${style.name},
  padding: EdgeInsets.all($padding),
  borderRadius: $borderRadius,
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcLabel(
                    text: text,
                    style: style,
                    padding: EdgeInsets.all(padding),
                    borderRadius: borderRadius,
                  ),
                  const SizedBox(height: 16),
                  EcLabelWrap(
                    labels: [
                      EcLabel(
                        text: 'Small',
                        style: EcLabelStyle.primary,
                        padding: EdgeInsets.all(padding),
                        borderRadius: borderRadius,
                      ),
                      EcLabel(
                        text: 'Tag',
                        style: EcLabelStyle.secondary,
                        padding: EdgeInsets.all(padding),
                        borderRadius: borderRadius,
                      ),
                      EcLabel(
                        text: 'Compact',
                        style: EcLabelStyle.primary,
                        padding: EdgeInsets.all(padding),
                        borderRadius: borderRadius,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Sale label',
        builder: (context) {
          final discount = context.knobs.string(
            label: 'Discount',
            initialValue: '-20%',
          );
          final style = context.knobs.object.dropdown(
            label: 'Style',
            options: [EcLabelStyle.primary, EcLabelStyle.secondary],
            labelBuilder:
                (value) =>
                    value == EcLabelStyle.primary ? 'Primary' : 'Secondary',
          );

          return ECUiWidgetbook(
            copyCode: '''
EcLabel(
  text: '$discount',
  style: EcLabelStyle.${style.name},
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcLabel(text: discount, style: style),
                  const SizedBox(height: 16),
                  EcLabelRow(
                    labels: [
                      EcLabel(text: '-20%', style: EcLabelStyle.primary),
                      EcLabel(text: '-50%', style: EcLabelStyle.secondary),
                      EcLabel(text: '-70%', style: EcLabelStyle.primary),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'New label',
        builder: (context) {
          final text = context.knobs.string(label: 'Text', initialValue: 'NEW');
          final style = context.knobs.object.dropdown(
            label: 'Style',
            options: [EcLabelStyle.primary, EcLabelStyle.secondary],
            labelBuilder:
                (value) =>
                    value == EcLabelStyle.primary ? 'Primary' : 'Secondary',
          );

          return ECUiWidgetbook(
            copyCode: '''
EcLabel(
  text: '$text',
  style: EcLabelStyle.${style.name},
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcLabel(text: text, style: style),
                  const SizedBox(height: 16),
                  EcLabelColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    labels: [
                      EcLabel(text: 'NEW', style: EcLabelStyle.primary),
                      EcLabel(
                        text: 'NEW ARRIVAL',
                        style: EcLabelStyle.secondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Hot label',
        builder: (context) {
          final text = context.knobs.string(label: 'Text', initialValue: 'HOT');
          final style = context.knobs.object.dropdown(
            label: 'Style',
            options: [EcLabelStyle.primary, EcLabelStyle.secondary],
            labelBuilder:
                (value) =>
                    value == EcLabelStyle.primary ? 'Primary' : 'Secondary',
          );

          return ECUiWidgetbook(
            copyCode: '''
EcLabel(
  text: '$text',
  style: EcLabelStyle.${style.name},
)
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcLabel(text: text, style: style),
                  const SizedBox(height: 16),
                  EcLabelWrap(
                    labels: [
                      EcLabel(text: 'HOT', style: EcLabelStyle.primary),
                      EcLabel(text: 'TRENDING', style: EcLabelStyle.secondary),
                      EcLabel(text: 'POPULAR', style: EcLabelStyle.primary),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}
