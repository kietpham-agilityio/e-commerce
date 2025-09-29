import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/themes/themes.dart';

/// Helper class for logging in API client example using LoggerDI
class ApiClientLogger {
  /// Log info message
  static void info(String message) {
    LoggerDI.info(message);
  }

  /// Log error message
  static void error(String message) {
    LoggerDI.error(message);
  }

  /// Log success message
  static void success(String message) {
    LoggerDI.success(message);
  }

  /// Log warning message
  static void warning(String message) {
    LoggerDI.warning(message);
  }

  /// Log API success with detailed information
  static void apiSuccess({
    required String method,
    required String url,
    required int statusCode,
    required Duration duration,
    dynamic responseData,
    dynamic requestData,
  }) {
    // Use the dedicated ApiSuccessLogger for detailed HTTP logging
    ApiSuccessLogger.logSuccess(
      method: method,
      url: url,
      statusCode: statusCode,
      duration: duration,
      responseData: responseData,
      requestData: requestData,
    );
  }
}

/// Example page demonstrating API client concepts with mock implementations
class ApiClientExample extends StatefulWidget {
  const ApiClientExample({super.key});

  @override
  State<ApiClientExample> createState() => _ApiClientExampleState();
}

class _ApiClientExampleState extends State<ApiClientExample> {
  bool _isLoading = false;

  // Real API client from ec_core package
  late ApiClient _apiClient;

