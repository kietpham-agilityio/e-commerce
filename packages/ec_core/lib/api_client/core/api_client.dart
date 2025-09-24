import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../apis/ecommerce_api.dart';

/// Basic HTTP API client using Retrofit services
class ApiClient {
  ApiClient(this.options, {Dio? dio, this.interceptors, Talker? talker}) {
    _dio = dio ?? Dio();
    _dio
      ..options = options
      ..options.headers = <String, dynamic>{
        'Content-Type': 'application/json; charset=UTF-8',
      };

    // Add TalkerDioLogger interceptor if talker is provided
    if (talker != null) {
      _dio.interceptors.add(TalkerDioLogger(talker: talker));
    }

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }

    // Initialize Retrofit API client
    _ecommerceApi = EcommerceApi(_dio);
  }

  final BaseOptions options;
  late Dio _dio;
  final List<Interceptor>? interceptors;
  late EcommerceApi _ecommerceApi;

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
    // Recreate API client with new base URL
    _ecommerceApi = EcommerceApi(_dio, baseUrl: baseUrl);
  }

  /// Get base URL
  String get baseUrl => _dio.options.baseUrl;

  // ============================================================================
  // RETROFIT API SERVICES
  // ============================================================================

  /// Get the main E-commerce API client
  EcommerceApi get ecommerceApi => _ecommerceApi;

  /// Get User API service
  get userApi => (_ecommerceApi as EcommerceApiImpl).userApi;

  /// Get Product API service
  get productApi => (_ecommerceApi as EcommerceApiImpl).productApi;

  /// Get Cart API service
  get cartApi => (_ecommerceApi as EcommerceApiImpl).cartApi;

  /// Get Order API service
  get orderApi => (_ecommerceApi as EcommerceApiImpl).orderApi;

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

  /// Test all API endpoints to verify connectivity and functionality
  Future<Map<String, dynamic>> testApis() async {
    final results = <String, dynamic>{};
    final startTime = DateTime.now();

    try {
      // Test health endpoint
      try {
        final healthResult = await _ecommerceApi.healthCheck();
        results['health'] = {
          'status': 'success',
          'response': healthResult,
          'timestamp': DateTime.now().toIso8601String(),
        };
      } catch (e) {
        results['health'] = {
          'status': 'error',
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
      }

      // Test user API endpoints
      try {
        final userResult =
            await (_ecommerceApi as EcommerceApiImpl).userApi.getCurrentUser();
        results['user_current'] = {
          'status': 'success',
          'response': userResult,
          'timestamp': DateTime.now().toIso8601String(),
        };
      } catch (e) {
        results['user_current'] = {
          'status': 'error',
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
      }

      // Test product API endpoints
      try {
        final productsResult = await (_ecommerceApi as EcommerceApiImpl)
            .productApi
            .getProducts(
              1, // page
              5, // limit
              null, // category
              null, // brand
              null, // search
              null, // minPrice
              null, // maxPrice
              null, // sortBy
              null, // sortOrder
              null, // inStock
              null, // featured
            );
        results['products_list'] = {
          'status': 'success',
          'response': productsResult,
          'timestamp': DateTime.now().toIso8601String(),
        };
      } catch (e) {
        results['products_list'] = {
          'status': 'error',
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
      }

      // Test cart API endpoints
      try {
        final cartResult =
            await (_ecommerceApi as EcommerceApiImpl).cartApi.getCart();
        results['cart_get'] = {
          'status': 'success',
          'response': cartResult,
          'timestamp': DateTime.now().toIso8601String(),
        };
      } catch (e) {
        results['cart_get'] = {
          'status': 'error',
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
      }

      // Test order API endpoints
      try {
        final ordersResult = await (_ecommerceApi as EcommerceApiImpl).orderApi
            .getOrders(
              1, // page
              5, // limit
              null, // status
              null, // dateFrom
              null, // dateTo
            );
        results['orders_list'] = {
          'status': 'success',
          'response': ordersResult,
          'timestamp': DateTime.now().toIso8601String(),
        };
      } catch (e) {
        results['orders_list'] = {
          'status': 'error',
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
      }

      // Test notifications endpoint
      try {
        final notificationsResult = await _ecommerceApi.getNotifications(
          1, // page
          5, // limit
          null, // unreadOnly
        );
        results['notifications'] = {
          'status': 'success',
          'response': notificationsResult,
          'timestamp': DateTime.now().toIso8601String(),
        };
      } catch (e) {
        results['notifications'] = {
          'status': 'error',
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
      }

      // Test wishlist endpoint
      try {
        final wishlistResult = await _ecommerceApi.getWishlist(
          1, // page
          5, // limit
        );
        results['wishlist'] = {
          'status': 'success',
          'response': wishlistResult,
          'timestamp': DateTime.now().toIso8601String(),
        };
      } catch (e) {
        results['wishlist'] = {
          'status': 'error',
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
      }

      // Test coupons endpoint
      try {
        final couponsResult = await _ecommerceApi.getAvailableCoupons(
          null, // category
          null, // minAmount
        );
        results['coupons'] = {
          'status': 'success',
          'response': couponsResult,
          'timestamp': DateTime.now().toIso8601String(),
        };
      } catch (e) {
        results['coupons'] = {
          'status': 'error',
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
      }

      // Test getApis endpoint
      try {
        final getApisResult = await _ecommerceApi.getApis();
        results['test_apis_posts'] = {
          'status': 'success',
          'response': getApisResult,
          'timestamp': DateTime.now().toIso8601String(),
        };
      } catch (e) {
        results['test_apis_posts'] = {
          'status': 'error',
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
      }

      // Test getComments endpoint
      try {
        final getCommentsResult = await _ecommerceApi.getComments(1);
        results['test_apis_comments'] = {
          'status': 'success',
          'response': getCommentsResult,
          'timestamp': DateTime.now().toIso8601String(),
        };
      } catch (e) {
        results['test_apis_comments'] = {
          'status': 'error',
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
      }

      // Calculate summary
      final endTime = DateTime.now();
      final totalDuration = endTime.difference(startTime);

      final successCount =
          results.values
              .where((result) => result['status'] == 'success')
              .length;
      final errorCount =
          results.values.where((result) => result['status'] == 'error').length;

      results['summary'] = {
        'total_tests': results.length - 1, // Exclude summary itself
        'successful': successCount,
        'failed': errorCount,
        'success_rate':
            '${((successCount / (results.length - 1)) * 100).toStringAsFixed(1)}%',
        'total_duration_ms': totalDuration.inMilliseconds,
        'start_time': startTime.toIso8601String(),
        'end_time': endTime.toIso8601String(),
      };
    } catch (e) {
      results['error'] = {
        'message': 'Failed to run API tests: $e',
        'timestamp': DateTime.now().toIso8601String(),
      };
    }

    return results;
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
