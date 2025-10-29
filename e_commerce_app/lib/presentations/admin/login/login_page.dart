import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
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
    );
  }
}

class _EmailInput extends StatefulWidget {
  const _EmailInput();

  @override
  State<_EmailInput> createState() => __EmailInputState();
}

class __EmailInputState extends State<_EmailInput> {
  @override
  Widget build(BuildContext context) {
    return EcEmailField(
      focusNode: FocusNode(),
      hintText: 'muffin.sweet@gmail.com',
      labelText: '', // No label for clean design
      semanticsLabel: 'Email input field',
      onChanged: (email) {},
      onValidation: () {},
      textInputAction: TextInputAction.next,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return EcPasswordField(
      focusNode: FocusNode(),
      hintText: 'Password',
      labelText: '', // No label for clean design
      semanticsLabel: 'Password input field',
      onChanged: (password) {},
      onValidation: () {},
      textInputAction: TextInputAction.done,
    );
  }
}

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
    return EcElevatedButton(text: 'LOGIN', onPressed: () {});
  }
}

/// Social login section
class _SocialLoginSection extends StatelessWidget {
  const _SocialLoginSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
              onPressed: () {},
              width: 92,
              height: 64,
              borderRadius: 24,
              backgroundColor: colorScheme.onPrimary,
            ),
            const SizedBox(width: 16),
            EcIconButton(
              icon: EcAssets.facebook(),
              onPressed: () {},
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
  }
}