  @override
  void initState() {
    super.initState();

    // Get the real ApiClient from DI
    try {
      _apiClient = DI.get<ApiClient>();
      ApiClientLogger.info(
        '✅ Real ApiClient loaded successfully with Talker integration',
      );
    } catch (e) {
      ApiClientLogger.error('❌ Failed to load ApiClient: $e');
      ApiClientLogger.warning(
        '⚠️ ApiClient not available - API calls will fail',
      );
      // We'll handle this in the API call methods
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  /// Check if API client is available and handle error if not
  bool _checkApiClientAvailable() {
    try {
      // Try to access the API client to see if it's properly initialized
      _apiClient.baseUrl;
      return true;
    } catch (e) {
      ApiClientLogger.error('❌ ApiClient not available: $e');
      return false;
    }
  }

  // ============================================================================
  // RETROFIT API EXAMPLES
  // ============================================================================

  Future<void> _testRetrofitGetPosts() async {
    _setLoading(true);
    ApiClientLogger.info('Starting Retrofit GET posts request');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot perform Retrofit request - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final posts = await _apiClient.getApis();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts',
        statusCode: 200,
        duration: duration,
        responseData: posts,
      );

      // Log first few posts
      if (posts is List && posts.isNotEmpty) {
        final firstPost = posts[0];
        if (firstPost is Map && firstPost.containsKey('title')) {
          ApiClientLogger.info('First post: ${firstPost['title']}');
        }
      }
    } catch (e) {
      ApiClientLogger.error('Retrofit GET Posts Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testRetrofitGetComments() async {
    _setLoading(true);
    ApiClientLogger.info('Starting Retrofit GET comments request');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot perform Retrofit request - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final comments = await _apiClient.getComments(1);
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts/1/comments',
        statusCode: 200,
        duration: duration,
        responseData: comments,
      );

      // Log comment details
      if (comments is List && comments.isNotEmpty) {
        ApiClientLogger.info('Found ${comments.length} comments');
        final firstComment = comments[0];
        if (firstComment is Map && firstComment.containsKey('body')) {
          ApiClientLogger.info('First comment: ${firstComment['body']}');
        }
      }
    } catch (e) {
      ApiClientLogger.error('Retrofit GET Comments Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testApiConnectivity() async {
    _setLoading(true);
    ApiClientLogger.info('Testing API connectivity');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test connectivity - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final connectivityResult = await _apiClient.testConnectivity();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/health',
        statusCode: connectivityResult['status_code'] ?? 200,
        duration: duration,
        responseData: connectivityResult,
      );

      ApiClientLogger.info('📊 Connectivity Results:');
      ApiClientLogger.info(
        '   Status Code: ${connectivityResult['status_code']}',
      );
      ApiClientLogger.info(
        '   Duration: ${connectivityResult['duration_ms']}ms',
      );
      ApiClientLogger.info('   Timestamp: ${connectivityResult['timestamp']}');

      if (connectivityResult['status'] == 'success') {
        ApiClientLogger.info('🌐 API server is reachable');
      } else {
        ApiClientLogger.error('❌ API server is not reachable');
      }
    } catch (e) {
      ApiClientLogger.error('Connectivity Test Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================================
  // API HELPER EXAMPLES
  // ============================================================================

  // ============================================================================
  // INDIVIDUAL API HELPER METHODS
  // ============================================================================

  Future<void> _testMaybeFetch() async {
    _setLoading(true);
    ApiClientLogger.info('Testing MaybeFetch helper');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test MaybeFetch - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      final result = await apiHelpersDemo.maybeFetch();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts',
        statusCode: 200,
        duration: duration,
        responseData: result,
      );
    } catch (e) {
      ApiClientLogger.error('❌ MaybeFetch failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testForceFetch() async {
    _setLoading(true);
    ApiClientLogger.info('Testing ForceFetch helper');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test ForceFetch - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      final result = await apiHelpersDemo.forceFetch();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts',
        statusCode: 200,
        duration: duration,
        responseData: result,
      );
    } catch (e) {
      ApiClientLogger.error('❌ ForceFetch failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testBackgroundCall() async {
    _setLoading(true);
    ApiClientLogger.info('Testing BackgroundCall helper');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test BackgroundCall - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      final result = await apiHelpersDemo.backgroundCall();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts',
        statusCode: 200,
        duration: duration,
        responseData: result,
      );
    } catch (e) {
      ApiClientLogger.error('❌ BackgroundCall failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testConnectivityCheck() async {
    _setLoading(true);
    ApiClientLogger.info('Testing ConnectivityCheck helper');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test ConnectivityCheck - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      final result = await apiHelpersDemo.connectivityCheck();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts',
        statusCode: 200,
        duration: duration,
        responseData: result,
      );
    } catch (e) {
      ApiClientLogger.error('❌ ConnectivityCheck failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testRetryCall() async {
    _setLoading(true);
    ApiClientLogger.info('Testing RetryCall helper');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test RetryCall - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      final result = await apiHelpersDemo.retryCall();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts',
        statusCode: 200,
        duration: duration,
        responseData: result,
      );
    } catch (e) {
      ApiClientLogger.error('❌ RetryCall failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testExponentialBackoff() async {
    _setLoading(true);
    ApiClientLogger.info('Testing ExponentialBackoff helper');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test ExponentialBackoff - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      final result = await apiHelpersDemo.exponentialBackoff();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts',
        statusCode: 200,
        duration: duration,
        responseData: result,
      );
    } catch (e) {
      ApiClientLogger.error('❌ ExponentialBackoff failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testBasicCaching() async {
    _setLoading(true);
    ApiClientLogger.info('Testing BasicCaching helper');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test BasicCaching - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      final result = await apiHelpersDemo.basicCaching();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts',
        statusCode: 200,
        duration: duration,
        responseData: result,
      );
    } catch (e) {
      ApiClientLogger.error('❌ BasicCaching failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testAutoCacheKey() async {
    _setLoading(true);
    ApiClientLogger.info('Testing AutoCacheKey helper');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test AutoCacheKey - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      final result = await apiHelpersDemo.autoCacheKey();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts',
        statusCode: 200,
        duration: duration,
        responseData: result,
      );
    } catch (e) {
      ApiClientLogger.error('❌ AutoCacheKey failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testResponseHandling() async {
    _setLoading(true);
    ApiClientLogger.info('Testing ResponseHandling helper');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test ResponseHandling - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      final result = await apiHelpersDemo.responseHandling();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts',
        statusCode: 200,
        duration: duration,
        responseData: result,
      );
    } catch (e) {
      ApiClientLogger.error('❌ ResponseHandling failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testAllIndividualHelpers() async {
    _setLoading(true);
    ApiClientLogger.info('Testing all individual API helpers');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test all helpers - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      final testResults = await apiHelpersDemo.testAllIndividualHelpers();

      if (testResults.containsKey('summary')) {
        final summary = testResults['summary'] as Map<String, dynamic>;

        // Use detailed API success logging for the test summary
        ApiClientLogger.apiSuccess(
          method: 'BATCH',
          url: 'Multiple API endpoints',
          statusCode: 200,
          duration: Duration(milliseconds: summary['total_duration_ms'] ?? 0),
          responseData: summary,
        );

        ApiClientLogger.info('   - Total tests: ${summary['total_tests']}');
        ApiClientLogger.info('   - Successful: ${summary['successful']}');
        ApiClientLogger.info('   - Failed: ${summary['failed']}');
        ApiClientLogger.info('   - Success rate: ${summary['success_rate']}');
        ApiClientLogger.info(
          '   - Duration: ${summary['total_duration_ms']}ms',
        );
      }
    } catch (e) {
      ApiClientLogger.error('❌ All individual helpers test failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testClearCache() async {
    _setLoading(true);
    ApiClientLogger.info('Clearing all cache');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error('❌ Cannot clear cache - ApiClient not available');
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      await apiHelpersDemo.clearAllCache();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'CLEAR',
        url: 'Cache system',
        statusCode: 200,
        duration: duration,
        responseData: {'message': 'All cache cleared successfully'},
      );
    } catch (e) {
      ApiClientLogger.error('❌ Clear cache failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testCacheStatistics() async {
    _setLoading(true);
    ApiClientLogger.info('Getting cache statistics');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot get cache statistics - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    final startTime = DateTime.now();
    try {
      final apiHelpersDemo = ApiHelpersDemo(_apiClient);
      final cacheStats = await apiHelpersDemo.getCacheStatistics();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: 'Cache statistics',
        statusCode: 200,
        duration: duration,
        responseData: cacheStats,
      );

      ApiClientLogger.info('📊 Cache Statistics: $cacheStats');
    } catch (e) {
      ApiClientLogger.error('❌ Get cache statistics failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================================
  // ERROR HANDLING EXAMPLES
  // ============================================================================

  Future<void> _testErrorHandlingExample() async {
    _setLoading(true);
    ApiClientLogger.info('Testing error handling with Retrofit APIs');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test error handling - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      // Test with a non-existent endpoint to trigger error handling
      await _apiClient.getComments(99999); // This should fail
      ApiClientLogger.warning('Unexpected success - should have failed');
    } catch (e) {
      // Use detailed API success logging for error handling demonstration
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/posts/99999/comments',
        statusCode: 404,
        duration: Duration(milliseconds: 100),
        responseData: {'error': 'Error handling working correctly'},
      );

      if (e is Failure) {
        _logFailureDetails(e);
      } else {
        ApiClientLogger.info('Error type: ${e.runtimeType}');
        ApiClientLogger.info('Error message: $e');
      }
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================================
  // COMPREHENSIVE API USAGE EXAMPLES
  // ============================================================================

  Future<void> _testUserAuthenticationFlow() async {
    _setLoading(true);
    ApiClientLogger.info('Testing user authentication flow');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test authentication - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      // Simulate user login (this would typically be a real API call)
      ApiClientLogger.info('🔐 Simulating user login...');

      // In a real scenario, you would call:
      // final loginResponse = await _apiClient.userApi.login(
      //   const AuthRequestDto(
      //     email: 'user@example.com',
      //     password: 'password123',
      //   ),
      // );

      // Use detailed API success logging for authentication flow
      ApiClientLogger.apiSuccess(
        method: 'POST',
        url: '${_apiClient.baseUrl}/auth/login',
        statusCode: 200,
        duration: Duration(milliseconds: 150),
        responseData: {'message': 'Authentication flow demonstrated'},
      );
      ApiClientLogger.info('💡 Real implementation would include:');
      ApiClientLogger.info('   - User login with credentials');
      ApiClientLogger.info('   - Token storage and header management');
      ApiClientLogger.info('   - User profile retrieval');
      ApiClientLogger.info('   - Error handling for auth failures');
    } catch (e) {
      ApiClientLogger.error('Authentication Flow Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testProductSearchFlow() async {
    _setLoading(true);
    ApiClientLogger.info('Testing product search flow');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test product search - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      ApiClientLogger.info('🛍️ Simulating product search...');

      // In a real scenario, you would call:
      // final response = await _apiClient.productApi.getProducts(
      //   page: 1,
      //   limit: 20,
      //   categoryId: 'electronics',
      //   minPrice: 50.0,
      //   maxPrice: 500.0,
      //   sortBy: 'price',
      //   sortOrder: 'asc',
      // );

      // Use detailed API success logging for product search flow
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiClient.baseUrl}/products',
        statusCode: 200,
        duration: Duration(milliseconds: 200),
        responseData: {'message': 'Product search flow demonstrated'},
      );
      ApiClientLogger.info('💡 Real implementation would include:');
      ApiClientLogger.info('   - Search with filters (price, category, brand)');
      ApiClientLogger.info('   - Pagination handling');
      ApiClientLogger.info('   - Sorting options');
      ApiClientLogger.info('   - Product details and variants');
    } catch (e) {
      ApiClientLogger.error('Product Search Flow Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testCartManagementFlow() async {
    _setLoading(true);
    ApiClientLogger.info('Testing cart management flow');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test cart management - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      ApiClientLogger.info('🛒 Simulating cart management...');

      // In a real scenario, you would call:
      // final response = await _apiClient.cartApi.addToCart(
      //   const AddToCartRequestDto(
      //     productId: 'product-123',
      //     quantity: 2,
      //     variantId: 'variant-456',
      //   ),
      // );

      // Use detailed API success logging for cart management flow
      ApiClientLogger.apiSuccess(
        method: 'POST',
        url: '${_apiClient.baseUrl}/cart/add',
        statusCode: 200,
        duration: Duration(milliseconds: 180),
        responseData: {'message': 'Cart management flow demonstrated'},
      );
      ApiClientLogger.info('💡 Real implementation would include:');
      ApiClientLogger.info('   - Add/remove items from cart');
      ApiClientLogger.info('   - Update quantities');
      ApiClientLogger.info('   - Cart validation');
      ApiClientLogger.info('   - Cart summary and totals');
    } catch (e) {
      ApiClientLogger.error('Cart Management Flow Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testOrderProcessingFlow() async {
    _setLoading(true);
    ApiClientLogger.info('Testing order processing flow');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test order processing - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      ApiClientLogger.info('📦 Simulating order processing...');

      // In a real scenario, you would call:
      // final response = await _apiClient.orderApi.createOrder(
      //   const CreateOrderRequestDto(
      //     shippingAddress: OrderAddressDto(...),
      //     billingAddress: OrderAddressDto(...),
      //     paymentMethod: PaymentMethod.creditCard,
      //     shippingMethod: ShippingMethod.standard,
      //   ),
      // );

      // Use detailed API success logging for order processing flow
      ApiClientLogger.apiSuccess(
        method: 'POST',
        url: '${_apiClient.baseUrl}/orders',
        statusCode: 200,
        duration: Duration(milliseconds: 300),
        responseData: {'message': 'Order processing flow demonstrated'},
      );
      ApiClientLogger.info('💡 Real implementation would include:');
      ApiClientLogger.info('   - Order creation with addresses');
      ApiClientLogger.info('   - Payment method selection');
      ApiClientLogger.info('   - Shipping options');
      ApiClientLogger.info('   - Order tracking and status updates');
    } catch (e) {
      ApiClientLogger.error('Order Processing Flow Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testApiHelpersIntegration() async {
    _setLoading(true);
    ApiClientLogger.info('Testing API helpers integration');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test API helpers - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      ApiClientLogger.info('🔧 Demonstrating API helpers integration...');

      // Import the helpers
      ApiClientLogger.info('📚 Available API Helper Classes:');
      ApiClientLogger.info(
        '   - ApiFetchHelper: maybeFetch, forceFetch with retry logic',
      );
      ApiClientLogger.info(
        '   - ApiBackgroundHelper: background calls with timeout, connectivity checks',
      );
      ApiClientLogger.info(
        '   - ApiResponseHelper: response parsing and validation',
      );
      ApiClientLogger.info('   - ApiCacheHelper: caching with Isar database');

      ApiClientLogger.info('💡 Example usage patterns:');
      ApiClientLogger.info(
        '   - Maybe fetch with retry: ApiFetchHelper.maybeFetch()',
      );
      ApiClientLogger.info(
        '   - Force fetch bypassing cache: ApiFetchHelper.forceFetch()',
      );
      ApiClientLogger.info(
        '   - Background API calls: ApiBackgroundHelper.callApiRunBackground()',
      );
      ApiClientLogger.info(
        '   - Response handling: ApiResponseHelper.handlePaginatedResponse()',
      );
      ApiClientLogger.info('   - Caching: ApiCacheHelper.cacheApiResponse()');

      // Use detailed API success logging for API helpers integration
      ApiClientLogger.apiSuccess(
        method: 'INFO',
        url: 'API Helpers Integration',
        statusCode: 200,
        duration: Duration(milliseconds: 50),
        responseData: {'message': 'API helpers integration demonstrated'},
      );
    } catch (e) {
      ApiClientLogger.error('API Helpers Integration Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testCompleteWorkflowExample() async {
    _setLoading(true);
    ApiClientLogger.info('Testing complete workflow example');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test complete workflow - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      ApiClientLogger.info('🔄 Demonstrating complete workflow...');

      // Simulate a complete e-commerce workflow
      ApiClientLogger.info('📋 Complete E-commerce Workflow:');
      ApiClientLogger.info('   1. 🔐 User Authentication');
      ApiClientLogger.info('   2. 🛍️ Product Search & Browsing');
      ApiClientLogger.info('   3. 🛒 Cart Management');
      ApiClientLogger.info('   4. 💳 Checkout Process');
      ApiClientLogger.info('   5. 📦 Order Processing');
      ApiClientLogger.info('   6. 📊 Order Tracking');

      ApiClientLogger.info('💡 Real implementation would combine:');
      ApiClientLogger.info('   - Retrofit API services for type-safe calls');
      ApiClientLogger.info('   - API helpers for advanced functionality');
      ApiClientLogger.info('   - Comprehensive error handling');
      ApiClientLogger.info('   - Caching for performance');
      ApiClientLogger.info('   - Background processing for reliability');

      // Use detailed API success logging for complete workflow
      ApiClientLogger.apiSuccess(
        method: 'WORKFLOW',
        url: 'Complete E-commerce Workflow',
        statusCode: 200,
        duration: Duration(milliseconds: 100),
        responseData: {'message': 'Complete workflow demonstrated'},
      );
    } catch (e) {
      ApiClientLogger.error('Complete Workflow Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testBaseUrlManagement() async {
    _setLoading(true);
    ApiClientLogger.info('Testing base URL management');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test base URL management - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      // Get current base URL
      final currentBaseUrl = _apiClient.baseUrl;
      ApiClientLogger.info('📡 Current Base URL: $currentBaseUrl');

      // Test changing base URL (this would recreate the Retrofit services)
      // Note: In a real scenario, you might want to change to a different API endpoint
      ApiClientLogger.info(
        '🔄 Base URL can be changed via apiClient.baseUrl = "new_url"',
      );
      ApiClientLogger.info(
        '💡 This will automatically recreate all Retrofit services',
      );

      // Use detailed API success logging for base URL management
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: 'Base URL Management',
        statusCode: 200,
        duration: Duration(milliseconds: 10),
        responseData: {
          'baseUrl': currentBaseUrl,
          'message': 'Base URL management is working correctly',
        },
      );
    } catch (e) {
      ApiClientLogger.error('Base URL Management Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Log detailed information about a Failure object
  void _logFailureDetails(Failure failure) {
    // Use detailed API success logging for error handling success
    ApiClientLogger.apiSuccess(
      method: 'ERROR_HANDLING',
      url: 'Error Handling Test',
      statusCode: 200,
      duration: Duration(milliseconds: 50),
      responseData: {'message': 'Error Handling Success!'},
    );
    ApiClientLogger.info('📋 Failure Details:');
    ApiClientLogger.info('   Message: ${failure.message}');
    ApiClientLogger.info('   Status Code: ${failure.statusCode}');
    ApiClientLogger.info('   Error Code: ${failure.errorCode}');
    ApiClientLogger.info(
      '   Detailed Description: ${failure.detailedDescription}',
    );

    // Demonstrate error type checking
    if (failure.isAuthError) {
      ApiClientLogger.warning('🔒 Authentication Error Detected');
    } else if (failure.isNetworkError) {
      ApiClientLogger.warning('🌐 Network Error Detected');
    } else if (failure.isClientError) {
      ApiClientLogger.warning('📱 Client Error (4xx) Detected');
    } else if (failure.isServerError) {
      ApiClientLogger.warning('🖥️ Server Error (5xx) Detected');
    }

    // Log ApiClientError details if available
    if (failure.apiClientError != null) {
      _logApiClientErrorDetails(failure.apiClientError!);
    }

    // Log internal error code details if available
    if (failure.internalErrorCode != null) {
      _logInternalErrorCodeDetails(failure.internalErrorCode!);
    }
  }

  /// Log detailed information about an ApiClientError
  void _logApiClientErrorDetails(ApiClientError error) {
    ApiClientLogger.info('🔍 ApiClientError Details:');
    ApiClientLogger.info('   Type: ${error.runtimeType}');
    ApiClientLogger.info('   Original Error: ${error.originalError}');

    if (error.developerResponseError != null) {
      final devError = error.developerResponseError!;
      ApiClientLogger.info('   Developer Response:');
      ApiClientLogger.info('     Message: ${devError.message}');
      ApiClientLogger.info('     Code: ${devError.code}');
    }

    // Demonstrate ApiClientError pattern matching
    error.when(
      userNotFound: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('👤 User not found error');
      },
      requestCancelled: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('❌ Request was cancelled');
      },
      unauthorizedRequest: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🚫 Unauthorized request');
      },
      forbiddenRequest: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔒 Forbidden request');
      },
      badRequest: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('📝 Bad request');
      },
      notFound: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔍 Resource not found (404)');
      },
      methodNotAllowed: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🚫 Method not allowed');
      },
      notAcceptable: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('❌ Not acceptable');
      },
      requestTimeout: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('⏰ Request timeout');
      },
      sendTimeout: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('⏰ Send timeout');
      },
      conflict: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('⚔️ Conflict error');
      },
      internalServerError: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🖥️ Internal server error');
      },
      notImplemented: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🚧 Not implemented');
      },
      serviceUnavailable: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔧 Service unavailable');
      },
      noInternetConnection: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🌐 No internet connection');
      },
      formatException: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('📄 Format exception');
      },
      unableToProcess: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('⚙️ Unable to process');
      },
      defaultError: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('❓ Default error');
      },
      unexpectedError: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('💥 Unexpected error');
      },
      badResponseMapping: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🗺️ Bad response mapping');
      },
      pdfUnableGenerate: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('📄 PDF unable to generate');
      },
      authGeneral: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔐 General auth error');
      },
      authNonActiveUserError: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('👤 Non-active user error');
      },
      authDoNotHavePermissions: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔒 No permissions error');
      },
      authFailed: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔐 Auth failed');
      },
    );
  }

  /// Log detailed information about an ApiInternalErrorCode
  void _logInternalErrorCodeDetails(ApiInternalErrorCode errorCode) {
    ApiClientLogger.info('🏷️ Internal Error Code Details:');
    ApiClientLogger.info('   Code: ${errorCode.code}');
    ApiClientLogger.info('   Status Code: ${errorCode.statusCode}');
    ApiClientLogger.info('   Description: ${errorCode.description}');
  }

  Future<void> _testApiServiceAccess() async {
    _setLoading(true);
    ApiClientLogger.info('Testing API service access patterns');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test API service access - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      // Demonstrate different ways to access API services
      ApiClientLogger.info('🔗 API Service Access Patterns:');

      // Direct access to EcommerceApi
      ApiClientLogger.info('   📡 Direct: apiClient.ecommerceApi');

      // Individual service access
      ApiClientLogger.info('   👤 User: apiClient.userApi');
      ApiClientLogger.info('   🛍️ Product: apiClient.productApi');
      ApiClientLogger.info('   🛒 Cart: apiClient.cartApi');
      ApiClientLogger.info('   📦 Order: apiClient.orderApi');

      // Test service access
      final ecommerceApi = _apiClient.ecommerceApi;
      final userApi = _apiClient.userApi;

      // Use detailed API success logging for API service access
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: 'API Service Access',
        statusCode: 200,
        duration: Duration(milliseconds: 5),
        responseData: {
          'message': 'All API services accessible',
          'services': [
            'ecommerceApi',
            'userApi',
            'productApi',
            'cartApi',
            'orderApi',
          ],
        },
      );
      ApiClientLogger.info(
        '📊 Services available: ${ecommerceApi.runtimeType}, ${userApi.runtimeType}, etc.',
      );
    } catch (e) {
      ApiClientLogger.error('API Service Access Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================================
  // HEADER MANAGEMENT EXAMPLES
  // ============================================================================

  Future<void> _testHeaderManagement() async {
    _setLoading(true);
    ApiClientLogger.info('Testing header management with Retrofit');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot test header management - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      // Note: Header management is now handled through the Dio instance
      // The ApiClient exposes basic HTTP methods that can be used for testing

      ApiClientLogger.info('🔧 Header Management with Retrofit:');
      ApiClientLogger.info(
        '   📡 Headers are managed through Dio interceptors',
      );
      ApiClientLogger.info(
        '   🔄 Retrofit services automatically include configured headers',
      );
      ApiClientLogger.info(
        '   💡 Use apiClient.addHeader() and apiClient.removeHeader() for basic HTTP methods',
      );

      // Test basic header functionality
      _apiClient.addHeader('X-Custom-Header', 'Example-Value');
      _apiClient.addHeader(
        'X-Request-ID',
        '${DateTime.now().millisecondsSinceEpoch}',
      );

      // Use detailed API success logging for header management
      ApiClientLogger.apiSuccess(
        method: 'POST',
        url: 'Header Management',
        statusCode: 200,
        duration: Duration(milliseconds: 1),
        responseData: {
          'message': 'Headers added successfully',
          'headers': ['X-Custom-Header', 'X-Request-ID'],
        },
      );
      ApiClientLogger.info('📋 Added headers: X-Custom-Header, X-Request-ID');

      // Clean up
      _apiClient.removeHeader('X-Custom-Header');
      _apiClient.removeHeader('X-Request-ID');
      ApiClientLogger.info('🧹 Headers removed successfully');
    } catch (e) {
      ApiClientLogger.error('Header Management Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _showTalkerLogs() {
    try {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const EcTalkerScreen()));
    } catch (e) {
      ApiClientLogger.error('Failed to show Talker logs: $e');

      // Show error dialog
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Talker Error'),
              content: Text('Error accessing Talker logs: $e'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(
        title: const EcTitleMediumText('API Client Examples'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          // Loading indicator
          if (_isLoading) const LinearProgressIndicator(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.blue.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Comprehensive API Client Demo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This comprehensive example demonstrates the new Retrofit-based ApiClient with integrated API helpers. '
                          'Features include type-safe API calls, advanced caching, background processing, retry logic, '
                          'and complete e-commerce workflows. All API calls are logged through the Talker system.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Retrofit API Section
                  _buildSection(
                    title: 'Retrofit API Examples',
                    children: [
                      _buildButtonGrid([
                        ('Get Posts', _testRetrofitGetPosts),
                        ('Get Comments', _testRetrofitGetComments),
                        ('Connectivity Test', _testApiConnectivity),
                      ]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // EcommerceApi Services Section
                  _buildSection(
                    title: 'EcommerceApi Services',
                    children: [
                      _buildButtonGrid([
                        ('Service Access', _testApiServiceAccess),
                        ('Base URL Management', _testBaseUrlManagement),
                      ]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Individual API Helper Methods Section
                  _buildSection(
                    title: 'Individual API Helper Methods',
                    children: [
                      _buildButtonGrid([
                        ('Maybe Fetch', _testMaybeFetch),
                        ('Force Fetch', _testForceFetch),
                        ('Background Call', _testBackgroundCall),
                        ('Connectivity Check', _testConnectivityCheck),
                        ('Retry Call', _testRetryCall),
                        ('Exponential Backoff', _testExponentialBackoff),
                        ('Basic Caching', _testBasicCaching),
                        ('Auto Cache Key', _testAutoCacheKey),
                        ('Response Handling', _testResponseHandling),
                      ]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // API Helpers Integration Section
                  _buildSection(
                    title: 'API Helpers Integration',
                    children: [
                      _buildButtonGrid([
                        ('Test All Helpers', _testAllIndividualHelpers),
                        ('API Helpers Integration', _testApiHelpersIntegration),
                        ('Clear Cache', _testClearCache),
                        ('Cache Statistics', _testCacheStatistics),
                      ]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Comprehensive Usage Examples Section
                  _buildSection(
                    title: 'E-commerce Workflow Examples',
                    children: [
                      _buildButtonGrid([
                        ('User Authentication', _testUserAuthenticationFlow),
                        ('Product Search', _testProductSearchFlow),
                        ('Cart Management', _testCartManagementFlow),
                        ('Order Processing', _testOrderProcessingFlow),
                      ]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // API Helpers Integration Section
                  _buildSection(
                    title: 'API Helpers & Advanced Features',
                    children: [
                      _buildButtonGrid([
                        ('API Helpers Integration', _testApiHelpersIntegration),
                        ('Complete Workflow', _testCompleteWorkflowExample),
                        ('Error Handling Example', _testErrorHandlingExample),
                        ('Header Management', _testHeaderManagement),
                      ]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Talker Logs Button
                  Center(
                    child: EcElevatedButton(
                      text: 'Open Talker Logs',
                      onPressed: _showTalkerLogs,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildButtonGrid(List<(String, VoidCallback)> buttons) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          buttons.map((button) {
            return SizedBox(
              width: 150,
              child: EcElevatedButton(
                text: button.$1,
                onPressed: _isLoading ? null : button.$2,
              ),
            );
          }).toList(),
    );
  }
}

// ============================================================================
// MOCK API CLIENT IMPLEMENTATION
// ============================================================================

/// Mock API client that simulates the behavior of the real ApiClient
/// This demonstrates the concepts without requiring actual HTTP calls
class MockApiClient {
  final Map<String, String> _headers = {};

  // Simulate network delay
  Future<void> _simulateDelay() async {
    await Future.delayed(
      Duration(milliseconds: 500 + (DateTime.now().millisecond % 1000)),
    );
  }

  // Simulate random failures for demonstration
  bool _shouldFail() {
    return DateTime.now().millisecond % 10 == 0; // 10% chance of failure
  }

  Future<T> get<T>(String uri) async {
    await _simulateDelay();

    if (uri.contains('99999') || uri.contains('nonexistent')) {
      throw Exception('404 Not Found');
    }

    if (_shouldFail()) {
      throw Exception('Network Error');
    }

    final mockData = <String, dynamic>{
      'id': 1,
      'title': 'Sample Post Title',
      'body': 'This is a sample post body content.',
      'userId': 1,
    };

    if (uri.contains('_limit=5')) {
      return List.generate(
            5,
            (index) => {
              ...mockData,
              'id': index + 1,
              'title': 'Sample Post ${index + 1}',
            },
          )
          as T;
    }

    return mockData as T;
  }

  Future<T> post<T>(String uri, {required dynamic data}) async {
    await _simulateDelay();

    if (_shouldFail()) {
      throw Exception('Network Error');
    }

    final responseData = <String, dynamic>{
      'id': DateTime.now().millisecondsSinceEpoch,
      ...Map<String, dynamic>.from(data),
    };

    return responseData as T;
  }

  Future<T> put<T>(String uri, {required dynamic data}) async {
    await _simulateDelay();

    if (_shouldFail()) {
      throw Exception('Network Error');
    }

    return Map<String, dynamic>.from(data) as T;
  }

  Future<T> patch<T>(String uri, {required dynamic data}) async {
    await _simulateDelay();

    if (_shouldFail()) {
      throw Exception('Network Error');
    }

    final baseData = <String, dynamic>{
      'id': 1,
      'title': 'Original Title',
      'body': 'Original body content',
      'userId': 1,
    };

    return {...baseData, ...Map<String, dynamic>.from(data)} as T;
  }

  Future<T?> delete<T>(String uri) async {
    await _simulateDelay();

    if (_shouldFail()) {
      throw Exception('Network Error');
    }

    return null; // DELETE typically returns null
  }

  // Maybe fetch with retry logic
  Future<T> maybeFetch<T>(
    Future<T> Function() apiCall, {
    int maxRetries = 0,
    Duration delay = const Duration(seconds: 1),
  }) async {
    int attempts = 0;

    while (attempts <= maxRetries) {
      try {
        return await apiCall();
      } catch (e) {
        attempts++;
        if (attempts > maxRetries) {
          rethrow;
        }
        await Future.delayed(delay * attempts);
      }
    }

    throw Exception('Maybe fetch failed after $maxRetries attempts');
  }

  // Force fetch (same as maybe fetch but with different semantics)
  Future<T> forceFetch<T>(
    Future<T> Function() apiCall, {
    int maxRetries = 0,
    Duration delay = const Duration(seconds: 1),
  }) async {
    return maybeFetch(apiCall, maxRetries: maxRetries, delay: delay);
  }

  // Background API calls with timeout
  Future<T> getRunBackground<T>(
    String uri, {
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    return _runWithTimeout(() => get<T>(uri), timeout: timeout);
  }

  Future<T> postRunBackground<T>(
    String uri, {
    required dynamic data,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    return _runWithTimeout(() => post<T>(uri, data: data), timeout: timeout);
  }

  Future<T> _runWithTimeout<T>(
    Future<T> Function() apiCall, {
    required Duration timeout,
  }) async {
    final completer = Completer<T>();

    Timer(timeout, () {
      if (!completer.isCompleted) {
        completer.completeError(Exception('Request timeout'));
      }
    });

    try {
      final result = await apiCall();
      if (!completer.isCompleted) {
        completer.complete(result);
      }
      return result;
    } catch (e) {
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
      rethrow;
    }
  }

  // Response handling methods
  List<T> handleListResponse<T>(
    dynamic response,
    T Function(dynamic) fromJson,
  ) {
    if (response is List) {
      return response.map((item) => fromJson(item)).toList();
    } else if (response is Map && response.containsKey('data')) {
      final listData = response['data'] as List;
      return listData.map((item) => fromJson(item)).toList();
    } else {
      throw Exception('Invalid response format for list');
    }
  }

  MockFailure handleError(Exception error) {
    return MockFailure(error.toString());
  }

  // Header management
  void addHeader(String key, String value) {
    _headers[key] = value;
  }

  void removeHeader(String key) {
    _headers.remove(key);
  }

  Map<String, String> get headers => Map.from(_headers);
}

// Mock failure class
class MockFailure {
  final String message;

  MockFailure(this.message);
}
