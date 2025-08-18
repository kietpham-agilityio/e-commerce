import 'user_role.dart';
import 'role_config.dart';

/// Utility functions for role-based operations
class RoleUtils {
  RoleUtils._();

  /// Get all available roles
  static List<UserRole> get allRoles => UserRole.all;

  /// Get role display names
  static List<String> get roleDisplayNames =>
      UserRole.all.map((role) => role.displayName).toList();

  /// Get role values
  static List<String> get roleValues =>
      UserRole.all.map((role) => role.value).toList();

  /// Check if a string is a valid role
  static bool isValidRole(String role) {
    return UserRole.all.any((r) => r.value == role);
  }

  /// Get role from string with fallback
  static UserRole getRoleFromString(
    String role, {
    UserRole fallback = UserRole.user,
  }) {
    try {
      return UserRole.fromString(role);
    } catch (e) {
      return fallback;
    }
  }

  /// Get role by index
  static UserRole? getRoleByIndex(int index) {
    return UserRole.fromIndex(index);
  }

  /// Get role index
  static int getRoleIndex(UserRole role) {
    return UserRole.all.indexOf(role);
  }

  /// Compare roles for sorting (admin first, then user)
  static int compareRoles(UserRole a, UserRole b) {
    if (a == UserRole.admin && b != UserRole.admin) return -1;
    if (a != UserRole.admin && b == UserRole.admin) return 1;
    return 0;
  }

  /// Sort roles by priority
  static List<UserRole> sortRolesByPriority(List<UserRole> roles) {
    final sorted = List<UserRole>.from(roles);
    sorted.sort(compareRoles);
    return sorted;
  }

  /// Check if role has elevated privileges
  static bool hasElevatedPrivileges(UserRole role) {
    return role == UserRole.admin;
  }

  /// Get role description
  static String getRoleDescription(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return 'Full system access with administrative privileges';
      case UserRole.user:
        return 'Standard user access with basic functionality';
    }
  }

  /// Get role icon name (for UI purposes)
  static String getRoleIconName(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return 'admin_panel_settings';
      case UserRole.user:
        return 'person';
    }
  }

  /// Get role color (for UI purposes)
  static String getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return 'red';
      case UserRole.user:
        return 'blue';
    }
  }

  /// Validate role configuration
  static bool isValidRoleConfig(RoleConfig config) {
    return config.featureFlags.isNotEmpty && config.maxApiCallsPerMinute > 0;
  }

  /// Get default role configuration
  static RoleConfig getDefaultRoleConfig(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return const RoleConfig(
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
        );
      case UserRole.user:
        return const RoleConfig(
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
        );
    }
  }
}
