import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcAppBar(title: const EcHeadlineSmallText('Profile')),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final isProfileEnabled = state.flags.enableProfilePage ?? false;

          return isProfileEnabled
              ? const Center(
                child: EcBodyLargeText(
                  'Profile content will be displayed here',
                ),
              )
              : const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: EcBodyLargeText(
                    'The Profile feature is not available for now',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
        },
      ),
    );
  }
}
