import 'user_role.dart';
import 'role_config.dart';

/// Manages user roles and their configurations
class RoleManager {
  RoleManager._();

  static UserRole _currentRole = UserRole.user;
  static final Map<UserRole, RoleConfig> _roleConfigs = _initializeRoleConfigs();

  /// Get the current user role
  static UserRole get currentRole => _currentRole;

  /// Get the current role configuration
  static RoleConfig get currentRoleConfig => _roleConfigs[_currentRole]!;

  /// Set the current user role
  static void setRole(UserRole role) {
    _currentRole = role;
  }

  /// Get configuration for a specific role
  static RoleConfig getRoleConfig(UserRole role) {
    return _roleConfigs[role]!;
  }

  /// Get all available role configurations
  static Map<UserRole, RoleConfig> get allRoleConfigs => Map.unmodifiable(_roleConfigs);

  /// Check if current role has a specific permission
  static bool hasPermission(String permission) {
    return currentRoleConfig.isFeatureEnabled(permission);
  }

  /// Check if current role can access admin panel
  static bool get canAccessAdminPanel => currentRoleConfig.canAccessAdminPanel;

  /// Check if current role can manage users
  static bool get canManageUsers => currentRoleConfig.canManageUsers;

  /// Check if current role can view analytics
  static bool get canViewAnalytics => currentRoleConfig.canViewAnalytics;

  /// Check if current role can manage products
  static bool get canManageProducts => currentRoleConfig.canManageProducts;

  /// Check if current role can view reports
  static bool get canViewReports => currentRoleConfig.canViewReports;

  /// Check if current role has admin privileges
  static bool get hasAdminPrivileges => currentRoleConfig.hasAdminPrivileges;

  /// Check if current role has management privileges
  static bool get hasManagementPrivileges => currentRoleConfig.hasManagementPrivileges;

  /// Get maximum API calls per minute for current role
  static int get maxApiCallsPerMinute => currentRoleConfig.maxApiCallsPerMinute;

  /// Initialize role configurations with default values
  static Map<UserRole, RoleConfig> _initializeRoleConfigs() {
    return {
      UserRole.admin: const RoleConfig(
        role: UserRole.admin,
        canAccessAdminPanel: true,
        canManageUsers: true,
        canViewAnalytics: true,
        canManageProducts: true,
        canViewReports: true,
        maxApiCallsPerMinute: 1000,
        featureFlags: {
          'advanced_analytics': true,
          'user_management': true,
          'product_management': true,
          'report_generation': true,
          'system_settings': true,
          'backup_restore': true,
          'audit_logs': true,
        },
      ),
      UserRole.user: const RoleConfig(
        role: UserRole.user,
        canAccessAdminPanel: false,
        canManageUsers: false,
        canViewAnalytics: false,
        canManageProducts: false,
        canViewReports: false,
        maxApiCallsPerMinute: 100,
        featureFlags: {
          'basic_shopping': true,
          'order_history': true,
          'profile_management': true,
          'wishlist': true,
          'reviews': true,
          'notifications': true,
        },
      ),
    };
  }

  /// Reset to default user role
  static void resetToDefault() {
    _currentRole = UserRole.user;
  }

  /// Check if a role transition is allowed
  static bool canTransitionTo(UserRole newRole) {
    // Admin can transition to any role
    if (_currentRole == UserRole.admin) return true;
    
    // Users can only transition to user role (no escalation)
    if (newRole == UserRole.admin) return false;
    
    return true;
  }

  /// Safely transition to a new role
  static bool transitionToRole(UserRole newRole) {
    if (canTransitionTo(newRole)) {
      _currentRole = newRole;
      return true;
    }
    return false;
  }

  /// Get all roles that the current role can transition to
  static List<UserRole> getAvailableTransitions() {
    if (_currentRole == UserRole.admin) {
      return UserRole.all;
    }
    return [UserRole.user];
  }
}
