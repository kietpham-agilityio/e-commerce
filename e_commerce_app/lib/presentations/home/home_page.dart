import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:ec_l10n/ec_l10n.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcAppBar(
        title: EcHeadlineSmallText(
          AppLocale.of(context)?.generalAppTitle ?? 'Home',
        ),
      ),
      body: Center(
        child: EcElevatedButton(
          text: AppLocale.of(context)?.generalAppTitle ?? 'Home',
          onPressed: () {
            context.pushNamed(AppPaths.productDetails.name);
          },
        ),
      ),
    );
  }
}
