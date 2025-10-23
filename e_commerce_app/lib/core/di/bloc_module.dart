import 'package:ec_core/ec_core.dart';
import 'package:get_it/get_it.dart';

import '../../domain/usecases/feature_flag_usecase.dart';
import '../bloc/app_bloc.dart';

/// BLoC module for registering application BLoCs
class BlocModule {
  static final GetIt _getIt = GetIt.instance;

  /// Register all BLoCs
  static void registerBlocs() {
    // Register FeatureFlagService as singleton (from ec_core)
    if (!_getIt.isRegistered<FeatureFlagService>()) {
      _getIt.registerSingleton<FeatureFlagService>(FeatureFlagService.instance);
    }

    // Register AppBloc as factory (new instance each time)
    // This allows multiple BlocProvider to create their own instances
    _getIt.registerFactory<AppBloc>(
      () => AppBloc(
        featureFlagService: _getIt<FeatureFlagService>(),
        getFeatureFlagUseCase: _getIt<GetFeatureFlagUseCase>(),
        updateFeatureFlagUseCase: _getIt<UpdateFeatureFlagUseCase>(),
        logFeatureFlagChangeUseCase: _getIt<LogFeatureFlagChangeUseCase>(),
      ),
    );
  }

  /// Get AppBloc instance
  static AppBloc get appBloc => _getIt<AppBloc>();

  /// Get FeatureFlagService instance
  static FeatureFlagService get featureFlagService =>
      _getIt<FeatureFlagService>();

  /// Check if BLoCs are registered
  static bool get isRegistered => _getIt.isRegistered<AppBloc>();

  /// Reset all BLoCs (useful for testing)
  static void reset() {
    if (_getIt.isRegistered<AppBloc>()) {
      _getIt.unregister<AppBloc>();
    }
    if (_getIt.isRegistered<FeatureFlagService>()) {
      _getIt.unregister<FeatureFlagService>();
    }
  }
}
