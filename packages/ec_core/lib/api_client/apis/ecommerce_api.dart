import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'cart_api.dart';
import 'order_api.dart';
import 'product_api.dart';
import 'user_api.dart';
import 'dtos/base_response.dart';

part 'ecommerce_api.g.dart';

/// Main E-Commerce API client that combines all services
@RestApi()
abstract class EcommerceApi {
  factory EcommerceApi(Dio dio, {String? baseUrl}) = _EcommerceApi;

  // ============================================================================
  // PRIVATE GETTERS FOR INTERNAL USE
  // ============================================================================

  Dio get dio;
  String get baseUrl;

  // ============================================================================
  // API SERVICE GETTERS
  // ============================================================================

  /// Get User API service
  UserApi get userApi => UserApi(dio, baseUrl: baseUrl);

  /// Get Product API service
  ProductApi get productApi => ProductApi(dio, baseUrl: baseUrl);

  /// Get Cart API service
  CartApi get cartApi => CartApi(dio, baseUrl: baseUrl);

  /// Get Order API service
  OrderApi get orderApi => OrderApi(dio, baseUrl: baseUrl);

  // ============================================================================
  // HEALTH CHECK ENDPOINTS
  // ============================================================================

  /// Health check endpoint
  @GET('/health')
  Future<BaseResponseDto<Map<String, dynamic>>> healthCheck();

  /// API version info
  @GET('/version')
  Future<BaseResponseDto<Map<String, dynamic>>> getVersion();

  /// API status
  @GET('/status')
  Future<BaseResponseDto<Map<String, dynamic>>> getStatus();

  // ============================================================================
  // CONFIGURATION ENDPOINTS
  // ============================================================================

  /// Get app configuration
  @GET('/config')
  Future<BaseResponseDto<Map<String, dynamic>>> getAppConfig();

  /// Get feature flags
  @GET('/config/features')
  Future<BaseResponseDto<Map<String, dynamic>>> getFeatureFlags();

  /// Get supported currencies
  @GET('/config/currencies')
  Future<BaseResponseDto<List<Map<String, dynamic>>>> getSupportedCurrencies();

  /// Get supported countries
  @GET('/config/countries')
  Future<BaseResponseDto<List<Map<String, dynamic>>>> getSupportedCountries();

  /// Get supported languages
  @GET('/config/languages')
  Future<BaseResponseDto<List<Map<String, dynamic>>>> getSupportedLanguages();

  // ============================================================================
  // NOTIFICATION ENDPOINTS
  // ============================================================================

  /// Get user notifications
  @GET('/notifications')
  Future<PaginatedResponseDto<Map<String, dynamic>>> getNotifications(
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
  Future<PaginatedResponseDto<Map<String, dynamic>>> getWishlist(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  /// Add product to wishlist
  @POST('/wishlist')
  Future<BaseResponseDto<Map<String, dynamic>>> addToWishlist(
    @Body() Map<String, String> request,
  );

  /// Remove product from wishlist
  @DELETE('/wishlist/{productId}')
  Future<SuccessResponseDto> removeFromWishlist(
    @Path('productId') String productId,
  );

  /// Move wishlist item to cart
  @POST('/wishlist/{productId}/move-to-cart')
  Future<BaseResponseDto<Map<String, dynamic>>> moveToCart(
    @Path('productId') String productId,
    @Body() Map<String, dynamic>? options,
  );

  // ============================================================================
  // REVIEW ENDPOINTS
  // ============================================================================

  /// Get user reviews
  @GET('/reviews')
  Future<PaginatedResponseDto<Map<String, dynamic>>> getUserReviews(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  /// Update review
  @PUT('/reviews/{reviewId}')
  Future<BaseResponseDto<Map<String, dynamic>>> updateReview(
    @Path('reviewId') String reviewId,
    @Body() Map<String, dynamic> review,
  );

  /// Delete review
  @DELETE('/reviews/{reviewId}')
  Future<SuccessResponseDto> deleteReview(@Path('reviewId') String reviewId);

  // ============================================================================
  // COUPON ENDPOINTS
  // ============================================================================

  /// Validate coupon code
  @POST('/coupons/validate')
  Future<BaseResponseDto<Map<String, dynamic>>> validateCoupon(
    @Body() Map<String, String> request,
  );

  /// Get available coupons
  @GET('/coupons')
  Future<BaseResponseDto<List<Map<String, dynamic>>>> getAvailableCoupons(
    @Query('category') String? category,
    @Query('minAmount') double? minAmount,
  );

  // ============================================================================
  // ANALYTICS ENDPOINTS (Admin only)
  // ============================================================================

  /// Get dashboard analytics (Admin only)
  @GET('/admin/analytics/dashboard')
  Future<BaseResponseDto<Map<String, dynamic>>> getDashboardAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );

  /// Get sales analytics (Admin only)
  @GET('/admin/analytics/sales')
  Future<BaseResponseDto<Map<String, dynamic>>> getSalesAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('groupBy') String? groupBy,
  );

  /// Get customer analytics (Admin only)
  @GET('/admin/analytics/customers')
  Future<BaseResponseDto<Map<String, dynamic>>> getCustomerAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );

  /// Get product analytics (Admin only)
  @GET('/admin/analytics/products')
  Future<BaseResponseDto<Map<String, dynamic>>> getProductAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('productId') String? productId,
  );
}
