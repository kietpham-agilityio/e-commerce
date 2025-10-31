import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_dto.freezed.dart';
part 'wishlist_dto.g.dart';

/// Wishlist Data Transfer Object - matches Supabase wishlists table
@freezed
class WishlistDto with _$WishlistDto {
  const factory WishlistDto({
    required int id,
    required String? userId, // UUID from Supabase auth
    required int? productId, // References products.id
    DateTime? createdAt, // timestamptz from Supabase
    // Additional fields for UI display (computed from joins)
    String? productName,
    String? productImage,
    double? productPrice,
    bool? isAvailable,
    String? productSku,
  }) = _WishlistDto;

  factory WishlistDto.fromJson(Map<String, dynamic> json) =>
      _$WishlistDtoFromJson(json);
}

/// Add to Wishlist Request DTO
@freezed
class AddToWishlistRequestDto with _$AddToWishlistRequestDto {
  const factory AddToWishlistRequestDto({required int productId}) =
      _AddToWishlistRequestDto;

  factory AddToWishlistRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddToWishlistRequestDtoFromJson(json);
}

/// Remove from Wishlist Request DTO
@freezed
class RemoveFromWishlistRequestDto with _$RemoveFromWishlistRequestDto {
  const factory RemoveFromWishlistRequestDto({required int wishlistItemId}) =
      _RemoveFromWishlistRequestDto;

  factory RemoveFromWishlistRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RemoveFromWishlistRequestDtoFromJson(json);
}

/// Wishlist Summary DTO
@freezed
class WishlistSummaryDto with _$WishlistSummaryDto {
  const factory WishlistSummaryDto({
    required int totalItems,
    required List<WishlistDto> recentItems,
    DateTime? lastUpdated,
  }) = _WishlistSummaryDto;

  factory WishlistSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$WishlistSummaryDtoFromJson(json);
}

/// Wishlist Analytics DTO (Admin)
@freezed
class WishlistAnalyticsDto with _$WishlistAnalyticsDto {
  const factory WishlistAnalyticsDto({
    required int totalWishlistItems,
    required List<WishlistItemPopularityDto> popularItems,
    required Map<String, dynamic> conversionData,
    DateTime? generatedAt,
  }) = _WishlistAnalyticsDto;

  factory WishlistAnalyticsDto.fromJson(Map<String, dynamic> json) =>
      _$WishlistAnalyticsDtoFromJson(json);
}

/// Wishlist Item Popularity DTO
@freezed
class WishlistItemPopularityDto with _$WishlistItemPopularityDto {
  const factory WishlistItemPopularityDto({
    required int productId,
    required String productName,
    required int wishlistCount,
    required double conversionRate,
  }) = _WishlistItemPopularityDto;

  factory WishlistItemPopularityDto.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemPopularityDtoFromJson(json);
}

/// Create Wishlist Request DTO
@freezed
class CreateWishlistRequestDto with _$CreateWishlistRequestDto {
  const factory CreateWishlistRequestDto({
    required String name,
    String? description,
  }) = _CreateWishlistRequestDto;

  factory CreateWishlistRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateWishlistRequestDtoFromJson(json);
}

/// Update Wishlist Request DTO
@freezed
class UpdateWishlistRequestDto with _$UpdateWishlistRequestDto {
  const factory UpdateWishlistRequestDto({String? name, String? description}) =
      _UpdateWishlistRequestDto;

  factory UpdateWishlistRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateWishlistRequestDtoFromJson(json);
}

/// Move to Cart Response DTO
@freezed
class MoveToCartResponseDto with _$MoveToCartResponseDto {
  const factory MoveToCartResponseDto({
    required bool success,
    required int cartItemId,
    required int quantity,
    String? message,
  }) = _MoveToCartResponseDto;

  factory MoveToCartResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MoveToCartResponseDtoFromJson(json);
}
