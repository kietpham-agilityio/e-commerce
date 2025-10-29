/// Configuration for admin users
/// Contains a list of email addresses that are authorized as admin users
class AdminConfig {
  AdminConfig._();

  /// List of admin email addresses
  /// Add admin emails to this list to grant admin access
  static const List<String> adminEmails = [
    'admin@example.com',
    'admin1@example.com',
    'kiet.pham@asnet.com',
  ];

  /// Check if an email is an admin email
  /// Returns true if the email is in the admin list
  static bool isAdminEmail(String email) {
    return adminEmails.contains(email.toLowerCase().trim());
  }
}
