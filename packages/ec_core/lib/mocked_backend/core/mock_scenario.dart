import 'api_mode.dart';

/// Represents a predefined UI state (mock scenario) for the current screen.
class MockScenario<T> {
  const MockScenario({
    required this.name,
    required this.payload,
    this.apiMode = ApiMode.real,
    this.description,
  });

  /// Short, human-readable name of the scenario.
  final String name;

  /// Optional description to clarify what this scenario shows.
  final String? description;

  /// Data needed by the screen to render this scenario.
  final T payload;

  /// API mode to use for this scenario (real or mock)
  final ApiMode apiMode;
}
