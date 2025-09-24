import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

/// User Data Transfer Object
@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    String? avatar,
    String? dateOfBirth,
    String? gender,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserAddressDto? defaultAddress,
    List<UserAddressDto>? addresses,
    UserPreferencesDto? preferences,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

/// User Address Data Transfer Object
@freezed
class UserAddressDto with _$UserAddressDto {
  const factory UserAddressDto({
    required String id,
    required String userId,
    required String street,
    required String city,
    required String state,
    required String postalCode,
    required String country,
    String? apartment,
    String? landmark,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserAddressDto;

  factory UserAddressDto.fromJson(Map<String, dynamic> json) =>
      _$UserAddressDtoFromJson(json);
}

/// User Preferences Data Transfer Object
@freezed
class UserPreferencesDto with _$UserPreferencesDto {
  const factory UserPreferencesDto({
    required String userId,
    String? language,
    String? currency,
    String? theme,
    bool? notifications,
    bool? marketingEmails,
    bool? smsNotifications,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserPreferencesDto;

  factory UserPreferencesDto.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesDtoFromJson(json);
}

/// User Authentication Request DTO
@freezed
class AuthRequestDto with _$AuthRequestDto {
  const factory AuthRequestDto({
    required String email,
    required String password,
  }) = _AuthRequestDto;

  factory AuthRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestDtoFromJson(json);
}

/// User Authentication Response DTO
@freezed
class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required int expiresIn,
    required UserDto user,
  }) = _AuthResponseDto;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);
}

/// User Registration Request DTO
@freezed
class RegisterRequestDto with _$RegisterRequestDto {
  const factory RegisterRequestDto({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) = _RegisterRequestDto;

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDtoFromJson(json);
}

/// Password Reset Request DTO
@freezed
class PasswordResetRequestDto with _$PasswordResetRequestDto {
  const factory PasswordResetRequestDto({required String email}) =
      _PasswordResetRequestDto;

  factory PasswordResetRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetRequestDtoFromJson(json);
}

/// Password Reset Confirm DTO
@freezed
class PasswordResetConfirmDto with _$PasswordResetConfirmDto {
  const factory PasswordResetConfirmDto({
    required String token,
    required String newPassword,
  }) = _PasswordResetConfirmDto;

  factory PasswordResetConfirmDto.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetConfirmDtoFromJson(json);
}

/// Refresh Token Request DTO
@freezed
class RefreshTokenRequestDto with _$RefreshTokenRequestDto {
  const factory RefreshTokenRequestDto({required String refreshToken}) =
      _RefreshTokenRequestDto;

  factory RefreshTokenRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestDtoFromJson(json);
}

/// Verify Email Request DTO
@freezed
class VerifyEmailRequestDto with _$VerifyEmailRequestDto {
  const factory VerifyEmailRequestDto({required String token}) =
      _VerifyEmailRequestDto;

  factory VerifyEmailRequestDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailRequestDtoFromJson(json);
}

/// Update Profile Request DTO
@freezed
class UpdateProfileRequestDto with _$UpdateProfileRequestDto {
  const factory UpdateProfileRequestDto({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? dateOfBirth,
    String? profileImage,
  }) = _UpdateProfileRequestDto;

  factory UpdateProfileRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestDtoFromJson(json);
}

/// Change Password Request DTO
@freezed
class ChangePasswordRequestDto with _$ChangePasswordRequestDto {
  const factory ChangePasswordRequestDto({
    required String currentPassword,
    required String newPassword,
  }) = _ChangePasswordRequestDto;

  factory ChangePasswordRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestDtoFromJson(json);
}

/// Add Address Request DTO
@freezed
class AddAddressRequestDto with _$AddAddressRequestDto {
  const factory AddAddressRequestDto({
    required String type,
    required String street,
    required String city,
    required String state,
    required String postalCode,
    required String country,
    String? apartment,
    bool? isDefault,
  }) = _AddAddressRequestDto;

  factory AddAddressRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddAddressRequestDtoFromJson(json);
}

/// Update Address Request DTO
@freezed
class UpdateAddressRequestDto with _$UpdateAddressRequestDto {
  const factory UpdateAddressRequestDto({
    String? type,
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    String? apartment,
    bool? isDefault,
  }) = _UpdateAddressRequestDto;

  factory UpdateAddressRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateAddressRequestDtoFromJson(json);
}

/// Update Preferences Request DTO
@freezed
class UpdatePreferencesRequestDto with _$UpdatePreferencesRequestDto {
  const factory UpdatePreferencesRequestDto({
    String? language,
    String? currency,
    String? timezone,
    bool? emailNotifications,
    bool? smsNotifications,
    bool? pushNotifications,
  }) = _UpdatePreferencesRequestDto;

  factory UpdatePreferencesRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdatePreferencesRequestDtoFromJson(json);
}

/// Update User Request DTO (Admin)
@freezed
class UpdateUserRequestDto with _$UpdateUserRequestDto {
  const factory UpdateUserRequestDto({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? status,
    String? role,
  }) = _UpdateUserRequestDto;

  factory UpdateUserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestDtoFromJson(json);
}
