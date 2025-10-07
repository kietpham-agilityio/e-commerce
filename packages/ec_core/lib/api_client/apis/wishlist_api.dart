import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dtos/wishlist_dto.dart';
import 'dtos/base_response.dart';

part 'wishlist_api.g.dart';

/// Wishlist API service interface using Retrofit
@RestApi()
abstract class WishlistApi {
  factory WishlistApi(Dio dio, {String? baseUrl}) = _WishlistApi;

  // ============================================================================
  // WISHLIST ENDPOINTS
  // ============================================================================

  /// Get user's wishlist
  @GET('/wishlist')
  Future<BaseResponseDto<List<WishlistDto>>> getWishlist(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  /// Get wishlist summary
  @GET('/wishlist/summary')
  Future<BaseResponseDto<WishlistSummaryDto>> getWishlistSummary();

  /// Add item to wishlist
  @POST('/wishlist')
  Future<BaseResponseDto<WishlistDto>> addToWishlist(
    @Body() AddToWishlistRequestDto request,
  );

  /// Remove item from wishlist
  @DELETE('/wishlist/{wishlistItemId}')
  Future<SuccessResponseDto> removeFromWishlist(
    @Path('wishlistItemId') int wishlistItemId,
  );

  /// Check if product is in wishlist
  @GET('/wishlist/check/{productId}')
  Future<BaseResponseDto<bool>> isInWishlist(@Path('productId') int productId);

  /// Move wishlist item to cart
  @POST('/wishlist/{wishlistItemId}/move-to-cart')
  Future<BaseResponseDto<MoveToCartResponseDto>> moveToCart(
    @Path('wishlistItemId') int wishlistItemId,
  );

  /// Clear wishlist
  @DELETE('/wishlist')
  Future<SuccessResponseDto> clearWishlist();

  // ============================================================================
  // ADMIN WISHLIST ANALYTICS ENDPOINTS
  // ============================================================================

  /// Get wishlist analytics (Admin only)
  @GET('/admin/wishlist/analytics')
  Future<BaseResponseDto<WishlistAnalyticsDto>> getWishlistAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );

  /// Get popular wishlist items (Admin only)
  @GET('/admin/wishlist/popular-items')
  Future<BaseResponseDto<List<WishlistItemPopularityDto>>>
  getPopularWishlistItems(
    @Query('limit') int? limit,
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );
}
