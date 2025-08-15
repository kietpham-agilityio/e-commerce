import 'user_role.dart';

/// Configuration for user roles with specific permissions and settings
class RoleConfig {
  const RoleConfig({
    required this.role,
    required this.canAccessAdminPanel,
    required this.canManageUsers,
    required this.canViewAnalytics,
    required this.canManageProducts,
    required this.canViewReports,
    required this.maxApiCallsPerMinute,
    required this.featureFlags,
  });

  /// The user role this configuration applies to
  final UserRole role;
  
  /// Whether the role can access admin panel
  final bool canAccessAdminPanel;
  
  /// Whether the role can manage users
  final bool canManageUsers;
  
  /// Whether the role can view analytics
  final bool canViewAnalytics;
  
  /// Whether the role can manage products
  final bool canManageProducts;
  
  /// Whether the role can view reports
  final bool canViewReports;
  
  /// Maximum API calls allowed per minute
  final int maxApiCallsPerMinute;
  
  /// Feature flags specific to this role
  final Map<String, bool> featureFlags;

  /// Create a copy with updated values
  RoleConfig copyWith({
    UserRole? role,
    bool? canAccessAdminPanel,
    bool? canManageUsers,
    bool? canViewAnalytics,
    bool? canManageProducts,
    bool? canViewReports,
    int? maxApiCallsPerMinute,
    Map<String, bool>? featureFlags,
  }) {
    return RoleConfig(
      role: role ?? this.role,
      canAccessAdminPanel: canAccessAdminPanel ?? this.canAccessAdminPanel,
      canManageUsers: canManageUsers ?? this.canManageUsers,
      canViewAnalytics: canViewAnalytics ?? this.canViewAnalytics,
      canManageProducts: canManageProducts ?? this.canManageProducts,
      canViewReports: canViewReports ?? this.canViewReports,
      maxApiCallsPerMinute: maxApiCallsPerMinute ?? this.maxApiCallsPerMinute,
      featureFlags: featureFlags ?? this.featureFlags,
    );
  }

  /// Check if a specific feature is enabled for this role
  bool isFeatureEnabled(String feature) {
    return featureFlags[feature] ?? false;
  }

  /// Check if the role has admin privileges
  bool get hasAdminPrivileges => canAccessAdminPanel && canManageUsers;

  /// Check if the role has management privileges
  bool get hasManagementPrivileges => canManageProducts || canManageUsers;

  @override
  String toString() {
    return 'RoleConfig('
        'role: $role, '
        'canAccessAdminPanel: $canAccessAdminPanel, '
        'canManageUsers: $canManageUsers, '
        'canViewAnalytics: $canViewAnalytics, '
        'canManageProducts: $canManageProducts, '
        'canViewReports: $canViewReports, '
        'maxApiCallsPerMinute: $maxApiCallsPerMinute, '
        'featureFlags: $featureFlags)';
  }
}
