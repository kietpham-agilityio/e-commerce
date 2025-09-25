import 'dart:developer';
import '../core/api_client.dart';
import 'api_fetch_helper.dart';
import 'api_background_helper.dart';
import 'api_response_helper.dart';
import 'api_cache_helper.dart';

/// Demo implementation of API helpers using the getApis method
/// This class demonstrates how to use all the helper classes together
class ApiHelpersDemo {
  final ApiClient _apiClient;

  ApiHelpersDemo(this._apiClient);

  // ============================================================================
  // INDIVIDUAL HELPER IMPLEMENTATIONS
  // ============================================================================

  /// Individual implementation using ApiFetchHelper.maybeFetch
  Future<List<dynamic>> maybeFetch() async {
    try {
      final posts = await ApiFetchHelper.maybeFetch<List<dynamic>>(
        () async {
          final result = await _apiClient.getApis();
          return List<dynamic>.from(result as List);
        },
        maxRetries: 3,
        delay: const Duration(seconds: 2),
        shouldRetry: (failure) => !failure.isAuthError,
      );

      log('✅ Maybe fetch successful: ${posts.length} posts retrieved');
      return posts;
    } catch (e) {
      log('❌ Maybe fetch failed: $e');
      rethrow;
    }
  }

  /// Individual implementation using ApiFetchHelper.forceFetch
  Future<List<dynamic>> forceFetch() async {
    try {
      final posts = await ApiFetchHelper.forceFetch<List<dynamic>>(
        () async {
          final result = await _apiClient.getApis();
          return List<dynamic>.from(result as List);
        },
        maxRetries: 2,
        delay: const Duration(seconds: 1),
      );

      log('✅ Force fetch successful: ${posts.length} posts retrieved');
      return posts;
    } catch (e) {
      log('❌ Force fetch failed: $e');
      rethrow;
    }
  }

  /// Individual implementation using ApiBackgroundHelper.callApiRunBackground
  Future<List<dynamic>> backgroundCall() async {
    try {
      final posts =
          await ApiBackgroundHelper.callApiRunBackground<List<dynamic>>(
            apiCall: () async {
              final result = await _apiClient.getApis();
              return List<dynamic>.from(result as List);
            },
            errorContext: 'backgroundCall',
            timeout: const Duration(seconds: 30),
          );

      log('✅ Background API call successful: ${posts.length} posts retrieved');
      return posts;
    } catch (e) {
      log('❌ Background API call failed: $e');
      rethrow;
    }
  }

  /// Individual implementation using ApiBackgroundHelper.callApiWithConnectivityCheck
  Future<List<dynamic>> connectivityCheck() async {
    try {
      final posts =
          await ApiBackgroundHelper.callApiWithConnectivityCheck<List<dynamic>>(
            apiCall: () async {
              final result = await _apiClient.getApis();
              return List<dynamic>.from(result as List);
            },
            errorContext: 'connectivityCheck',
            timeout: const Duration(seconds: 30),
            checkConnectivity: true,
          );

      log(
        '✅ Connectivity check API call successful: ${posts.length} posts retrieved',
      );
      return posts;
    } catch (e) {
      log('❌ Connectivity check API call failed: $e');
      rethrow;
    }
  }

  /// Individual implementation using ApiBackgroundHelper.callApiWithRetry
  Future<List<dynamic>> retryCall() async {
    try {
      final posts = await ApiBackgroundHelper.callApiWithRetry<List<dynamic>>(
        apiCall: () async {
          final result = await _apiClient.getApis();
          return List<dynamic>.from(result as List);
        },
        errorContext: 'retryCall',
        timeout: const Duration(seconds: 30),
        maxRetries: 3,
        retryDelay: const Duration(seconds: 2),
        shouldRetry: (exception) => !(exception.toString().contains('auth')),
      );

      log('✅ Retry API call successful: ${posts.length} posts retrieved');
      return posts;
    } catch (e) {
      log('❌ Retry API call failed: $e');
      rethrow;
    }
  }

