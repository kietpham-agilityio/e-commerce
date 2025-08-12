/// Enum representing different application flavors
enum EcFlavor {
  /// Development environment
  dev('dev', 'Development'),
  
  /// Staging environment
  staging('staging', 'Staging'),
  
  /// Production environment
  production('production', 'Production');

  const EcFlavor(this.value, this.displayName);

  /// String value of the flavor
  final String value;
  
  /// Human-readable display name
  final String displayName;

  /// Get flavor from string value
  static EcFlavor fromString(String value) {
    return EcFlavor.values.firstWhere(
      (flavor) => flavor.value == value,
      orElse: () => EcFlavor.dev,
    );
  }

  /// Check if this is development flavor
  bool get isDev => this == EcFlavor.dev;
  
  /// Check if this is staging flavor
  bool get isStaging => this == EcFlavor.staging;
  
  /// Check if this is production flavor
  bool get isProduction => this == EcFlavor.production;

  @override
  String toString() => value;
}
