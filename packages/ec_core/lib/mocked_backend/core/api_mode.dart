/// API mode for switching between real and mock APIs
enum ApiMode { real, mock }

/// Service to manage API mode switching
class ApiModeService {
  ApiModeService._internal();

  static final ApiModeService _instance = ApiModeService._internal();

  factory ApiModeService() => _instance;

  static ApiMode _currentMode = ApiMode.real;

  static String? _currentScenarioType;

  /// Map of API path to scenario type for per-API scenario management
  static final Map<String, String> _apiScenarios = {};

  /// Get current API mode
  static ApiMode get currentMode => _currentMode;

  /// Get current scenario type (legacy - for backward compatibility)
  static String? get currentScenarioType => _currentScenarioType;

  /// Get scenario type for specific API path
  static String? getScenarioForApi(String apiPath) {
    return _apiScenarios[apiPath] ?? _currentScenarioType;
  }

  /// Set API mode
  static void setMode(ApiMode mode) {
    _currentMode = mode;
  }

  /// Set both mode and scenario type (legacy - affects all APIs)
  static void setModeAndScenario(ApiMode mode, String? scenarioType) {
    _currentMode = mode;
    _currentScenarioType = scenarioType;
  }

  /// Set scenario for specific API path
  static void setScenarioForApi(
    List<String> apiPaths,
    ApiMode mode,
    String? scenarioType,
  ) {
    _currentMode = mode;

    for (final path in apiPaths) {
      if (scenarioType != null) {
        _apiScenarios[path] = scenarioType;
      } else {
        _apiScenarios.remove(path);
      }
    }
  }

  /// Clear all API-specific scenarios
  static void clearApiScenarios() {
    _apiScenarios.clear();
  }

  /// Check if currently using mock API
  static bool get isMockMode => _currentMode == ApiMode.mock;

  /// Check if currently using real API
  static bool get isRealMode => _currentMode == ApiMode.real;
}
