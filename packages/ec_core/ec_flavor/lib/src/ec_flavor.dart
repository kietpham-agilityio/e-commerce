/// Enum defining different flavors for the E-Commerce application
enum EcFlavor {
  /// Admin flavor with admin-specific configurations
  admin(
    bundleId: 'com.example.ecommerce.admin',
    appName: 'E-Commerce Admin',
    apiBaseUrl: 'https://admin-api.ecommerce.com',
    environment: 'production',
  ),

  /// User flavor with user-specific configurations
  user(
    bundleId: 'com.example.ecommerce.user',
    appName: 'E-Commerce',
    apiBaseUrl: 'https://api.ecommerce.com',
    environment: 'production',
  );

  /// Constructor for EcFlavor
  const EcFlavor({
    required this.bundleId,
    required this.appName,
    required this.apiBaseUrl,
    required this.environment,
  });

  /// Bundle identifier for the app
  final String bundleId;

  /// Application name
  final String appName;

  /// Base URL for API calls
  final String apiBaseUrl;

  /// Environment name (dev, staging, production)
  final String environment;

  /// Check if current flavor is admin
  bool get isAdmin => this == EcFlavor.admin;

  /// Check if current flavor is user
  bool get isUser => this == EcFlavor.user;

  /// Check if current flavor is development environment
  bool get isDevelopment => environment == 'dev';

  /// Check if current flavor is staging environment
  bool get isStaging => environment == 'staging';

  /// Check if current flavor is production environment
  bool get isProduction => environment == 'production';

  /// Get the current flavor from environment or build configuration
  /// This method tries to detect the current flavor from build-time environment variables
  /// or falls back to the default user flavor
  static EcFlavor get current {
    // Try to get flavor from environment or use a default approach
    // Since FlutterFlavor.instance.name might not be available at compile time,
    // we'll use a different approach
    try {
      // Check if we can access the flavor through environment variables
      const flavorName = String.fromEnvironment('FLAVOR', defaultValue: 'user');
      return EcFlavor.fromString(flavorName);
    } catch (e) {
      // Fallback to user flavor if anything goes wrong
      return EcFlavor.user;
    }
  }

  /// Get flavor by name
  static EcFlavor fromString(String name) {
    return EcFlavor.values.firstWhere(
      (flavor) => flavor.name == name,
      orElse: () => EcFlavor.user,
    );
  }

  /// Get all available flavors
  static List<EcFlavor> get all => EcFlavor.values;

  /// Get flavor display name
  String get displayName {
    switch (this) {
      case EcFlavor.admin:
        return 'Admin';
      case EcFlavor.user:
        return 'User';
    }
  }

  /// Get flavor description
  String get description {
    switch (this) {
      case EcFlavor.admin:
        return 'Administrator version with full access and debugging capabilities';
      case EcFlavor.user:
        return 'Standard user version with essential features';
    }
  }

  /// Get flavor icon name
  String get iconName {
    switch (this) {
      case EcFlavor.admin:
        return 'admin_icon';
      case EcFlavor.user:
        return 'user_icon';
    }
  }

  /// Get flavor color scheme
  String get colorScheme {
    switch (this) {
      case EcFlavor.admin:
        return 'admin_theme';
      case EcFlavor.user:
        return 'user_theme';
    }
  }
}
