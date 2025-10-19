import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/bloc/app_state.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcAppBar(title: const EcHeadlineSmallText('Bag')),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final isBagEnabled = state.flags.enableBagPage ?? false;

          return isBagEnabled
              ? const Center(
                child: EcBodyLargeText('Bag content will be displayed here'),
              )
              : const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: EcBodyLargeText(
                    'The Bag feature is not available for now',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
        },
      ),
    );
  }
}
