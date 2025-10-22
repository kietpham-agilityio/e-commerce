import 'package:ec_core/ec_core.dart';

/// Base class for App events
abstract class AppEvent {
  const AppEvent();
}

/// Event to load initial feature flags
class AppFeatureFlagsLoaded extends AppEvent {
  const AppFeatureFlagsLoaded();
}

/// Event to update feature flags
class AppFeatureFlagsUpdated extends AppEvent {
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
class AppFeatureFlagsRefreshed extends AppEvent {
  const AppFeatureFlagsRefreshed();
}
