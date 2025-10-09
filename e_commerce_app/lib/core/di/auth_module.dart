import 'package:ec_core/ec_core.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/supabase_auth_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../presentations/login/bloc/login_bloc.dart';

/// Dependency injection module for authentication-related dependencies
class AuthModule {
  static final GetIt _getIt = GetIt.instance;

  /// Register authentication dependencies with Supabase
  static void registerDependencies() {
    // Register Supabase repository
    _getIt.registerLazySingleton<AuthRepository>(
      () => SupabaseAuthRepository(
        apiClient: DI.get<ApiClient>(instanceName: 'main'),
        userSessionBox:
            DI.get<EcLocalDatabase>(instanceName: 'main').userSessionBox,
      ),
    );

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

  /// Check if dependencies are registered
  static bool get isRegistered => _getIt.isRegistered<AuthRepository>();
}
