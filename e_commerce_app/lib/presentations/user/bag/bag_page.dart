import 'package:e_commerce_app/core/bloc/debug_bloc.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isBagEnabled = context.select(
      (DebugBloc bloc) => bloc.state.flags.enableBagPage ?? false,
    );
    return Scaffold(
      appBar: EcAppBar(title: const EcHeadlineSmallText('Bag')),
      body:
          isBagEnabled
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
              ),
    );
  }
}
