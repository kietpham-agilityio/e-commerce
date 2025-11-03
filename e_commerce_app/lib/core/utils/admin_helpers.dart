import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration for admin users
/// Contains a list of email addresses that are authorized as admin users
class AdminHelpers {
  AdminHelpers._();

  /// Check if an email is an admin email
  /// Returns true if the email is in the admin list
  static bool isAdminEmail(String email) {
    return dotenv.env['ADMIN_EMAILS']
            ?.split(',')
            .contains(email.toLowerCase().trim()) ??
        false;
  }
}
