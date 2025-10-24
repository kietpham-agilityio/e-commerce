import 'mock_scenario.dart';

/// Represents an API endpoint and its available mock scenarios.
class MockApi<T> {
  const MockApi({
    required this.name,
    required this.path,
    required this.scenarios,
  });

  /// Human-readable API name, e.g., "Posts" or "Get Items".
  final String name;

  /// Endpoint path, e.g., ["/posts"].
  final List<String> path;

  /// Available scenarios for this API.
  final List<MockScenario<T>> scenarios;
}
