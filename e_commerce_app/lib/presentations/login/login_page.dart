import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/di/app_module.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/domain/usecases/login_usecase.dart';
import 'package:ec_l10n/generated/l10n.dart';
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
    final l10n = AppLocale.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          // Fetch feature flags from API after successful login
          context.read<AppBloc>().add(const AppFeatureFlagsFetchedFromApi());

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
            child: EcHeadlineLargeText(
              l10n.loginTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),

                  _EmailInput(emailFocusNode: _emailFocusNode),
                  _PasswordInput(passwordFocusNode: _passwordFocusNode),
                  const SizedBox(height: 16),

                  const _ForgotPasswordButton(),
                  const SizedBox(height: 32),

                  const _LoginButton(),
                  const Spacer(),

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
  const _EmailInput({required this.emailFocusNode});

  final FocusNode emailFocusNode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocale.of(context)!;
    final email = context.select((LoginBloc bloc) => bloc.state.email);

    return EcEmailField(
      focusNode: emailFocusNode,
      hintText: l10n.loginEmailHint,
      semanticsLabel: l10n.semanticEmailInputField,
      errorMessage: email.displayError?.getEmailMessage(),
      onChanged: (email) {
        context.read<LoginBloc>().add(LoginEmailChanged(email));
      },
      onValidation: () {
        context.read<LoginBloc>().add(const LoginEmailUnfocused());
      },
      textInputAction: TextInputAction.next,
    );
  }
}

/// Password input field with validation
class _PasswordInput extends StatelessWidget {
  const _PasswordInput({required this.passwordFocusNode});

  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocale.of(context)!;
    final password = context.select((LoginBloc bloc) => bloc.state.password);

    return EcPasswordField(
      focusNode: passwordFocusNode,
      hintText: l10n.loginPasswordHint,
      semanticsLabel: l10n.semanticPasswordInputField,
      errorMessage: password.displayError?.getPasswordMessage(),
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      onValidation: () {
        context.read<LoginBloc>().add(const LoginPasswordUnfocused());
      },
      textInputAction: TextInputAction.done,
    );
  }
}

/// Forgot password button
class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocale.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          context.read<LoginBloc>().add(const LoginForgotPasswordPressed());
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            EcBodySmallText(
              l10n.loginForgotPasswordText,
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
    final l10n = AppLocale.of(context)!;
    final isLoading = context.select(
      (LoginBloc bloc) => bloc.state.status == LoginStatus.loading,
    );
    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return EcElevatedButton(
      text: l10n.loginBtn.toUpperCase(),
      onPressed:
          isValid && !isLoading
              ? () => context.read<LoginBloc>().add(const LoginSubmitted())
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
  }
}

/// Social login section
class _SocialLoginSection extends StatelessWidget {
  const _SocialLoginSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocale.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isLoading = context.select(
      (LoginBloc bloc) => bloc.state.status == LoginStatus.loading,
    );

    return Column(
      children: [
        EcBodyMediumText(l10n.loginSocialAccountSubtitle),
        const SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialLoginButton(
              icon: EcAssets.google(),
              onPressed:
                  !isLoading
                      ? () {
                        context.read<LoginBloc>().add(
                          const LoginWithGooglePressed(),
                        );
                      }
                      : null,
              colorScheme: colorScheme,
            ),
            const SizedBox(width: 16),
            _SocialLoginButton(
              icon: EcAssets.facebook(),
              onPressed:
                  !isLoading
                      ? () {
                        context.read<LoginBloc>().add(
                          const LoginWithFacebookPressed(),
                        );
                      }
                      : null,
              colorScheme: colorScheme,
            ),
          ],
        ),
      ],
    );
  }
}

/// Social login button
class _SocialLoginButton extends StatelessWidget {
  const _SocialLoginButton({
    required this.icon,
    required this.onPressed,
    required this.colorScheme,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return EcIconButton(
      icon: icon,
      onPressed: onPressed,
      width: 92,
      height: 64,
      borderRadius: 24,
      backgroundColor: colorScheme.onPrimary,
    );
  }
}
