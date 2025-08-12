/// Environment-specific configuration for different flavors
class FlavorEnvironment {
  const FlavorEnvironment({
    required this.apiBaseUrl,
    required this.appName,
    required this.appVersion,
    required this.enableLogging,
    required this.enableAnalytics,
    required this.enableCrashlytics,
    this.timeoutSeconds = 30,
    this.maxRetries = 3,
  });

  /// Base URL for API calls
  final String apiBaseUrl;
  
  /// Application name
  final String appName;
  
  /// Application version
  final String appVersion;
  
  /// Whether logging is enabled
  final bool enableLogging;
  
  /// Whether analytics is enabled
  final bool enableAnalytics;
  
  /// Whether crashlytics is enabled
  final bool enableCrashlytics;
  
  /// Request timeout in seconds
  final int timeoutSeconds;
  
  /// Maximum retry attempts
  final int maxRetries;

  /// Create a copy with updated values
  FlavorEnvironment copyWith({
    String? apiBaseUrl,
    String? appName,
    String? appVersion,
    bool? enableLogging,
    bool? enableAnalytics,
    bool? enableCrashlytics,
    int? timeoutSeconds,
    int? maxRetries,
  }) {
    return FlavorEnvironment(
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      appName: appName ?? this.appName,
      appVersion: appVersion ?? this.appVersion,
      enableLogging: enableLogging ?? this.enableLogging,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      enableCrashlytics: enableCrashlytics ?? this.enableCrashlytics,
      timeoutSeconds: timeoutSeconds ?? this.timeoutSeconds,
      maxRetries: maxRetries ?? this.maxRetries,
    );
  }

  @override
  String toString() {
    return 'FlavorEnvironment('
        'apiBaseUrl: $apiBaseUrl, '
        'appName: $appName, '
        'appVersion: $appVersion, '
        'enableLogging: $enableLogging, '
        'enableAnalytics: $enableAnalytics, '
        'enableCrashlytics: $enableCrashlytics, '
        'timeoutSeconds: $timeoutSeconds, '
        'maxRetries: $maxRetries)';
  }
}
