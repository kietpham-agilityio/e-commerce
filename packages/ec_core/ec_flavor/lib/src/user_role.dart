/// Enum representing different user roles in the application
enum UserRole {
  /// Administrator role with full access
  admin('admin', 'Administrator'),
  
  /// Regular user role with limited access
  user('user', 'User');

  const UserRole(this.value, this.displayName);

  /// String value of the role
  final String value;
  
  /// Human-readable display name
  final String displayName;

  /// Get role from string value
  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.user,
    );
  }

  /// Check if this is admin role
  bool get isAdmin => this == UserRole.admin;
  
  /// Check if this is user role
  bool get isUser => this == UserRole.user;

  /// Get all available roles
  static List<UserRole> get all => UserRole.values;

  /// Get role by index
  static UserRole? fromIndex(int index) {
    if (index >= 0 && index < UserRole.values.length) {
      return UserRole.values[index];
    }
    return null;
  }

  @override
  String toString() => value;
}