  /// Individual implementation using ApiBackgroundHelper.callApiWithExponentialBackoff
  Future<List<dynamic>> exponentialBackoff() async {
    try {
      final posts = await ApiBackgroundHelper.callApiWithExponentialBackoff<
        List<dynamic>
      >(
        apiCall: () async {
          final result = await _apiClient.getApis();
          return List<dynamic>.from(result as List);
        },
        errorContext: 'exponentialBackoff',
        timeout: const Duration(seconds: 30),
        maxRetries: 3,
        baseDelay: const Duration(milliseconds: 500),
        backoffMultiplier: 2.0,
        maxDelay: const Duration(seconds: 30),
      );

      log(
        '✅ Exponential backoff API call successful: ${posts.length} posts retrieved',
      );
      return posts;
    } catch (e) {
      log('❌ Exponential backoff API call failed: $e');
      rethrow;
    }
  }

  /// Individual implementation using ApiCacheHelper with basic caching
  Future<List<dynamic>> basicCaching() async {
    const cacheKey = 'posts_basic_cache';
    const cacheConfig = CacheConfig.shortTerm; // 5 minutes cache

    try {
      // Check if we have cached data
      final cachedPosts =
          await ApiCacheHelper.getCachedResponseWithConfig<List<dynamic>>(
            cacheKey,
            (json) => List<dynamic>.from(json['data'] ?? []),
            cacheConfig,
          );

      if (cachedPosts != null) {
        log('✅ Retrieved ${cachedPosts.length} posts from cache');
        return cachedPosts;
      }

      // Fetch fresh data
      final result = await _apiClient.getApis();
      final posts = List<dynamic>.from(result as List);

      // Cache the response
      await ApiCacheHelper.cacheResponseWithConfig(cacheKey, {
        'data': posts,
      }, cacheConfig);

      log('✅ Retrieved ${posts.length} posts from API and cached');
      return posts;
    } catch (e) {
      log('❌ Basic caching failed: $e');
      rethrow;
    }
  }

  /// Individual implementation using ApiCacheHelper with automatic key generation
  Future<List<dynamic>> autoCacheKey() async {
    try {
      // Check if we have cached data
      final cachedPosts =
          await ApiCacheHelper.getCachedApiResponse<List<dynamic>>(
            '/posts',
            (json) => List<dynamic>.from(json['data'] ?? []),
            method: 'GET',
          );

      if (cachedPosts != null) {
        log('✅ Retrieved ${cachedPosts.length} posts from auto-cache');
        return cachedPosts;
      }

      // Fetch fresh data
      final result = await _apiClient.getApis();
      final posts = List<dynamic>.from(result as List);

      // Cache the response with automatic key generation
      await ApiCacheHelper.cacheApiResponse(
        '/posts',
        {'data': posts},
        method: 'GET',
        expiration: const Duration(minutes: 10),
      );

      log('✅ Retrieved ${posts.length} posts from API and auto-cached');
      return posts;
    } catch (e) {
      log('❌ Auto-cache failed: $e');
      rethrow;
    }
  }

  /// Individual implementation using ApiResponseHelper.handleListResponse
  Future<List<Map<String, dynamic>>> responseHandling() async {
    try {
      final rawResponse = await _apiClient.getApis();
      final posts = List<dynamic>.from(rawResponse as List);

      // Handle the response using ApiResponseHelper
      final processedPosts =
          ApiResponseHelper.handleListResponse<Map<String, dynamic>>(
            posts,
            (item) => Map<String, dynamic>.from(item),
          );

      log(
        '✅ Response handling successful: ${processedPosts.length} posts processed',
      );
      return processedPosts;
    } catch (e) {
      log('❌ Response handling failed: $e');
      rethrow;
    }
  }

  /// Individual implementation using ApiResponseHelper.handleResponse with error checking
  Future<List<dynamic>> errorHandling() async {
    try {
      final rawResponse = await _apiClient.getApis();
      final posts = List<dynamic>.from(rawResponse as List);

      // Check if response has errors
      if (ApiResponseHelper.hasError(rawResponse)) {
        final errorMessage = ApiResponseHelper.extractErrorMessage(rawResponse);
        throw Exception('API Error: $errorMessage');
      }

      // Process the response
      final processedPosts = ApiResponseHelper.handleResponse<List<dynamic>>(
        posts,
        (data) => List<dynamic>.from(data),
      );

      log(
        '✅ Error handling successful: ${processedPosts.length} posts retrieved',
      );
      return processedPosts;
    } catch (e) {
      log('❌ Error handling failed: $e');
      rethrow;
    }
  }

  // ============================================================================
  // COMPREHENSIVE TESTING
  // ============================================================================

