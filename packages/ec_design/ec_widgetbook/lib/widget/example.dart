import 'dart:developer';

import 'package:ec_themes/ec_design.dart';
import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent exampleWidgetBooks() {
  return WidgetbookComponent(
    name: 'Example Button',
    useCases: [
      WidgetbookUseCase(
        name: 'Example',
        builder: (context) {
          final textKnobs = context.knobs.object.dropdown(
            label: 'Buttons',
            options: ['Login', 'Sign Up'],
          );

          final iconKnobs = context.knobs.object.dropdown(
            label: 'Icon',
            options: [
              EcAssets.arrowLeft(),
              EcAssets.arrowRight(),
              EcAssets.arrowRightFilled(),
              EcAssets.close(),
              EcAssets.shoppingBagFilled(),
              EcAssets.shoppingBagOutlined(),
              EcAssets.shop(),
              EcAssets.shopFilled(),
              EcAssets.shopOutlined(),
              EcAssets.home(),
              EcAssets.homeFilled(),
              EcAssets.homeOutlined(),
              EcAssets.profile(),
              EcAssets.profileFilled(),
              EcAssets.profileOutlined(),
              EcAssets.photoCamera(),
              EcAssets.flashCamera(),
              EcAssets.shareLink(),
              EcAssets.helpOutlined(),
              EcAssets.minor(),
              EcAssets.bag(),
              EcAssets.heart(),
              EcAssets.heartFilled(),
              EcAssets.heartOutlined(),
              EcAssets.search(),
              EcAssets.star(),
              EcAssets.starFilled(),
              EcAssets.starOutlined(),
              EcAssets.starFilled(),
              EcAssets.starOutlined(),
              EcAssets.starFilled(),
            ],
          );

          return ECUiWidgetbook(
            copyCode: '''
            ElevatedButton(
              child: Text(textKnobs),
                onPressed: () {
                log('Button has been pressed');
              },
            ),
            ''',
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Elevated Button'),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(textKnobs),
                      onPressed: () {
                        log('Button has been pressed');
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: null,
                      child: Text(textKnobs),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Icon Button'),
                  SizedBox(
                    child: IconButton(
                      onPressed: () {
                        log('Button has been pressed');
                      },
                      icon: iconKnobs,
                    ),
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
