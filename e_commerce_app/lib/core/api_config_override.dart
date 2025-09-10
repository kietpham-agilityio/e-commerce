import 'package:ec_core/ec_core.dart';

/// Custom API configuration that overrides the core ApiConfig methods
class ApiConfigOverride {
  /// Override getBaseUrl to provide environment-specific URLs
  static String getBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
        return 'https://dev-api.ecommerce.com';
      case 'staging':
        return 'https://staging-api.ecommerce.com';
      case 'prod':
      case 'production':
        return 'https://api.ecommerce.com';
      default:
        return 'https://dev-api.ecommerce.com';
    }
  }

  /// Override getAdminBaseUrl to provide admin-specific URLs
  static String getAdminBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
        return 'https://dev-admin-api.ecommerce.com';
      case 'staging':
        return 'https://staging-admin-api.ecommerce.com';
      case 'prod':
      case 'production':
        return 'https://admin-api.ecommerce.com';
      default:
        return 'https://dev-admin-api.ecommerce.com';
    }
  }
}



