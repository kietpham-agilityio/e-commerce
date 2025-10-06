import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../apis/ecommerce_api.dart';
import '../apis/user_api.dart';
import '../apis/product_api.dart';
import '../apis/cart_api.dart';
import '../apis/order_api.dart';
import '../apis/discount_api.dart';
import '../apis/review_api.dart';
import '../apis/wishlist_api.dart';
import '../apis/shipping_address_api.dart';

/// Basic HTTP API client using Retrofit services
class ApiClient {
  ApiClient(this.options, {Dio? dio, this.interceptors, Talker? talker}) {
    _dio = dio ?? Dio();
    _dio.options = options;

    // Merge headers from options with default headers
    final defaultHeaders = <String, dynamic>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    // Merge options headers with default headers (options headers take precedence)
    _dio.options.headers = <String, dynamic>{
      ...defaultHeaders,
      ...options.headers,
    };

    // Add TalkerDioLogger interceptor if talker is provided
    if (talker != null) {
      _dio.interceptors.add(TalkerDioLogger(talker: talker));
    }

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }

    // Initialize Retrofit API clients
    _ecommerceApi = EcommerceApi(_dio);
    _userApi = UserApi(_dio);
    _productApi = ProductApi(_dio);
    _cartApi = CartApi(_dio);
    _orderApi = OrderApi(_dio);
    _discountApi = DiscountApi(_dio);
    _reviewApi = ReviewApi(_dio);
    _wishlistApi = WishlistApi(_dio);
    _shippingAddressApi = ShippingAddressApi(_dio);
  }

  final BaseOptions options;
  late Dio _dio;
  final List<Interceptor>? interceptors;
  late EcommerceApi _ecommerceApi;

  // Individual API services
  late UserApi _userApi;
  late ProductApi _productApi;
  late CartApi _cartApi;
  late OrderApi _orderApi;
  late DiscountApi _discountApi;
  late ReviewApi _reviewApi;
  late WishlistApi _wishlistApi;
  late ShippingAddressApi _shippingAddressApi;

  // ============================================================================
  // HEADER MANAGEMENT
  // ============================================================================

  /// Set authorization header
  void setAuthorizationHeader(String token) {
    _dio.options.headers['Authorization'] = token;
  }

  /// Remove authorization header
  void removeAuthorizationHeader() {
    _dio.options.headers.remove('Authorization');
  }

  /// Add custom header
  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  /// Remove custom header
  void removeHeader(String key) {
    _dio.options.headers.remove(key);
  }

  /// Update multiple headers
  void updateHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  /// Clear all headers
  void clearHeaders() {
    _dio.options.headers.clear();
    // Restore default content type
    _dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
  }

  // ============================================================================
  // CLIENT ACCESS
  // ============================================================================

  /// Expose Dio client for other services to use
  Dio getDioClient() {
    return _dio;
  }

  /// Set base URL
  set baseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
    // Recreate all API clients with new base URL
    _ecommerceApi = EcommerceApi(_dio, baseUrl: baseUrl);
    _userApi = UserApi(_dio, baseUrl: baseUrl);
    _productApi = ProductApi(_dio, baseUrl: baseUrl);
    _cartApi = CartApi(_dio, baseUrl: baseUrl);
    _orderApi = OrderApi(_dio, baseUrl: baseUrl);
    _discountApi = DiscountApi(_dio, baseUrl: baseUrl);
    _reviewApi = ReviewApi(_dio, baseUrl: baseUrl);
    _wishlistApi = WishlistApi(_dio, baseUrl: baseUrl);
    _shippingAddressApi = ShippingAddressApi(_dio, baseUrl: baseUrl);
  }

  /// Get base URL
  String get baseUrl => _dio.options.baseUrl;

  // ============================================================================
  // RETROFIT API SERVICES
  // ============================================================================

  /// Get the main E-commerce API client
  EcommerceApi get ecommerceApi => _ecommerceApi;

  /// Get User API service
  UserApi get userApi => _userApi;

  /// Get Product API service
  ProductApi get productApi => _productApi;

  /// Get Cart API service
  CartApi get cartApi => _cartApi;

  /// Get Order API service
  OrderApi get orderApi => _orderApi;

  /// Get Discount API service
  DiscountApi get discountApi => _discountApi;

  /// Get Review API service
  ReviewApi get reviewApi => _reviewApi;

  /// Get Wishlist API service
  WishlistApi get wishlistApi => _wishlistApi;

  /// Get Shipping Address API service
  ShippingAddressApi get shippingAddressApi => _shippingAddressApi;

  // ============================================================================
  // TEST API METHODS
  // ============================================================================

  /// Get comments from test API
  Future<dynamic> getComments(int postId) async {
    return await _ecommerceApi.getComments(postId);
  }

  /// Get posts from test API
  Future<dynamic> getApis() async {
    return await _ecommerceApi.getApis();
  }

  /// Test specific API endpoint
  Future<Map<String, dynamic>> testApiEndpoint(
    String endpointName,
    Future<dynamic> Function() apiCall,
  ) async {
    final startTime = DateTime.now();

    try {
      final result = await apiCall();
      final endTime = DateTime.now();

      return {
        'endpoint': endpointName,
        'status': 'success',
        'response': result,
        'duration_ms': endTime.difference(startTime).inMilliseconds,
        'timestamp': endTime.toIso8601String(),
      };
    } catch (e) {
      final endTime = DateTime.now();

      return {
        'endpoint': endpointName,
        'status': 'error',
        'error': e.toString(),
        'duration_ms': endTime.difference(startTime).inMilliseconds,
        'timestamp': endTime.toIso8601String(),
      };
    }
  }

  /// Test connectivity to the API server
  Future<Map<String, dynamic>> testConnectivity() async {
    return testApiEndpoint('connectivity', () async {
      final response = await _dio.get('/health');
      return {
        'status_code': response.statusCode,
        'data': response.data,
        'headers': response.headers.map,
      };
    });
  }

  // ============================================================================
  // DISPOSE
  // ============================================================================

  /// Dispose the client
  void dispose() {
    _dio.close();
  }
}
