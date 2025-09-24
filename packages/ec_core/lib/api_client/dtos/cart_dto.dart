import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_dto.freezed.dart';
part 'cart_dto.g.dart';

/// Shopping Cart Data Transfer Object
@freezed
class CartDto with _$CartDto {
  const factory CartDto({
    required String id,
    required String userId,
    required List<CartItemDto> items,
    required double subtotal,
    required double taxAmount,
    required double shippingAmount,
    required double discountAmount,
    required double totalAmount,
    required String currency,
    CartCouponDto? appliedCoupon,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? expiresAt,
  }) = _CartDto;

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);
}

/// Cart Item Data Transfer Object
@freezed
class CartItemDto with _$CartItemDto {
  const factory CartItemDto({
    required String id,
    required String productId,
    required String productName,
    required String productSku,
    required String productImage,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    String? variantId,
    Map<String, String>? variantAttributes,
    bool? isAvailable,
    int? availableStock,
    DateTime? addedAt,
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
    required String productId,
    required int quantity,
    String? variantId,
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
  const factory ApplyCouponRequestDto({required String couponCode}) =
      _ApplyCouponRequestDto;

  factory ApplyCouponRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ApplyCouponRequestDtoFromJson(json);
}

/// Cart Summary DTO (lightweight version for lists)
@freezed
class CartSummaryDto with _$CartSummaryDto {
  const factory CartSummaryDto({
    required String id,
    required int itemCount,
    required double totalAmount,
    required String currency,
    DateTime? expiresAt,
  }) = _CartSummaryDto;

  factory CartSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$CartSummaryDtoFromJson(json);
}
