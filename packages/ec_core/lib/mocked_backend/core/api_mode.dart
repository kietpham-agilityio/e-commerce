/// API mode for switching between real and mock APIs
enum ApiMode { real, mock }

/// Service to manage API mode switching
class ApiModeService {
  ApiModeService._internal();

  static final ApiModeService _instance = ApiModeService._internal();

  factory ApiModeService() => _instance;

  static ApiMode _currentMode = ApiMode.real;

  static String? _currentScenarioType;

  /// Get current API mode
  static ApiMode get currentMode => _currentMode;

  /// Get current scenario type
  static String? get currentScenarioType => _currentScenarioType;

  /// Set API mode
  static void setMode(ApiMode mode) {
    _currentMode = mode;
  }

  /// Set both mode and scenario type
  static void setModeAndScenario(ApiMode mode, String? scenarioType) {
    _currentMode = mode;
    _currentScenarioType = scenarioType;
  }

  /// Check if currently using mock API
  static bool get isMockMode => _currentMode == ApiMode.mock;

  /// Check if currently using real API
  static bool get isRealMode => _currentMode == ApiMode.real;
}
