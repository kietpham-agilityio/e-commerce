import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dtos/user_dto.dart';
import 'dtos/base_response.dart';

part 'user_api.g.dart';

/// User API service interface using Retrofit
@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String? baseUrl}) = _UserApi;

  // ============================================================================
  // AUTHENTICATION ENDPOINTS
  // ============================================================================

  /// Login user with email and password
  @POST('/auth/login')
  Future<BaseResponseDto<AuthResponseDto>> login(
    @Body() AuthRequestDto request,
  );

  /// Register new user
  @POST('/auth/register')
  Future<BaseResponseDto<AuthResponseDto>> register(
    @Body() RegisterRequestDto request,
  );

  /// Logout user
  @POST('/auth/logout')
  Future<SuccessResponseDto> logout();

  /// Refresh access token
  @POST('/auth/refresh')
  Future<BaseResponseDto<AuthResponseDto>> refreshToken(
    @Body() RefreshTokenRequestDto request,
  );

  /// Request password reset
  @POST('/auth/password-reset')
  Future<SuccessResponseDto> requestPasswordReset(
    @Body() PasswordResetRequestDto request,
  );

  /// Confirm password reset
  @POST('/auth/password-reset/confirm')
  Future<SuccessResponseDto> confirmPasswordReset(
    @Body() PasswordResetConfirmDto request,
  );

  /// Verify email address
  @POST('/auth/verify-email')
  Future<SuccessResponseDto> verifyEmail(@Body() VerifyEmailRequestDto request);

  // ============================================================================
  // USER PROFILE ENDPOINTS
  // ============================================================================

  /// Get current user profile
  @GET('/users/me')
  Future<BaseResponseDto<UserDto>> getCurrentUser();

  /// Update user profile
  @PUT('/users/me')
  Future<BaseResponseDto<UserDto>> updateProfile(
    @Body() UpdateProfileRequestDto request,
  );

  /// Change password
  @PUT('/users/me/password')
  Future<SuccessResponseDto> changePassword(
    @Body() ChangePasswordRequestDto request,
  );

  /// Delete user account
  @DELETE('/users/me')
  Future<SuccessResponseDto> deleteAccount();

  // ============================================================================
  // USER ADDRESSES ENDPOINTS
  // ============================================================================

  /// Get user addresses
  @GET('/users/me/addresses')
  Future<BaseResponseDto<List<UserAddressDto>>> getUserAddresses();

  /// Add new address
  @POST('/users/me/addresses')
  Future<BaseResponseDto<UserAddressDto>> addAddress(
    @Body() AddAddressRequestDto request,
  );

  /// Update address
  @PUT('/users/me/addresses/{addressId}')
  Future<BaseResponseDto<UserAddressDto>> updateAddress(
    @Path('addressId') String addressId,
    @Body() UpdateAddressRequestDto request,
  );

  /// Delete address
  @DELETE('/users/me/addresses/{addressId}')
  Future<SuccessResponseDto> deleteAddress(@Path('addressId') String addressId);

  /// Set default address
  @PUT('/users/me/addresses/{addressId}/default')
  Future<SuccessResponseDto> setDefaultAddress(
    @Path('addressId') String addressId,
  );

  // ============================================================================
  // USER PREFERENCES ENDPOINTS
  // ============================================================================

  /// Get user preferences
  @GET('/users/me/preferences')
  Future<BaseResponseDto<UserPreferencesDto>> getUserPreferences();

  /// Update user preferences
  @PUT('/users/me/preferences')
  Future<BaseResponseDto<UserPreferencesDto>> updatePreferences(
    @Body() UpdatePreferencesRequestDto request,
  );

  // ============================================================================
  // USER MANAGEMENT ENDPOINTS (Admin only)
  // ============================================================================

  /// Get all users (Admin only)
  @GET('/admin/users')
  Future<PaginatedResponseDto<UserDto>> getAllUsers(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('search') String? search,
    @Query('status') String? status,
  );

  /// Get user by ID (Admin only)
  @GET('/admin/users/{userId}')
  Future<BaseResponseDto<UserDto>> getUserById(@Path('userId') String userId);

  /// Update user by ID (Admin only)
  @PUT('/admin/users/{userId}')
  Future<BaseResponseDto<UserDto>> updateUserById(
    @Path('userId') String userId,
    @Body() UpdateUserRequestDto request,
  );

  /// Deactivate user (Admin only)
  @PUT('/admin/users/{userId}/deactivate')
  Future<SuccessResponseDto> deactivateUser(@Path('userId') String userId);
}
