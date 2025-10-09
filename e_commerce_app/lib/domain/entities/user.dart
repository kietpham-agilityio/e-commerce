import 'package:ec_core/api_client/enums/supabase_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User entity representing a user in the domain layer
@freezed
class User with _$User {
  /// Creates a new User entity
  const factory User({
    /// Unique identifier for the user
    required String id,

    /// User's email address
    required String email,

    /// User's full name
    String? fullName,

    /// User's phone number
    String? phone,

    /// User's role in the system
    @Default(UserRole.customer) UserRole role,

    /// When the user account was created
    DateTime? createdAt,

    /// URL to user's avatar image
    String? avatar,

    /// Whether the user's email is verified
    @Default(false) bool isEmailVerified,

    /// Whether the user's phone is verified
    @Default(false) bool isPhoneVerified,
  }) = _User;

  /// Creates a user from a JSON map
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
