import 'dart:async';
import '../core/api_client_factory.dart';
import '../core/api_client.dart';
import '../helpers/api_helpers.dart';
import '../dtos/user_dto.dart';
import '../dtos/product_dto.dart';
import '../apis/failure.dart';

/// Example showing how to use the API helper classes with Retrofit services
class ApiHelpersUsageExample {
  late ApiClient _apiClient;

  /// Initialize the API client
  void initializeApiClient() {
    _apiClient = ApiClientFactory.createForCurrentFlavor();
  }

  /// Example: Using ApiFetchHelper for maybe fetch
  Future<void> maybeFetchExample() async {
    try {
      // Maybe fetch with retry logic
      final user = await ApiFetchHelper.maybeFetch<UserDto>(
        () => _apiClient.userApi.getCurrentUser().then(
          (response) => response.data,
        ),
        maxRetries: 3,
        delay: const Duration(seconds: 2),
        shouldRetry: (failure) {
          // Don't retry on authentication errors
          return !failure.isAuthError;
        },
      );

      print('User fetched: ${user.firstName} ${user.lastName}');
    } catch (e) {
      print('Maybe fetch failed: $e');
    }
  }

  /// Example: Using ApiFetchHelper for force fetch
  Future<void> forceFetchExample() async {
    try {
      // Force fetch - always get fresh data from server
      final products = await ApiFetchHelper.forceFetch<List<ProductDto>>(
        () => _apiClient.productApi
            .getProducts(page: 1, limit: 20)
            .then((response) => response.data),
        maxRetries: 2,
        delay: const Duration(seconds: 1),
      );

      print('Force fetched ${products.length} products');
    } catch (e) {
      print('Force fetch failed: $e');
    }
  }

  /// Example: Using ApiBackgroundHelper for background API calls
  Future<void> backgroundApiCallExample() async {
    try {
      // Simple background API call
      final user = await ApiBackgroundHelper.callApiRunBackground<UserDto>(
        apiCall:
            () => _apiClient.userApi.getCurrentUser().then(
              (response) => response.data,
            ),
        errorContext: 'Get current user',
        timeout: const Duration(seconds: 30),
      );

      print('Background fetch completed: ${user.firstName}');
    } catch (e) {
      print('Background API call failed: $e');
    }
  }

  /// Example: Using ApiBackgroundHelper with connectivity check
  Future<void> backgroundApiWithConnectivityExample() async {
    try {
      final products = await ApiBackgroundHelper.callApiWithConnectivityCheck<
        List<ProductDto>
      >(
        apiCall:
            () => _apiClient.productApi
                .getProducts(page: 1, limit: 10)
                .then((response) => response.data),
        errorContext: 'Get products',
        timeout: const Duration(seconds: 15),
        checkConnectivity: true,
      );

      print('Connected and fetched ${products.length} products');
    } catch (e) {
      print('Background API with connectivity check failed: $e');
    }
  }

  /// Example: Using ApiBackgroundHelper with retry logic
  Future<void> backgroundApiWithRetryExample() async {
    try {
      final cart =
          await ApiBackgroundHelper.callApiWithRetry<Map<String, dynamic>>(
            apiCall:
                () => _apiClient.cartApi.getCart().then(
                  (response) => response.toJson(),
                ),
            errorContext: 'Get cart',
            timeout: const Duration(seconds: 20),
            maxRetries: 3,
            retryDelay: const Duration(seconds: 2),
            shouldRetry: (error) {
              // Don't retry on authentication errors
              return !(error.toString().contains('unauthorized'));
            },
          );

      print('Cart fetched with retry: ${cart['items']?.length ?? 0} items');
    } catch (e) {
      print('Background API with retry failed: $e');
    }
  }

  /// Example: Using ApiBackgroundHelper with exponential backoff
  Future<void> backgroundApiWithExponentialBackoffExample() async {
    try {
      final orders = await ApiBackgroundHelper.callApiWithExponentialBackoff<
        List<Map<String, dynamic>>
      >(
        apiCall:
            () => _apiClient.orderApi
                .getOrders(page: 1, limit: 10)
                .then(
                  (response) =>
                      response.data.map((order) => order.toJson()).toList(),
                ),
        errorContext: 'Get orders',
        timeout: const Duration(seconds: 25),
        maxRetries: 4,
        baseDelay: const Duration(milliseconds: 500),
        backoffMultiplier: 2.0,
        maxDelay: const Duration(seconds: 30),
      );

      print('Orders fetched with exponential backoff: ${orders.length} orders');
    } catch (e) {
      print('Background API with exponential backoff failed: $e');
    }
  }

  /// Example: Using ApiBackgroundHelper with circuit breaker
  Future<void> backgroundApiWithCircuitBreakerExample() async {
    try {
      final user = await ApiBackgroundHelper.callApiWithCircuitBreaker<UserDto>(
        apiCall:
            () => _apiClient.userApi.getCurrentUser().then(
              (response) => response.data,
            ),
        errorContext: 'Get user profile',
        timeout: const Duration(seconds: 30),
        failureThreshold: 5,
        recoveryTimeout: const Duration(minutes: 1),
      );

      print('User fetched with circuit breaker: ${user.firstName}');
    } catch (e) {
      print('Background API with circuit breaker failed: $e');
    }
  }

