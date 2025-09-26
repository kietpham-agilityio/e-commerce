import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcAppBar(title: EcHeadlineSmallText('Login')),
      body: Center(
        child: EcElevatedButton(
          text: 'Go to home',
          onPressed: () {
            context.pushNamed(AppPaths.home.name);
          },
        ),
      ),
    );
  }
}
