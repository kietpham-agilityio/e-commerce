import 'package:ec_core/ec_core.dart';

import '../../domain/usecases/feature_flag_usecase.dart';
import '../bloc/debug_bloc.dart';

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
    _getIt.registerFactory<DebugBloc>(
      () => DebugBloc(
        featureFlagService: _getIt<FeatureFlagService>(),
        getFeatureFlagUseCase: _getIt<GetFeatureFlagUseCase>(),
        updateFeatureFlagUseCase: _getIt<UpdateFeatureFlagUseCase>(),
      ),
    );
  }

  /// Get AppBloc instance
  static DebugBloc get appBloc => _getIt<DebugBloc>();

  /// Get FeatureFlagService instance
  static FeatureFlagService get featureFlagService =>
      _getIt<FeatureFlagService>();

  /// Check if BLoCs are registered
  static bool get isRegistered => _getIt.isRegistered<DebugBloc>();

  /// Reset all BLoCs (useful for testing)
  static void reset() {
    if (_getIt.isRegistered<DebugBloc>()) {
      _getIt.unregister<DebugBloc>();
    }
    if (_getIt.isRegistered<FeatureFlagService>()) {
      _getIt.unregister<FeatureFlagService>();
    }
  }
}