  /// Example: Using ApiResponseHelper for response handling
  Future<void> responseHelperExample() async {
    try {
      // Simulate a raw API response
      final rawResponse = {
        'data': [
          {'id': '1', 'name': 'Product 1', 'price': 29.99},
          {'id': '2', 'name': 'Product 2', 'price': 39.99},
        ],
        'page': 1,
        'limit': 10,
        'total': 2,
        'totalPages': 1,
      };

      // Handle paginated response
      final paginatedResponse =
          ApiResponseHelper.handlePaginatedResponse<ProductDto>(
            rawResponse,
            (json) => ProductDto.fromJson(json as Map<String, dynamic>),
          );

      print(
        'Paginated response handled: ${paginatedResponse.data.length} items',
      );
      print('Page: ${paginatedResponse.pagination.page}');
      print('Total: ${paginatedResponse.pagination.total}');

      // Handle list response
      final listResponse = ApiResponseHelper.handleListResponse<ProductDto>(
        rawResponse['data'],
        (json) => ProductDto.fromJson(json as Map<String, dynamic>),
      );

      print('List response handled: ${listResponse.length} items');

      // Check for errors
      final hasError = ApiResponseHelper.hasError(rawResponse);
      print('Response has error: $hasError');
    } catch (e) {
      print('Response helper example failed: $e');
    }
  }

  /// Example: Using ApiCacheHelper for caching
  Future<void> cacheHelperExample() async {
    const endpoint = '/api/user/profile';

    try {
      // Try to get cached user profile
      UserDto? cachedUser = await ApiCacheHelper.getCachedApiResponse<UserDto>(
        endpoint,
        (json) => UserDto.fromJson(json),
      );

      if (cachedUser != null) {
        print('Using cached user: ${cachedUser.firstName}');
      } else {
        // Fetch from API and cache
        final response = await _apiClient.userApi.getCurrentUser();
        if (response.success) {
          await ApiCacheHelper.cacheApiResponse(
            endpoint,
            response.data.toJson(),
            expiration: const Duration(minutes: 30),
          );
          print('User fetched and cached: ${response.data.firstName}');
        }
      }

      // Check if cache exists
      final hasCache = await ApiCacheHelper.hasCachedApiResponse(endpoint);
      print('Cache exists: $hasCache');

      // Get cache statistics
      final stats = await ApiCacheHelper.getCacheStats();
      print('Cache stats: $stats');
    } catch (e) {
      print('Cache helper example failed: $e');
    }
  }

  /// Example: Complete workflow combining all helpers
  Future<void> completeWorkflowExample() async {
    const endpoint = '/api/products';

    try {
      // 1. Check cache first
      List<ProductDto>? cachedProducts =
          await ApiCacheHelper.getCachedApiResponse<List<ProductDto>>(
            endpoint,
            (json) =>
                (json as List)
                    .map(
                      (item) =>
                          ProductDto.fromJson(item as Map<String, dynamic>),
                    )
                    .toList(),
            queryParams: {'page': 1, 'limit': 20},
          );

      if (cachedProducts != null) {
        print('Using cached products: ${cachedProducts.length} items');
        return;
      }

      // 2. Use background API call with retry and exponential backoff
      final products = await ApiBackgroundHelper.callApiWithExponentialBackoff<
        List<ProductDto>
      >(
        apiCall:
            () => ApiFetchHelper.forceFetch<List<ProductDto>>(
              () => _apiClient.productApi
                  .getProducts(page: 1, limit: 20)
                  .then((response) => response.data),
              maxRetries: 2,
            ),
        errorContext: 'Get products with cache',
        timeout: const Duration(seconds: 30),
        maxRetries: 3,
        baseDelay: const Duration(milliseconds: 1000),
        backoffMultiplier: 2.0,
      );

      // 3. Cache the results
      await ApiCacheHelper.cacheApiResponse(
        endpoint,
        products.map((p) => p.toJson()).toList(),
        queryParams: {'page': 1, 'limit': 20},
        expiration: const Duration(hours: 1),
      );

      print(
        'Products fetched, processed, and cached: ${products.length} items',
      );
    } catch (e) {
      print('Complete workflow failed: $e');
    }
  }

  /// Example: Error handling with different strategies
  Future<void> errorHandlingExample() async {
    try {
      // Try maybe fetch with custom error handling
      await ApiFetchHelper.maybeFetch<UserDto>(
        () => _apiClient.userApi.getCurrentUser().then(
          (response) => response.data,
        ),
        maxRetries: 2,
        errorHandler: (error) {
          print('Custom error handler: ${error.toString()}');
          // Return a default user or rethrow
          return const Failure<String>(
            'Failed to fetch user after retries',
            internalErrorCode: null,
          );
        },
        shouldRetry: (failure) {
          // Only retry on network errors, not auth errors
          return !failure.isAuthError && failure.message.contains('network');
        },
      );
    } catch (e) {
      print('Error handling example failed: $e');
    }
  }

  /// Clean up resources and cache
  Future<void> cleanup() async {
    try {
      // Clear cache
      await ApiCacheHelper.clearAllCache();

      // Cleanup expired cache entries
      await ApiCacheHelper.cleanupExpiredCache();

      print('Cleanup completed');
    } catch (e) {
      print('Cleanup failed: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _apiClient.dispose();
  }
}
