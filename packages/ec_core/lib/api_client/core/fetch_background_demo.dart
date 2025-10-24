import 'package:ec_core/api_client/core/fetch_background_utils.dart';
import 'package:ec_core/api_client/core/api_client.dart';

/// Demo class showing how to use FetchBackgroundUtils
class FetchBackgroundDemo {
  final ApiClient _apiClient;

  FetchBackgroundDemo(this._apiClient);

  /// Example: Basic background fetch
  Future<void> basicBackgroundFetch() async {
    try {
      final result = await FetchBackgroundUtils.fetchBackground(
        apiCall: () => _apiClient.featureFlagApi.getFeatureFlags(),
        errorContext: 'fetching feature flags',
        timeout: const Duration(seconds: 15),
      );

      print('✅ Feature flags fetched successfully: $result');
    } catch (e) {
      print('❌ Failed to fetch feature flags: $e');
    }
  }

  /// Example: Background fetch with connectivity check
  /// This example shows how the fetchBackground function checks for internet connectivity
  /// and fails early if no connection is available
  Future<void> backgroundFetchWithConnectivity() async {
    try {
      final result = await FetchBackgroundUtils.fetchBackground(
        apiCall: () => _apiClient.userApi.getCurrentUser(),
        errorContext: 'fetching current user',
        checkConnectivity: true, // Checks for no internet connection
        timeout: const Duration(seconds: 20),
      );

      print('✅ Current user fetched successfully: $result');
    } catch (e) {
      print('❌ Failed to fetch current user: $e');
    }
  }

  /// Example: Multiple concurrent background fetches
  Future<void> multipleBackgroundFetches() async {
    try {
      // Start multiple background fetches concurrently
      final futures = [
        FetchBackgroundUtils.fetchBackground(
          apiCall: () => _apiClient.featureFlagApi.getFeatureFlags(),
          errorContext: 'feature flags',
        ),
        FetchBackgroundUtils.fetchBackground(
          apiCall: () => _apiClient.userApi.getCurrentUser(),
          errorContext: 'current user',
        ),
        FetchBackgroundUtils.fetchBackground(
          apiCall:
              () => _apiClient.productApi.getProducts(
                null, // categoryId
                null, // brandId
                null, // search
                null, // minPrice
                null, // maxPrice
                null, // minRating
                null, // sortBy
                null, // sortOrder
                null, // inStock
              ),
          errorContext: 'products',
        ),
      ];

      // Wait for all to complete
      final results = await Future.wait(futures);

      print('✅ All background fetches completed successfully');
      print('Results: $results');
    } catch (e) {
      print('❌ One or more background fetches failed: $e');
    }
  }

  /// Run all demo examples
  Future<void> runAllExamples() async {
    print('🚀 Starting FetchBackgroundUtils demo...\n');

    print('1. Basic background fetch:');
    await basicBackgroundFetch();

    print('\n2. Background fetch with connectivity check:');
    await backgroundFetchWithConnectivity();

    print('\n3. Multiple concurrent background fetches:');
    await multipleBackgroundFetches();

    print('\n✅ Demo completed!');
  }
}
