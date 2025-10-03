import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'cart_api.dart';
import 'order_api.dart';
import 'product_api.dart';
import 'user_api.dart';
import 'discount_api.dart';
import 'review_api.dart';
import 'wishlist_api.dart';
import 'shipping_address_api.dart';

/// Main E-Commerce API client that combines all services
abstract class EcommerceApi {
  factory EcommerceApi(Dio dio, {String? baseUrl}) = EcommerceApiImpl;

  // ============================================================================
  // API SERVICE GETTERS (ABSTRACT)
  // ============================================================================

  /// Get User API service
  UserApi get userApi;

  /// Get Product API service
  ProductApi get productApi;

  /// Get Cart API service
  CartApi get cartApi;

  /// Get Order API service
  OrderApi get orderApi;

  /// Get Discount API service
  DiscountApi get discountApi;

  /// Get Review API service
  ReviewApi get reviewApi;

  /// Get Wishlist API service
  WishlistApi get wishlistApi;

  /// Get Shipping Address API service
  ShippingAddressApi get shippingAddressApi;

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

  /// Get Discount API service
  @override
  DiscountApi get discountApi => DiscountApi(_dio, baseUrl: baseUrl);

  /// Get Review API service
  @override
  ReviewApi get reviewApi => ReviewApi(_dio, baseUrl: baseUrl);

  /// Get Wishlist API service
  @override
  WishlistApi get wishlistApi => WishlistApi(_dio, baseUrl: baseUrl);

  /// Get Shipping Address API service
  @override
  ShippingAddressApi get shippingAddressApi =>
      ShippingAddressApi(_dio, baseUrl: baseUrl);
}
