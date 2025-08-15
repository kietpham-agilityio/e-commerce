import 'package:ec_flavor/ec_flavor.dart';

/// Manages both flavor and role configurations together
class FlavorRoleManager {
  FlavorRoleManager._();

  static EcFlavor _currentFlavor = EcFlavor.dev;
  static UserRole _currentRole = UserRole.user;

  /// Get the current flavor
  static EcFlavor get currentFlavor => _currentFlavor;

  /// Get the current role
  static UserRole get currentRole => _currentRole;

  /// Get the current flavor environment
  static FlavorEnvironment get currentFlavorEnvironment =>
      FlavorConfig.getConfig(_currentFlavor);

  /// Get the current role configuration
  static RoleConfig get currentRoleConfig =>
      FlavorConfig.getRoleConfig(_currentFlavor, _currentRole.value) ??
      RoleManager.getRoleConfig(_currentRole);

  /// Set the current flavor
  static void setFlavor(EcFlavor flavor) {
    _currentFlavor = flavor;
  }

  /// Set the current role
  static void setRole(UserRole role) {
    _currentRole = role;
    RoleManager.setRole(role);
  }

  /// Set both flavor and role
  static void setFlavorAndRole(EcFlavor flavor, UserRole role) {
    _currentFlavor = flavor;
    _currentRole = role;
    RoleManager.setRole(role);
  }

  /// Check if a feature is enabled for current flavor and role
  static bool isFeatureEnabled(String feature) {
    return FlavorConfig.isFeatureEnabledForRole(
      _currentFlavor,
      feature,
      _currentRole.value,
    );
  }

  /// Check if a feature is enabled for a specific flavor and role
  static bool isFeatureEnabledForFlavorAndRole(
    EcFlavor flavor,
    String feature,
    UserRole role,
  ) {
    return FlavorConfig.isFeatureEnabledForRole(flavor, feature, role.value);
  }

  /// Get role configuration for current flavor and role
  static RoleConfig? getCurrentRoleConfig() {
    return FlavorConfig.getRoleConfig(_currentFlavor, _currentRole.value);
  }

  /// Get role configuration for a specific flavor and role
  static RoleConfig? getRoleConfig(EcFlavor flavor, UserRole role) {
    return FlavorConfig.getRoleConfig(flavor, role.value);
  }

  /// Get all role configurations for current flavor
  static Map<String, RoleConfig> getAllCurrentRoleConfigs() {
    return FlavorConfig.getAllRoleConfigs(_currentFlavor);
  }

  /// Get all role configurations for a specific flavor
  static Map<String, RoleConfig> getAllRoleConfigs(EcFlavor flavor) {
    return FlavorConfig.getAllRoleConfigs(flavor);
  }

  /// Check if current role has admin privileges in current flavor
  static bool get hasAdminPrivileges => currentRoleConfig.hasAdminPrivileges;

  /// Check if current role has management privileges in current flavor
  static bool get hasManagementPrivileges =>
      currentRoleConfig.hasManagementPrivileges;

  /// Check if current role can access admin panel in current flavor
  static bool get canAccessAdminPanel => currentRoleConfig.canAccessAdminPanel;

  /// Check if current role can manage users in current flavor
  static bool get canManageUsers => currentRoleConfig.canManageUsers;

  /// Check if current role can view analytics in current flavor
  static bool get canViewAnalytics => currentRoleConfig.canViewAnalytics;

  /// Check if current role can manage products in current flavor
  static bool get canManageProducts => currentRoleConfig.canManageProducts;

  /// Check if current role can view reports in current flavor
  static bool get canViewReports => currentRoleConfig.canViewReports;

  /// Get maximum API calls per minute for current role in current flavor
  static int get maxApiCallsPerMinute => currentRoleConfig.maxApiCallsPerMinute;

  /// Reset to default flavor and role
  static void resetToDefaults() {
    _currentFlavor = EcFlavor.dev;
    _currentRole = UserRole.user;
    RoleManager.resetToDefault();
  }

  /// Get current configuration summary
  static Map<String, dynamic> getCurrentConfigSummary() {
    return {
      'flavor': _currentFlavor.value,
      'flavorDisplayName': _currentFlavor.displayName,
      'role': _currentRole.value,
      'roleDisplayName': _currentRole.displayName,
      'apiBaseUrl': currentFlavorEnvironment.apiBaseUrl,
      'appName': currentFlavorEnvironment.appName,
      'appVersion': currentFlavorEnvironment.appVersion,
      'enableLogging': currentFlavorEnvironment.enableLogging,
      'enableAnalytics': currentFlavorEnvironment.enableAnalytics,
      'enableCrashlytics': currentFlavorEnvironment.enableCrashlytics,
      'timeoutSeconds': currentFlavorEnvironment.timeoutSeconds,
      'maxRetries': currentFlavorEnvironment.maxRetries,
      'rolePermissions': {
        'canAccessAdminPanel': currentRoleConfig.canAccessAdminPanel,
        'canManageUsers': currentRoleConfig.canManageUsers,
        'canViewAnalytics': currentRoleConfig.canViewAnalytics,
        'canManageProducts': currentRoleConfig.canManageProducts,
        'canViewReports': currentRoleConfig.canViewReports,
        'hasAdminPrivileges': currentRoleConfig.hasAdminPrivileges,
        'hasManagementPrivileges': currentRoleConfig.hasManagementPrivileges,
        'maxApiCallsPerMinute': currentRoleConfig.maxApiCallsPerMinute,
      },
      'featureFlags': currentRoleConfig.featureFlags,
    };
  }
}
