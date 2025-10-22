import 'package:ec_core/ec_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/feature_flag_usecase.dart';
import 'app_event.dart';
import 'app_state.dart';

/// AppBloc manages global app state including feature flags
class AppBloc extends Bloc<AppEvent, AppState> {
  final FeatureFlagService _featureFlagService;
  final UpdateFeatureFlagUseCase _updateFeatureFlagUseCase;
  final LogFeatureFlagChangeUseCase _logFeatureFlagChangeUseCase;

  AppBloc({
    required FeatureFlagService featureFlagService,
    required UpdateFeatureFlagUseCase updateFeatureFlagUseCase,
    required LogFeatureFlagChangeUseCase logFeatureFlagChangeUseCase,
  }) : _featureFlagService = featureFlagService,
       _updateFeatureFlagUseCase = updateFeatureFlagUseCase,
       _logFeatureFlagChangeUseCase = logFeatureFlagChangeUseCase,
       super(AppState.initial()) {
    on<AppFeatureFlagsLoaded>(_onFeatureFlagsLoaded);
    on<AppFeatureFlagsUpdated>(_onFeatureFlagsUpdated);
    on<AppFeatureFlagsRefreshed>(_onFeatureFlagsRefreshed);

    // Load initial flags
    add(const AppFeatureFlagsLoaded());
  }

  void _onFeatureFlagsLoaded(
    AppFeatureFlagsLoaded event,
    Emitter<AppState> emit,
  ) {
    final flags = _featureFlagService.flags;
    emit(state.copyWith(flags: flags));
  }

  void _onFeatureFlagsUpdated(
    AppFeatureFlagsUpdated event,
    Emitter<AppState> emit,
  ) async {
    try {
      // Update the service first
      _featureFlagService.updateFlags(event.flags);

      // Emit new state immediately for UI responsiveness
      emit(state.copyWith(flags: event.flags));

      // Post to database in background
      await _updateFeatureFlagUseCase(event.flags);

      // Log the change if we have specific flag information
      if (event.flagName != null) {
        await _logFeatureFlagChangeUseCase(
          flagName: event.flagName!,
          oldValue: event.oldValue,
          newValue: event.newValue,
        );
      }
    } catch (e) {
      // If database update fails, still keep the local changes
      // but emit an error state
      emit(
        state.copyWith(
          flags: event.flags,
          error: 'Failed to sync feature flags to database: ${e.toString()}',
        ),
      );
    }
  }

  void _onFeatureFlagsRefreshed(
    AppFeatureFlagsRefreshed event,
    Emitter<AppState> emit,
  ) {
    // Get latest flags from service
    final flags = _featureFlagService.flags;
    emit(state.copyWith(flags: flags));
  }
}
