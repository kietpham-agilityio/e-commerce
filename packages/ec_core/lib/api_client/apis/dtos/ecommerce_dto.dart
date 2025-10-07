import 'package:freezed_annotation/freezed_annotation.dart';

part 'ecommerce_dto.freezed.dart';
part 'ecommerce_dto.g.dart';

/// Add to Wishlist Request DTO
@freezed
class AddToWishlistRequestDto with _$AddToWishlistRequestDto {
  const factory AddToWishlistRequestDto({required String productId}) =
      _AddToWishlistRequestDto;

  factory AddToWishlistRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddToWishlistRequestDtoFromJson(json);
}

/// Move to Cart Options DTO
@freezed
class MoveToCartOptionsDto with _$MoveToCartOptionsDto {
  const factory MoveToCartOptionsDto({int? quantity, String? variantId}) =
      _MoveToCartOptionsDto;

  factory MoveToCartOptionsDto.fromJson(Map<String, dynamic> json) =>
      _$MoveToCartOptionsDtoFromJson(json);
}

/// Update Review Request DTO
@freezed
class UpdateReviewRequestDto with _$UpdateReviewRequestDto {
  const factory UpdateReviewRequestDto({
    required int rating,
    required String comment,
    String? title,
  }) = _UpdateReviewRequestDto;

  factory UpdateReviewRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateReviewRequestDtoFromJson(json);
}

/// Validate Coupon Request DTO
@freezed
class ValidateCouponRequestDto with _$ValidateCouponRequestDto {
  const factory ValidateCouponRequestDto({required String couponCode}) =
      _ValidateCouponRequestDto;

  factory ValidateCouponRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ValidateCouponRequestDtoFromJson(json);
}

/// Wishlist Item DTO
@freezed
class WishlistItemDto with _$WishlistItemDto {
  const factory WishlistItemDto({
    required String id,
    required String productId,
    required String userId,
    required DateTime addedAt,
  }) = _WishlistItemDto;

  factory WishlistItemDto.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemDtoFromJson(json);
}

/// User Review DTO
@freezed
class UserReviewDto with _$UserReviewDto {
  const factory UserReviewDto({
    required String id,
    required String userId,
    required String productId,
    required int rating,
    required String comment,
    String? title,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _UserReviewDto;

  factory UserReviewDto.fromJson(Map<String, dynamic> json) =>
      _$UserReviewDtoFromJson(json);
}

/// Coupon Validation DTO
@freezed
class CouponValidationDto with _$CouponValidationDto {
  const factory CouponValidationDto({
    required bool isValid,
    required String couponCode,
    required double discountAmount,
    required String discountType,
    String? message,
  }) = _CouponValidationDto;

  factory CouponValidationDto.fromJson(Map<String, dynamic> json) =>
      _$CouponValidationDtoFromJson(json);
}

/// Coupon DTO
@freezed
class CouponDto with _$CouponDto {
  const factory CouponDto({
    required String id,
    required String code,
    required String name,
    required String description,
    required double discountAmount,
    required String discountType,
    required double minOrderAmount,
    DateTime? expiresAt,
    required bool isActive,
  }) = _CouponDto;

  factory CouponDto.fromJson(Map<String, dynamic> json) =>
      _$CouponDtoFromJson(json);
}

/// Analytics Data DTO
@freezed
class AnalyticsDataDto with _$AnalyticsDataDto {
  const factory AnalyticsDataDto({
    required Map<String, dynamic> data,
    required String period,
    required DateTime generatedAt,
  }) = _AnalyticsDataDto;

  factory AnalyticsDataDto.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsDataDtoFromJson(json);
}

/// Currency DTO
@freezed
class CurrencyDto with _$CurrencyDto {
  const factory CurrencyDto({
    required String code,
    required String name,
    required String symbol,
    required int decimalPlaces,
  }) = _CurrencyDto;

  factory CurrencyDto.fromJson(Map<String, dynamic> json) =>
      _$CurrencyDtoFromJson(json);
}

/// Country DTO
@freezed
class CountryDto with _$CountryDto {
  const factory CountryDto({
    required String code,
    required String name,
    required String flag,
  }) = _CountryDto;

  factory CountryDto.fromJson(Map<String, dynamic> json) =>
      _$CountryDtoFromJson(json);
}

/// Language DTO
@freezed
class LanguageDto with _$LanguageDto {
  const factory LanguageDto({
    required String code,
    required String name,
    required String nativeName,
  }) = _LanguageDto;

  factory LanguageDto.fromJson(Map<String, dynamic> json) =>
      _$LanguageDtoFromJson(json);
}

/// Notification DTO
@freezed
class NotificationDto with _$NotificationDto {
  const factory NotificationDto({
    required String id,
    required String title,
    required String message,
    required String type,
    required bool isRead,
    required DateTime createdAt,
    Map<String, dynamic>? data,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}

/// App Config DTO
@freezed
class AppConfigDto with _$AppConfigDto {
  const factory AppConfigDto({
    required String appName,
    required String version,
    required Map<String, dynamic> settings,
  }) = _AppConfigDto;

  factory AppConfigDto.fromJson(Map<String, dynamic> json) =>
      _$AppConfigDtoFromJson(json);
}

/// Feature Flags DTO
@freezed
class FeatureFlagsDto with _$FeatureFlagsDto {
  const factory FeatureFlagsDto({
    required Map<String, bool> flags,
    required DateTime lastUpdated,
  }) = _FeatureFlagsDto;

  factory FeatureFlagsDto.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsDtoFromJson(json);
}

/// Health Check DTO
@freezed
class HealthCheckDto with _$HealthCheckDto {
  const factory HealthCheckDto({
    required String status,
    required DateTime timestamp,
    required Map<String, dynamic> details,
  }) = _HealthCheckDto;

  factory HealthCheckDto.fromJson(Map<String, dynamic> json) =>
      _$HealthCheckDtoFromJson(json);
}

/// Version Info DTO
@freezed
class VersionInfoDto with _$VersionInfoDto {
  const factory VersionInfoDto({
    required String version,
    required String buildNumber,
    required DateTime releaseDate,
  }) = _VersionInfoDto;

  factory VersionInfoDto.fromJson(Map<String, dynamic> json) =>
      _$VersionInfoDtoFromJson(json);
}

/// API Status DTO
@freezed
class ApiStatusDto with _$ApiStatusDto {
  const factory ApiStatusDto({
    required String status,
    required Map<String, dynamic> services,
    required DateTime timestamp,
  }) = _ApiStatusDto;

  factory ApiStatusDto.fromJson(Map<String, dynamic> json) =>
      _$ApiStatusDtoFromJson(json);
}
