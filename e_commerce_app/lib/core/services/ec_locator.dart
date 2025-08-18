import 'package:ec_flavor/ec_flavor.dart';

/// Simplified service locator for the e-commerce application
/// This class provides basic role-based access control without complex dependency injection
class EcLocator {
  static bool _isInitialized = false;

  /// Initialize the service locator
  /// This should be called once at app startup
  static Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    try {
      // Initialize role management
      await _initializeRole();
      
      _isInitialized = true;
    } catch (e) {
      rethrow;
    }
  }

  /// Initialize role management
  static Future<void> _initializeRole() async {
    try {
      // Role is already set in main files, just ensure it's initialized
      // If no role is set, set a default role
      if (RoleManager.currentRole == UserRole.user) {
        // Set default role if none is set
        RoleManager.setRole(UserRole.user);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Check if a feature is enabled for current role
  static bool isFeatureEnabled(String feature) {
    if (!_isInitialized) {
      return false;
    }
    return RoleManager.hasPermission(feature);
  }

  /// Get the current user role
  static UserRole getCurrentRole() {
    if (!_isInitialized) {
      throw StateError('Role not initialized. Call initialize() first.');
    }
    return RoleManager.currentRole;
  }

  /// Get the current role configuration
  static RoleConfig getCurrentRoleConfig() {
    if (!_isInitialized) {
      throw StateError('Role not initialized. Call initialize() first.');
    }
    return RoleManager.currentRoleConfig;
  }

  /// Check if current role has admin privileges
  static bool get hasAdminPrivileges {
    if (!_isInitialized) {
      return false;
    }
    return RoleManager.hasAdminPrivileges;
  }

  /// Check if current role has management privileges
  static bool get hasManagementPrivileges {
    if (!_isInitialized) {
      return false;
    }
    return RoleManager.hasManagementPrivileges;
  }

  /// Set the current user role (useful for role switching)
  static void setCurrentRole(UserRole role) {
    if (!_isInitialized) {
      throw StateError('Role not initialized. Call initialize() first.');
    }
    RoleManager.setRole(role);
  }

  /// Get current configuration summary including role information
  static Map<String, dynamic> getCurrentConfigSummary() {
    if (!_isInitialized) {
      throw StateError('Role not initialized. Call initialize() first.');
    }
    return RoleManager.getCurrentConfigSummary();
  }

  /// Get complete configuration summary (role only)
  static Map<String, dynamic> getCompleteConfigSummary() {
    if (!_isInitialized) {
      throw StateError('Role not initialized. Call initialize() first.');
    }
    
    final roleSummary = RoleManager.getCurrentConfigSummary();
    
    return {
      'role': roleSummary,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// Reset all services (useful for testing)
  static void reset() {
    _isInitialized = false;
    RoleManager.resetToDefault();
  }

  /// Check if the locator is initialized
  static bool get isInitialized => _isInitialized;
}
