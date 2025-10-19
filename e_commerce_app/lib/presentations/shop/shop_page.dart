import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/bloc/app_state.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcAppBar(title: const EcHeadlineSmallText('Shop')),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final isShopEnabled = state.flags.enableShopPage ?? false;

          return isShopEnabled
              ? const Center(
                child: EcBodyLargeText('Shop content will be displayed here'),
              )
              : const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: EcBodyLargeText(
                    'The Shop feature is not available for now',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
        },
      ),
    );
  }
}
