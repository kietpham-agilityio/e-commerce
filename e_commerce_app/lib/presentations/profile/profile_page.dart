import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/di/app_module.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/domain/usecases/login_usecase.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ProfileBloc(logoutUseCase: AppModule.getIt<LogoutUseCase>()),
      child: Scaffold(
        appBar: EcAppBar(title: const EcHeadlineSmallText('Profile')),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.status == ProfileStatus.logoutSuccess) {
              // Navigate to login page after successful logout
              context.go(UserAppPaths.login.path);
            } else if (state.status == ProfileStatus.failure) {
              // Show error message
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }
            }
          },
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, appState) {
              final isProfileEnabled =
                  appState.flags.enableProfilePage ?? false;

              return isProfileEnabled
                  ? BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, profileState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const EcBodyLargeText(
                              'Profile content will be displayed here',
                            ),
                            const SizedBox(height: 24),
                            EcElevatedButton(
                              text: 'Logout',
                              onPressed:
                                  profileState.status == ProfileStatus.loading
                                      ? null
                                      : () {
                                        BlocProvider.of<ProfileBloc>(
                                          context,
                                        ).add(const OnLogoutButtonPressed());
                                      },
                              child:
                                  profileState.status == ProfileStatus.loading
                                      ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                      : null,
                            ),
                          ],
                        ),
                      );
                    },
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
        ),
      ),
    );
  }
}
