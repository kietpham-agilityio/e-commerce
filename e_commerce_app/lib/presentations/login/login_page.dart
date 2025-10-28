import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/di/app_module.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/domain/usecases/login_usecase.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/login_bloc.dart';

/// Login page with email/password and social login options
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => LoginBloc(
            loginUseCase: AppModule.getIt<LoginUseCase>(),
            loginWithGoogleUseCase: AppModule.getIt<LoginWithGoogleUseCase>(),
            loginWithFacebookUseCase:
                AppModule.getIt<LoginWithFacebookUseCase>(),
          ),
      child: const LoginView(),
    );
  }
}

/// Login view with form and UI
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          // Fetch feature flags from API after successful login
          BlocProvider.of<AppBloc>(
            context,
          ).add(const AppFeatureFlagsFetchedFromApi());

          // Navigate to home on successful login
          context.pushReplacementNamed(UserAppPaths.home.name);
        } else if (state.status == LoginStatus.failure) {
          // Show error message
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.surfaceDim,
        appBar: EcAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colorScheme.surfaceDim,
          elevation: 0,

          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: EcHeadlineLargeText('Login', fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // Unfocus all text fields when tapping outside
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const SizedBox(height: 40),
                  Spacer(),

                  // Email and password form
                  const _EmailInput(),
                  // const SizedBox(height: 20),
                  const _PasswordInput(),
                  const SizedBox(height: 16),

                  // Forgot password link
                  const _ForgotPasswordButton(),
                  const SizedBox(height: 32),

                  // Login button
                  const _LoginButton(),
                  Spacer(),

                  // Social login section
                  const _SocialLoginSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Email input field with validation
class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return EcEmailField(
          focusNode: FocusNode(),
          hintText: 'muffin.sweet@gmail.com',
          labelText: '', // No label for clean design
          semanticsLabel: 'Email input field',
          errorMessage: state.email.displayError?.getEmailMessage(),
          onChanged:
              (email) => BlocProvider.of<LoginBloc>(
                context,
              ).add(LoginEmailChanged(email)),
          onValidation:
              () => BlocProvider.of<LoginBloc>(
                context,
              ).add(const LoginEmailUnfocused()),
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

/// Password input field with validation
class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return EcPasswordField(
          focusNode: FocusNode(),
          hintText: 'Password',
          labelText: '', // No label for clean design
          semanticsLabel: 'Password input field',
          errorMessage: state.password.displayError?.getPasswordMessage(),
          onChanged:
              (password) => BlocProvider.of<LoginBloc>(
                context,
              ).add(LoginPasswordChanged(password)),
          onValidation:
              () => BlocProvider.of<LoginBloc>(
                context,
              ).add(const LoginPasswordUnfocused()),
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

/// Forgot password button
class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          // TODO: Navigate to forgot password page
          BlocProvider.of<LoginBloc>(
            context,
          ).add(const LoginForgotPasswordPressed());
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            EcBodySmallText(
              'Forgot your password?',
              color: colorScheme.secondary,
            ),
            const SizedBox(width: 4),
            EcAssets.arrowRightFilled(color: colorScheme.primary),
          ],
        ),
      ),
    );
  }
}

/// Login button with loading state
class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen:
          (previous, current) =>
              previous.status != current.status ||
              previous.isValid != current.isValid,
      builder: (context, state) {
        final isLoading = state.status == LoginStatus.loading;
        final isValid = state.isValid && !isLoading;

        return EcElevatedButton(
          text: 'LOGIN',
          onPressed:
              isValid
                  ? () => BlocProvider.of<LoginBloc>(
                    context,
                  ).add(const LoginSubmitted())
                  : null,
          child:
              isLoading
                  ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                  : null,
        );
      },
    );
  }
}

/// Social login section
class _SocialLoginSection extends StatelessWidget {
  const _SocialLoginSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final isLoading = state.status == LoginStatus.loading;

        return Column(
          children: [
            EcBodyMediumText('Or login with social account'),
            const SizedBox(height: 24),

            // Social login buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EcIconButton(
                  icon: EcAssets.google(),
                  onPressed:
                      isLoading
                          ? null
                          : () => BlocProvider.of<LoginBloc>(
                            context,
                          ).add(const LoginWithGooglePressed()),
                  width: 92,
                  height: 64,
                  borderRadius: 24,
                  backgroundColor: colorScheme.onPrimary,
                ),
                const SizedBox(width: 16),
                EcIconButton(
                  icon: EcAssets.facebook(),
                  onPressed:
                      isLoading
                          ? null
                          : () => BlocProvider.of<LoginBloc>(
                            context,
                          ).add(const LoginWithFacebookPressed()),
                  // size: 56,
                  borderRadius: 24,
                  backgroundColor: colorScheme.onPrimary,
                  width: 92,
                  height: 64,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
