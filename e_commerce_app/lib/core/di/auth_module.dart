import 'package:dio/dio.dart';
import 'package:ec_core/ec_core.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/mock_auth_repository.dart';
import '../../data/repositories/supabase_auth_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../presentations/login/bloc/login_bloc.dart';

/// Authentication implementation type
enum AuthImplementation {
  /// Use mock repository for testing/development
  mock,

  /// Use Supabase for production authentication
  supabase,
}

/// Dependency injection module for authentication-related dependencies
class AuthModule {
  static final GetIt _getIt = GetIt.instance;
  static AuthImplementation _currentImplementation = AuthImplementation.mock;

  /// Register authentication dependencies
  /// 
  /// [implementation] - Choose between mock or Supabase implementation
  /// Default is mock for development. Set to supabase for production.
  static void registerDependencies({
    AuthImplementation implementation = AuthImplementation.mock,
  }) {
    _currentImplementation = implementation;

    // Register repository based on implementation type
    switch (implementation) {
      case AuthImplementation.mock:
        _getIt.registerLazySingleton<AuthRepository>(
          () => MockAuthRepository(),
        );
        break;

      case AuthImplementation.supabase:
        _getIt.registerLazySingleton<AuthRepository>(
          () => SupabaseAuthRepository(
            dio: _getIt<Dio>(),
            userSessionBox: _getIt<UserSessionBox>(),
          ),
        );
        break;
    }

    // Register use cases
    _getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(authRepository: _getIt<AuthRepository>()),
    );

    _getIt.registerLazySingleton<LoginWithGoogleUseCase>(
      () => LoginWithGoogleUseCase(authRepository: _getIt<AuthRepository>()),
    );

    _getIt.registerLazySingleton<LoginWithFacebookUseCase>(
      () => LoginWithFacebookUseCase(authRepository: _getIt<AuthRepository>()),
    );

    _getIt.registerLazySingleton<SendPasswordResetEmailUseCase>(
      () => SendPasswordResetEmailUseCase(
        authRepository: _getIt<AuthRepository>(),
      ),
    );

    // Register BLoC
    _getIt.registerFactory<LoginBloc>(
      () => LoginBloc(
        loginUseCase: _getIt<LoginUseCase>(),
        loginWithGoogleUseCase: _getIt<LoginWithGoogleUseCase>(),
        loginWithFacebookUseCase: _getIt<LoginWithFacebookUseCase>(),
      ),
    );
  }

  /// Get current authentication implementation
  static AuthImplementation get currentImplementation => _currentImplementation;

  /// Check if dependencies are registered
  static bool get isRegistered => _getIt.isRegistered<AuthRepository>();

  /// Check if using Supabase implementation
  static bool get isUsingSupabase =>
      _currentImplementation == AuthImplementation.supabase;

  /// Check if using mock implementation
  static bool get isUsingMock =>
      _currentImplementation == AuthImplementation.mock;
}
