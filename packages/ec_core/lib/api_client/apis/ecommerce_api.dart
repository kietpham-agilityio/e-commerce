import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'cart_api.dart';
import 'order_api.dart';
import 'product_api.dart';
import 'user_api.dart';
import 'dtos/base_response.dart';
import '../dtos/ecommerce_dto.dart';
import '../dtos/cart_dto.dart';

part 'ecommerce_api.g.dart';

/// Main E-Commerce API client that combines all services
@RestApi()
abstract class EcommerceApi {
  factory EcommerceApi(Dio dio, {String? baseUrl}) = EcommerceApiImpl;

  // ============================================================================

  // ============================================================================
  // HEALTH CHECK ENDPOINTS
  // ============================================================================

  /// Health check endpoint
  @GET('/health')
  Future<BaseResponseDto<HealthCheckDto>> healthCheck();

  /// API version info
  @GET('/version')
  Future<BaseResponseDto<VersionInfoDto>> getVersion();

  /// API status
  @GET('/status')
  Future<BaseResponseDto<ApiStatusDto>> getStatus();

  // ============================================================================
  // CONFIGURATION ENDPOINTS
  // ============================================================================

  /// Get app configuration
  @GET('/config')
  Future<BaseResponseDto<AppConfigDto>> getAppConfig();

  /// Get feature flags
  @GET('/config/features')
  Future<BaseResponseDto<FeatureFlagsDto>> getFeatureFlags();

  /// Get supported currencies
  @GET('/config/currencies')
  Future<BaseResponseDto<List<CurrencyDto>>> getSupportedCurrencies();

  /// Get supported countries
  @GET('/config/countries')
  Future<BaseResponseDto<List<CountryDto>>> getSupportedCountries();

  /// Get supported languages
  @GET('/config/languages')
  Future<BaseResponseDto<List<LanguageDto>>> getSupportedLanguages();

  // ============================================================================
  // NOTIFICATION ENDPOINTS
  // ============================================================================

  /// Get user notifications
  @GET('/notifications')
  Future<PaginatedResponseDto<NotificationDto>> getNotifications(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('unread') bool? unreadOnly,
  );

  /// Mark notification as read
  @PUT('/notifications/{notificationId}/read')
  Future<SuccessResponseDto> markNotificationAsRead(
    @Path('notificationId') String notificationId,
  );

  /// Mark all notifications as read
  @PUT('/notifications/read-all')
  Future<SuccessResponseDto> markAllNotificationsAsRead();

  /// Delete notification
  @DELETE('/notifications/{notificationId}')
  Future<SuccessResponseDto> deleteNotification(
    @Path('notificationId') String notificationId,
  );

  // ============================================================================
  // WISHLIST ENDPOINTS
  // ============================================================================

  /// Get user wishlist
  @GET('/wishlist')
  Future<PaginatedResponseDto<WishlistItemDto>> getWishlist(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  /// Add product to wishlist
  @POST('/wishlist')
  Future<BaseResponseDto<WishlistItemDto>> addToWishlist(
    @Body() AddToWishlistRequestDto request,
  );

  /// Remove product from wishlist
  @DELETE('/wishlist/{productId}')
  Future<SuccessResponseDto> removeFromWishlist(
    @Path('productId') String productId,
  );

  /// Move wishlist item to cart
  @POST('/wishlist/{productId}/move-to-cart')
  Future<BaseResponseDto<CartItemDto>> moveToCart(
    @Path('productId') String productId,
    @Body() MoveToCartOptionsDto? options,
  );

  // ============================================================================
  // REVIEW ENDPOINTS
  // ============================================================================

  /// Get user reviews
  @GET('/reviews')
  Future<PaginatedResponseDto<UserReviewDto>> getUserReviews(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  /// Update review
  @PUT('/reviews/{reviewId}')
  Future<BaseResponseDto<UserReviewDto>> updateReview(
    @Path('reviewId') String reviewId,
    @Body() UpdateReviewRequestDto request,
  );

  /// Delete review
  @DELETE('/reviews/{reviewId}')
  Future<SuccessResponseDto> deleteReview(@Path('reviewId') String reviewId);

  // ============================================================================
  // COUPON ENDPOINTS
  // ============================================================================

  /// Validate coupon code
  @POST('/coupons/validate')
  Future<BaseResponseDto<CouponValidationDto>> validateCoupon(
    @Body() ValidateCouponRequestDto request,
  );

  /// Get available coupons
  @GET('/coupons')
  Future<BaseResponseDto<List<CouponDto>>> getAvailableCoupons(
    @Query('category') String? category,
    @Query('minAmount') double? minAmount,
  );

  // ============================================================================
  // ANALYTICS ENDPOINTS (Admin only)
  // ============================================================================

  /// Get dashboard analytics (Admin only)
  @GET('/admin/analytics/dashboard')
  Future<BaseResponseDto<AnalyticsDataDto>> getDashboardAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );

  /// Get sales analytics (Admin only)
  @GET('/admin/analytics/sales')
  Future<BaseResponseDto<AnalyticsDataDto>> getSalesAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('groupBy') String? groupBy,
  );

  /// Get customer analytics (Admin only)
  @GET('/admin/analytics/customers')
  Future<BaseResponseDto<AnalyticsDataDto>> getCustomerAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );

  /// Get product analytics (Admin only)
  @GET('/admin/analytics/products')
  Future<BaseResponseDto<AnalyticsDataDto>> getProductAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('productId') String? productId,
  );

  // ============================================================================
  // TEST API ENDPOINTS
  // ============================================================================

  /// Get posts from test API
  @GET('/posts')
  Future<dynamic> getApis();

  /// Get comments from test API
  @GET('/comments')
  Future<dynamic> getComments(@Query('postId') int postId);
}

/// Concrete implementation of EcommerceApi
class EcommerceApiImpl extends _EcommerceApi {
  EcommerceApiImpl(super._dio, {super.baseUrl});

  // ============================================================================
  // API SERVICE GETTERS
  // ============================================================================

  /// Get User API service
  @override
  UserApi get userApi => UserApi(_dio, baseUrl: baseUrl);

  /// Get Product API service
  @override
  ProductApi get productApi => ProductApi(_dio, baseUrl: baseUrl);

  /// Get Cart API service
  @override
  CartApi get cartApi => CartApi(_dio, baseUrl: baseUrl);

  /// Get Order API service
  @override
  OrderApi get orderApi => OrderApi(_dio, baseUrl: baseUrl);
}
