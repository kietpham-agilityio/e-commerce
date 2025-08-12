/// Enum representing different application flavors
enum AppFlavor {
  /// Development environment
  dev('dev', 'Development'),
  
  /// Staging environment
  staging('staging', 'Staging'),
  
  /// Production environment
  production('production', 'Production');

  const AppFlavor(this.value, this.displayName);

  /// String value of the flavor
  final String value;
  
  /// Human-readable display name
  final String displayName;

  /// Get flavor from string value
  static AppFlavor fromString(String value) {
    return AppFlavor.values.firstWhere(
      (flavor) => flavor.value == value,
      orElse: () => AppFlavor.dev,
    );
  }

  /// Check if this is development flavor
  bool get isDev => this == AppFlavor.dev;
  
  /// Check if this is staging flavor
  bool get isStaging => this == AppFlavor.staging;
  
  /// Check if this is production flavor
  bool get isProduction => this == AppFlavor.production;

  @override
  String toString() => value;
}
