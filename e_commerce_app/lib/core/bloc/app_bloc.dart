import 'package:ec_core/ec_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/feature_flag_usecase.dart';

part 'app_event.dart';
part 'app_state.dart';

/// AppBloc manages global app state including feature flags
class AppBloc extends Bloc<AppEvent, AppState> {
  final FeatureFlagService _featureFlagService;
  final GetFeatureFlagUseCase _getFeatureFlagUseCase;
  final UpdateFeatureFlagUseCase _updateFeatureFlagUseCase;

  AppBloc({
    required FeatureFlagService featureFlagService,
    required GetFeatureFlagUseCase getFeatureFlagUseCase,
    required UpdateFeatureFlagUseCase updateFeatureFlagUseCase,
  }) : _featureFlagService = featureFlagService,
       _getFeatureFlagUseCase = getFeatureFlagUseCase,
       _updateFeatureFlagUseCase = updateFeatureFlagUseCase,
       super(AppState.initial()) {
    on<AppFeatureFlagsLoaded>(_onFeatureFlagsLoaded);
    on<AppFeatureFlagsFetchedFromApi>(_onFeatureFlagsFetchedFromApi);
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

  void _onFeatureFlagsFetchedFromApi(
    AppFeatureFlagsFetchedFromApi event,
    Emitter<AppState> emit,
  ) async {
    try {
      // Set loading state
      emit(state.copyWith(isLoading: true, error: null));

      // Fetch feature flags from API
      final flags = await _getFeatureFlagUseCase();

      // Update the service with fetched flags
      _featureFlagService.updateFlags(flags);

      // Emit success state
      emit(state.copyWith(flags: flags, isLoading: false, error: null));
    } catch (e) {
      // Emit error state
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to fetch feature flags: ${e.toString()}',
        ),
      );
    }
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
