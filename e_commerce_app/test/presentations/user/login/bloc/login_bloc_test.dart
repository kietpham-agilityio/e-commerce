import 'package:bloc_test/bloc_test.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_themes/themes/widgets/textfield/form_input.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:e_commerce_app/domain/entities/user.dart';
import 'package:e_commerce_app/domain/usecases/login_usecase.dart';
import 'package:e_commerce_app/presentations/user/login/bloc/login_bloc.dart';

/// Mock class for LoginUseCase
class MockLoginUseCase extends Mock implements LoginUseCase {}

/// Mock class for LoginWithGoogleUseCase
class MockLoginWithGoogleUseCase extends Mock
    implements LoginWithGoogleUseCase {}

/// Mock class for LoginWithFacebookUseCase
class MockLoginWithFacebookUseCase extends Mock
    implements LoginWithFacebookUseCase {}

void main() {
  group('LoginBloc', () {
    late MockLoginUseCase mockLoginUseCase;
    late MockLoginWithGoogleUseCase mockLoginWithGoogleUseCase;
    late MockLoginWithFacebookUseCase mockLoginWithFacebookUseCase;
    late LoginBloc loginBloc;

    const validEmail = 'user@example.com';
    const validPassword = 'Password123!';
    const invalidPassword = '123';

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      mockLoginWithGoogleUseCase = MockLoginWithGoogleUseCase();
      mockLoginWithFacebookUseCase = MockLoginWithFacebookUseCase();

      loginBloc = LoginBloc(
        loginUseCase: mockLoginUseCase,
        loginWithGoogleUseCase: mockLoginWithGoogleUseCase,
        loginWithFacebookUseCase: mockLoginWithFacebookUseCase,
      );
    });

    tearDown(() {
      loginBloc.close();
    });

    test('initial state is correct', () {
      expect(
        loginBloc.state,
        const LoginState(
          status: LoginStatus.initial,
          email: EcEmailInput.pure(),
          password: EcPasswordInput.pure(),
          isValid: false,
        ),
      );
    });

    group('LoginEmailChanged', () {
      blocTest<LoginBloc, LoginState>(
        'emits state with updated email when email changes',
        build: () => loginBloc,
        act: (bloc) => bloc.add(const LoginEmailChanged(validEmail)),
        verify: (bloc) {
          expect(bloc.state.email.value, validEmail);
          expect(bloc.state.password.value, isEmpty);
          expect(bloc.state.isValid, false);
          expect(bloc.state.errorMessage, isNull);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'clears error message when email changes',
        seed:
            () => LoginState(
              email: const EcEmailInput.dirty(validEmail),
              password: const EcPasswordInput.dirty(validPassword),
              status: LoginStatus.failure,
              errorMessage: 'Some error',
            ),
        build: () => loginBloc,
        act: (bloc) => bloc.add(const LoginEmailChanged('new@example.com')),
        verify: (bloc) {
          expect(bloc.state.email.value, 'new@example.com');
          expect(bloc.state.password.value, validPassword);
          expect(bloc.state.status, LoginStatus.failure);
          expect(bloc.state.isValid, true);
          expect(bloc.state.errorMessage, isNull);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'updates isValid to true when both email and password are valid',
        seed:
            () => LoginState(
              email: const EcEmailInput.pure(),
              password: const EcPasswordInput.dirty(validPassword),
              isValid: false,
            ),
        build: () => loginBloc,
        act: (bloc) => bloc.add(const LoginEmailChanged(validEmail)),
        verify: (bloc) {
          expect(bloc.state.email.value, validEmail);
          expect(bloc.state.password.value, validPassword);
          expect(bloc.state.isValid, true);
          expect(bloc.state.errorMessage, isNull);
        },
      );
    });

    group('LoginPasswordChanged', () {
      blocTest<LoginBloc, LoginState>(
        'emits state with updated password when password changes',
        build: () => loginBloc,
        act: (bloc) => bloc.add(const LoginPasswordChanged(validPassword)),
        verify: (bloc) {
          expect(bloc.state.password.value, validPassword);
          expect(bloc.state.email.value, isEmpty);
          expect(bloc.state.isValid, false);
          expect(bloc.state.errorMessage, isNull);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'clears error message when password changes',
        seed:
            () => LoginState(
              email: const EcEmailInput.dirty(validEmail),
              password: const EcPasswordInput.dirty(validPassword),
              status: LoginStatus.failure,
              errorMessage: 'Some error',
            ),
        build: () => loginBloc,
        act: (bloc) => bloc.add(const LoginPasswordChanged('NewPass123!')),
        verify: (bloc) {
          expect(bloc.state.email.value, validEmail);
          expect(bloc.state.password.value, 'NewPass123!');
          expect(bloc.state.status, LoginStatus.failure);
          expect(bloc.state.isValid, true);
          expect(bloc.state.errorMessage, isNull);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'updates isValid to true when both email and password are valid',
        seed:
            () => LoginState(
              email: const EcEmailInput.dirty(validEmail),
              password: const EcPasswordInput.pure(),
              isValid: false,
            ),
        build: () => loginBloc,
        act: (bloc) => bloc.add(const LoginPasswordChanged(validPassword)),
        verify: (bloc) {
          expect(bloc.state.email.value, validEmail);
          expect(bloc.state.password.value, validPassword);
          expect(bloc.state.isValid, true);
          expect(bloc.state.errorMessage, isNull);
        },
      );
    });

    group('LoginEmailUnfocused', () {
      blocTest<LoginBloc, LoginState>(
        'validates email when email field loses focus',
        seed:
            () => LoginState(
              email: const EcEmailInput.pure(),
              password: const EcPasswordInput.pure(),
              isValid: false,
            ),
        build: () => loginBloc,
        act: (bloc) => bloc.add(LoginEmailUnfocused()),
        verify: (bloc) {
          expect(bloc.state.email.value, isEmpty);
          expect(bloc.state.password.value, isEmpty);
          expect(bloc.state.isValid, false);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'validates email and updates isValid when email loses focus',
        seed:
            () => LoginState(
              email: const EcEmailInput.pure(),
              password: const EcPasswordInput.dirty(validPassword),
              isValid: false,
            ),
        build: () {
          loginBloc.add(const LoginEmailChanged(validEmail));
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginEmailUnfocused()),
        skip: 1,
        verify: (bloc) {
          expect(bloc.state.email.value, validEmail);
          expect(bloc.state.password.value, validPassword);
          expect(bloc.state.isValid, true);
        },
      );
    });

    group('LoginPasswordUnfocused', () {
      blocTest<LoginBloc, LoginState>(
        'validates password when password field loses focus',
        seed:
            () => LoginState(
              email: const EcEmailInput.pure(),
              password: const EcPasswordInput.pure(),
              isValid: false,
            ),
        build: () => loginBloc,
        act: (bloc) => bloc.add(LoginPasswordUnfocused()),
        verify: (bloc) {
          expect(bloc.state.email.value, isEmpty);
          expect(bloc.state.password.value, isEmpty);
          expect(bloc.state.isValid, false);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'validates password and updates isValid when password loses focus',
        seed:
            () => LoginState(
              email: const EcEmailInput.dirty(validEmail),
              password: const EcPasswordInput.pure(),
              isValid: false,
            ),
        build: () {
          loginBloc.add(const LoginPasswordChanged(validPassword));
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginPasswordUnfocused()),
        skip: 1,
        verify: (bloc) {
          expect(bloc.state.email.value, validEmail);
          expect(bloc.state.password.value, validPassword);
          expect(bloc.state.isValid, true);
        },
      );
    });

    group('LoginSubmitted', () {
      final user = User(id: '1', email: validEmail, fullName: 'Test User');

      blocTest<LoginBloc, LoginState>(
        'does not emit loading state when form is invalid',
        seed:
            () => LoginState(
              email: const EcEmailInput.dirty('invalid-email'),
              password: const EcPasswordInput.dirty(invalidPassword),
              isValid: false,
            ),
        build: () => loginBloc,
        act: (bloc) => bloc.add(LoginSubmitted()),
        verify: (bloc) {
          expect(bloc.state.email.value, 'invalid-email');
          expect(bloc.state.password.value, invalidPassword);
          expect(bloc.state.isValid, false);
          expect(bloc.state.status, LoginStatus.initial);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'emits success state when login succeeds',
        seed:
            () => LoginState(
              email: const EcEmailInput.dirty(validEmail),
              password: const EcPasswordInput.dirty(validPassword),
              isValid: true,
            ),
        build: () {
          when(
            () => mockLoginUseCase.call(
              email: validEmail,
              password: validPassword,
            ),
          ).thenAnswer((_) async => user);
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginSubmitted()),
        expect:
            () => [
              predicate<LoginState>(
                (state) =>
                    state.email.value == validEmail &&
                    state.password.value == validPassword &&
                    state.isValid == true,
              ),
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.loading &&
                    state.isValid == true &&
                    state.errorMessage == null,
              ),
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.success &&
                    state.isValid == true,
              ),
            ],
        verify: (_) {
          verify(
            () => mockLoginUseCase.call(
              email: validEmail,
              password: validPassword,
            ),
          ).called(1);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'emits failure state when login throws Failure',
        seed:
            () => LoginState(
              email: const EcEmailInput.dirty(validEmail),
              password: const EcPasswordInput.dirty(validPassword),
              isValid: true,
            ),
        build: () {
          final failure = Failure('Invalid credentials');
          when(
            () => mockLoginUseCase.call(
              email: validEmail,
              password: validPassword,
            ),
          ).thenThrow(failure);
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginSubmitted()),
        expect:
            () => [
              predicate<LoginState>(
                (state) =>
                    state.email.value == validEmail &&
                    state.password.value == validPassword &&
                    state.isValid == true,
              ),
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.loading &&
                    state.isValid == true &&
                    state.errorMessage == null,
              ),
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.failure &&
                    state.isValid == true &&
                    state.errorMessage != null &&
                    state.errorMessage!.contains('Invalid'),
              ),
            ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits failure state when login throws exception',
        seed:
            () => LoginState(
              email: const EcEmailInput.dirty(validEmail),
              password: const EcPasswordInput.dirty(validPassword),
              isValid: true,
            ),
        build: () {
          when(
            () => mockLoginUseCase.call(
              email: validEmail,
              password: validPassword,
            ),
          ).thenThrow(Exception('Network error'));
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginSubmitted()),
        expect:
            () => [
              predicate<LoginState>(
                (state) =>
                    state.email.value == validEmail &&
                    state.password.value == validPassword &&
                    state.isValid == true,
              ),
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.loading &&
                    state.isValid == true &&
                    state.errorMessage == null,
              ),
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.failure &&
                    state.isValid == true &&
                    state.errorMessage != null &&
                    state.errorMessage!.contains('Unsupported'),
              ),
            ],
      );
    });

    group('LoginWithGooglePressed', () {
      final user = User(id: '1', email: validEmail, fullName: 'Test User');

      blocTest<LoginBloc, LoginState>(
        'emits success state when Google login succeeds',
        build: () {
          when(
            () => mockLoginWithGoogleUseCase.call(),
          ).thenAnswer((_) async => user);
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginWithGooglePressed()),
        expect:
            () => [
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.loading &&
                    state.errorMessage == null,
              ),
              predicate<LoginState>(
                (state) => state.status == LoginStatus.success,
              ),
            ],
        verify: (_) {
          verify(() => mockLoginWithGoogleUseCase.call()).called(1);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'emits failure state when Google login throws Failure',
        build: () {
          final failure = Failure('Failed to authenticate with Google');
          when(() => mockLoginWithGoogleUseCase.call()).thenThrow(failure);
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginWithGooglePressed()),
        expect:
            () => [
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.loading &&
                    state.errorMessage == null,
              ),
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.failure &&
                    state.errorMessage != null &&
                    state.errorMessage!.contains('Failed'),
              ),
            ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits failure state when Google login throws exception',
        build: () {
          when(
            () => mockLoginWithGoogleUseCase.call(),
          ).thenThrow(Exception('Google sign in error'));
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginWithGooglePressed()),
        expect:
            () => [
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.loading &&
                    state.errorMessage == null,
              ),
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.failure &&
                    state.errorMessage != null &&
                    state.errorMessage!.contains('Unsupported'),
              ),
            ],
      );
    });

    group('LoginWithFacebookPressed', () {
      final user = User(id: '1', email: validEmail, fullName: 'Test User');

      blocTest<LoginBloc, LoginState>(
        'emits success state when Facebook login succeeds',
        build: () {
          when(
            () => mockLoginWithFacebookUseCase.call(),
          ).thenAnswer((_) async => user);
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginWithFacebookPressed()),
        expect:
            () => [
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.loading &&
                    state.errorMessage == null,
              ),
              predicate<LoginState>(
                (state) => state.status == LoginStatus.success,
              ),
            ],
        verify: (_) {
          verify(() => mockLoginWithFacebookUseCase.call()).called(1);
        },
      );

      blocTest<LoginBloc, LoginState>(
        'emits failure state when Facebook login throws Failure',
        build: () {
          final failure = Failure('Failed to authenticate with Facebook');
          when(() => mockLoginWithFacebookUseCase.call()).thenThrow(failure);
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginWithFacebookPressed()),
        expect:
            () => [
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.loading &&
                    state.errorMessage == null,
              ),
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.failure &&
                    state.errorMessage != null &&
                    state.errorMessage!.contains('Failed'),
              ),
            ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits failure state when Facebook login throws exception',
        build: () {
          when(
            () => mockLoginWithFacebookUseCase.call(),
          ).thenThrow(Exception('Facebook sign in error'));
          return loginBloc;
        },
        act: (bloc) => bloc.add(LoginWithFacebookPressed()),
        expect:
            () => [
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.loading &&
                    state.errorMessage == null,
              ),
              predicate<LoginState>(
                (state) =>
                    state.status == LoginStatus.failure &&
                    state.errorMessage != null &&
                    state.errorMessage!.contains('Unsupported'),
              ),
            ],
      );
    });

    group('LoginForgotPasswordPressed', () {
      blocTest<LoginBloc, LoginState>(
        'does not change state when forgot password is pressed',
        build: () => loginBloc,
        act: (bloc) => bloc.add(LoginForgotPasswordPressed()),
        expect: () => [],
      );
    });
  });
}