  /// Test all individual helper methods
  Future<Map<String, dynamic>> testAllIndividualHelpers() async {
    final results = <String, dynamic>{};
    final startTime = DateTime.now();

    try {
      // Test individual fetch helpers
      try {
        results['maybeFetch'] = await maybeFetch();
        results['maybeFetch_status'] = 'success';
      } catch (e) {
        results['maybeFetch_status'] = 'error';
        results['maybeFetch_error'] = e.toString();
      }

      try {
        results['forceFetch'] = await forceFetch();
        results['forceFetch_status'] = 'success';
      } catch (e) {
        results['forceFetch_status'] = 'error';
        results['forceFetch_error'] = e.toString();
      }

      // Test individual background helpers
      try {
        results['backgroundCall'] = await backgroundCall();
        results['backgroundCall_status'] = 'success';
      } catch (e) {
        results['backgroundCall_status'] = 'error';
        results['backgroundCall_error'] = e.toString();
      }

      try {
        results['connectivityCheck'] = await connectivityCheck();
        results['connectivityCheck_status'] = 'success';
      } catch (e) {
        results['connectivityCheck_status'] = 'error';
        results['connectivityCheck_error'] = e.toString();
      }

      try {
        results['retryCall'] = await retryCall();
        results['retryCall_status'] = 'success';
      } catch (e) {
        results['retryCall_status'] = 'error';
        results['retryCall_error'] = e.toString();
      }

      try {
        results['exponentialBackoff'] = await exponentialBackoff();
        results['exponentialBackoff_status'] = 'success';
      } catch (e) {
        results['exponentialBackoff_status'] = 'error';
        results['exponentialBackoff_error'] = e.toString();
      }

      // Test individual caching helpers
      try {
        results['basicCaching'] = await basicCaching();
        results['basicCaching_status'] = 'success';
      } catch (e) {
        results['basicCaching_status'] = 'error';
        results['basicCaching_error'] = e.toString();
      }

      try {
        results['autoCacheKey'] = await autoCacheKey();
        results['autoCacheKey_status'] = 'success';
      } catch (e) {
        results['autoCacheKey_status'] = 'error';
        results['autoCacheKey_error'] = e.toString();
      }

      // Test individual response helpers
      try {
        results['responseHandling'] = await responseHandling();
        results['responseHandling_status'] = 'success';
      } catch (e) {
        results['responseHandling_status'] = 'error';
        results['responseHandling_error'] = e.toString();
      }

      try {
        results['errorHandling'] = await errorHandling();
        results['errorHandling_status'] = 'success';
      } catch (e) {
        results['errorHandling_status'] = 'error';
        results['errorHandling_error'] = e.toString();
      }

      // Calculate summary
      final endTime = DateTime.now();
      final totalDuration = endTime.difference(startTime);

      final successCount =
          results.entries
              .where(
                (entry) =>
                    entry.key.endsWith('_status') && entry.value == 'success',
              )
              .length;
      final errorCount =
          results.entries
              .where(
                (entry) =>
                    entry.key.endsWith('_status') && entry.value == 'error',
              )
              .length;

      results['summary'] = {
        'total_tests': successCount + errorCount,
        'successful': successCount,
        'failed': errorCount,
        'success_rate':
            '${((successCount / (successCount + errorCount)) * 100).toStringAsFixed(1)}%',
        'total_duration_ms': totalDuration.inMilliseconds,
        'start_time': startTime.toIso8601String(),
        'end_time': endTime.toIso8601String(),
      };

      log(
        '✅ Individual API Helpers test completed: $successCount successful, $errorCount failed',
      );
    } catch (e) {
      results['error'] = {
        'message': 'Failed to run individual API helpers tests: $e',
        'timestamp': DateTime.now().toIso8601String(),
      };
      log('❌ Individual API Helpers test failed: $e');
    }

    return results;
  }

  /// Clear all cache for testing
  Future<void> clearAllCache() async {
    try {
      await ApiCacheHelper.clearAllCache();
      log('✅ All cache cleared successfully');
    } catch (e) {
      log('❌ Failed to clear cache: $e');
    }
  }

  /// Get cache statistics
  Future<Map<String, dynamic>> getCacheStatistics() async {
    try {
      final stats = await ApiCacheHelper.getCacheStats();
      log('📊 Cache statistics: $stats');
      return stats;
    } catch (e) {
      log('❌ Failed to get cache statistics: $e');
      return {'error': e.toString()};
    }
  }
}
