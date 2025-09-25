import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcAppBar(title: EcHeadlineSmallText('Home')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(EcDesignIcons.icClose),
          Center(
            child: EcElevatedButton(
              text: 'Go product details page',
              onPressed: () {
                context.pushNamed(AppPaths.productDetails.name);
              },
            ),
          ),
        ],
      ),
    );
  }
}
