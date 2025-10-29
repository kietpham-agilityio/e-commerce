part of 'debug_bloc.dart';

/// Base class for App events
abstract class DebugEvent {
  const DebugEvent();
}

/// Event to load initial feature flags
class AppFeatureFlagsLoaded extends DebugEvent {
  const AppFeatureFlagsLoaded();
}

/// Event to update feature flags
class AppFeatureFlagsUpdated extends DebugEvent {
  final EcFeatureFlag flags;
  final String? flagName;
  final bool? oldValue;
  final bool? newValue;

  const AppFeatureFlagsUpdated(
    this.flags, {
    this.flagName,
    this.oldValue,
    this.newValue,
  });
}

/// Event to refresh feature flags from service
class AppFeatureFlagsRefreshed extends DebugEvent {
  const AppFeatureFlagsRefreshed();
}

/// Event to fetch feature flags from API after login
class AppFeatureFlagsFetchedFromApi extends DebugEvent {
  const AppFeatureFlagsFetchedFromApi();
}
