/// Environment configuration for API base URLs
/// Customize these values in your main app
class EnvConfig {
  // User API base URLs
  static const String userDevUrl = 'https://api-dev.example.com';
  static const String userStagingUrl = 'https://api-staging.example.com';
  static const String userProdUrl = 'https://api.example.com';

  // Admin API base URLs
  static const String adminDevUrl = 'https://admin-api-dev.example.com';
  static const String adminStagingUrl = 'https://admin-api-staging.example.com';
  static const String adminProdUrl = 'https://admin-api.example.com';

  // Get user base URL by environment
  static String getUserBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
      case 'development':
        return userDevUrl;
      case 'staging':
        return userStagingUrl;
      case 'prod':
      case 'production':
        return userProdUrl;
      default:
        return userDevUrl;
    }
  }

  // Get admin base URL by environment
  static String getAdminBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
      case 'development':
        return adminDevUrl;
      case 'staging':
        return adminStagingUrl;
      case 'prod':
      case 'production':
        return adminProdUrl;
      default:
        return adminDevUrl;
    }
  }

  // Get base URL by flavor and environment
  static String getBaseUrlByFlavorAndEnvironment(String flavor, String environment) {
    if (flavor.toLowerCase() == 'admin') {
      return getAdminBaseUrl(environment);
    } else {
      return getUserBaseUrl(environment);
    }
  }
}
