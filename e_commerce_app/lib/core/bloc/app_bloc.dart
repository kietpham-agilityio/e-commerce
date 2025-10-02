import 'package:ec_core/ec_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_event.dart';
import 'app_state.dart';

/// AppBloc manages global app state including feature flags
class AppBloc extends Bloc<AppEvent, AppState> {
  final FeatureFlagService _featureFlagService;

  AppBloc({required FeatureFlagService featureFlagService})
    : _featureFlagService = featureFlagService,
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
  ) {
    // Update the service
    _featureFlagService.updateFlags(event.flags);

    // Emit new state
    emit(state.copyWith(flags: event.flags));
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
