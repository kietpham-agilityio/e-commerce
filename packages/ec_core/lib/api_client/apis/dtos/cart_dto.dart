import 'package:freezed_annotation/freezed_annotation.dart';
import '../../enums/supabase_enums.dart';

part 'cart_dto.freezed.dart';
part 'cart_dto.g.dart';

/// Shopping Cart Data Transfer Object - matches Supabase carts table
@freezed
class CartDto with _$CartDto {
  const factory CartDto({
    required int id,
    required String? userId, // UUID from Supabase auth
    required List<CartItemDto> items,
    DateTime? createdAt, // timestamptz from Supabase
  }) = _CartDto;

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);
}

/// Cart Item Data Transfer Object - matches Supabase cart_items table
@freezed
class CartItemDto with _$CartItemDto {
  const factory CartItemDto({
    required int id,
    required int? cartId, // References carts.id
    required int? productVariantId, // References product_variants.id
    required int quantity,
    // Additional fields for UI display (computed from joins)
    String? productName,
    String? productSku,
    String? productImage,
    double? unitPrice,
    double? totalPrice,
    Map<String, String>? variantAttributes,
    bool? isAvailable,
    int? availableStock,
  }) = _CartItemDto;

  factory CartItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemDtoFromJson(json);
}

/// Cart Coupon Data Transfer Object
@freezed
class CartCouponDto with _$CartCouponDto {
  const factory CartCouponDto({
    required String code,
    required String description,
    required double discountAmount,
    required String discountType,
    required bool isValid,
    String? minOrderAmount,
    DateTime? expiresAt,
  }) = _CartCouponDto;

  factory CartCouponDto.fromJson(Map<String, dynamic> json) =>
      _$CartCouponDtoFromJson(json);
}

/// Add to Cart Request DTO
@freezed
class AddToCartRequestDto with _$AddToCartRequestDto {
  const factory AddToCartRequestDto({
    required int productVariantId, // References product_variants.id
    required int quantity,
  }) = _AddToCartRequestDto;

  factory AddToCartRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestDtoFromJson(json);
}

/// Update Cart Item Request DTO
@freezed
class UpdateCartItemRequestDto with _$UpdateCartItemRequestDto {
  const factory UpdateCartItemRequestDto({required int quantity}) =
      _UpdateCartItemRequestDto;

  factory UpdateCartItemRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateCartItemRequestDtoFromJson(json);
}

/// Apply Coupon Request DTO
@freezed
class ApplyCouponRequestDto with _$ApplyCouponRequestDto {
  const factory ApplyCouponRequestDto({required String code}) =
      _ApplyCouponRequestDto; // Changed from couponCode to code to match discounts table

  factory ApplyCouponRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ApplyCouponRequestDtoFromJson(json);
}

/// Cart Summary DTO (lightweight version for lists)
@freezed
class CartSummaryDto with _$CartSummaryDto {
  const factory CartSummaryDto({
    required int id,
    required int itemCount,
    required double totalAmount,
  }) = _CartSummaryDto;

  factory CartSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$CartSummaryDtoFromJson(json);
}

/// Merge Cart Request DTO
@freezed
class MergeCartRequestDto with _$MergeCartRequestDto {
  const factory MergeCartRequestDto({
    required List<CartItemDto> items,
    String? guestSessionId,
  }) = _MergeCartRequestDto;

  factory MergeCartRequestDto.fromJson(Map<String, dynamic> json) =>
      _$MergeCartRequestDtoFromJson(json);
}

/// Cart Count DTO
@freezed
class CartCountDto with _$CartCountDto {
  const factory CartCountDto({
    required int totalItems,
    required int uniqueProducts,
  }) = _CartCountDto;

  factory CartCountDto.fromJson(Map<String, dynamic> json) =>
      _$CartCountDtoFromJson(json);
}

/// Cart Validation DTO
@freezed
class CartValidationDto with _$CartValidationDto {
  const factory CartValidationDto({
    required bool isValid,
    required List<String> errors,
    required List<String> warnings,
    required Map<String, dynamic> details,
  }) = _CartValidationDto;

  factory CartValidationDto.fromJson(Map<String, dynamic> json) =>
      _$CartValidationDtoFromJson(json);
}

/// Cart Analytics DTO
@freezed
class CartAnalyticsDto with _$CartAnalyticsDto {
  const factory CartAnalyticsDto({
    required Map<String, dynamic> data,
    required String period,
    required DateTime generatedAt,
  }) = _CartAnalyticsDto;

  factory CartAnalyticsDto.fromJson(Map<String, dynamic> json) =>
      _$CartAnalyticsDtoFromJson(json);
}

/// Popular Cart Item DTO
@freezed
class PopularCartItemDto with _$PopularCartItemDto {
  const factory PopularCartItemDto({
    required String productId,
    required String productName,
    required int addCount,
    required double conversionRate,
  }) = _PopularCartItemDto;

  factory PopularCartItemDto.fromJson(Map<String, dynamic> json) =>
      _$PopularCartItemDtoFromJson(json);
}
