import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dtos/cart_dto.dart';
import 'dtos/base_response.dart';

part 'cart_api.g.dart';

/// Cart API service interface using Retrofit
@RestApi()
abstract class CartApi {
  factory CartApi(Dio dio, {String? baseUrl}) = _CartApi;

  // ============================================================================
  // CART ENDPOINTS
  // ============================================================================

  /// Get current user's cart
  @GET('/cart')
  Future<BaseResponseDto<CartDto>> getCart();

  /// Get cart summary (lightweight)
  @GET('/cart/summary')
  Future<BaseResponseDto<CartSummaryDto>> getCartSummary();

  /// Add item to cart
  @POST('/cart/items')
  Future<BaseResponseDto<CartDto>> addToCart(
    @Body() AddToCartRequestDto request,
  );

  /// Update cart item quantity
  @PUT('/cart/items/{itemId}')
  Future<BaseResponseDto<CartDto>> updateCartItem(
    @Path('itemId') String itemId,
    @Body() UpdateCartItemRequestDto request,
  );

  /// Remove item from cart
  @DELETE('/cart/items/{itemId}')
  Future<BaseResponseDto<CartDto>> removeFromCart(
    @Path('itemId') String itemId,
  );

  /// Clear entire cart
  @DELETE('/cart')
  Future<SuccessResponseDto> clearCart();

  /// Apply coupon to cart
  @POST('/cart/coupon')
  Future<BaseResponseDto<CartDto>> applyCoupon(
    @Body() ApplyCouponRequestDto request,
  );

  /// Remove coupon from cart
  @DELETE('/cart/coupon')
  Future<BaseResponseDto<CartDto>> removeCoupon();

  /// Get cart items count
  @GET('/cart/count')
  Future<BaseResponseDto<CartCountDto>> getCartItemsCount();

  /// Validate cart (check availability, prices, etc.)
  @POST('/cart/validate')
  Future<BaseResponseDto<CartValidationDto>> validateCart();

  /// Merge guest cart with user cart
  @POST('/cart/merge')
  Future<BaseResponseDto<CartDto>> mergeCart(
    @Body() MergeCartRequestDto request,
  );

  // ============================================================================
  // CART ANALYTICS ENDPOINTS (Admin only)
  // ============================================================================

  /// Get cart abandonment analytics (Admin only)
  @GET('/admin/cart/analytics/abandonment')
  Future<BaseResponseDto<CartAnalyticsDto>> getCartAbandonmentAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('groupBy') String? groupBy,
  );

  /// Get cart conversion analytics (Admin only)
  @GET('/admin/cart/analytics/conversion')
  Future<BaseResponseDto<CartAnalyticsDto>> getCartConversionAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('groupBy') String? groupBy,
  );

  /// Get popular cart items (Admin only)
  @GET('/admin/cart/analytics/popular-items')
  Future<BaseResponseDto<List<PopularCartItemDto>>> getPopularCartItems(
    @Query('limit') int? limit,
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );
}
