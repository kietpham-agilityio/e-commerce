import 'dart:convert';
import 'dart:developer';
import 'package:ec_core/services/ec_local_store/ec_local_store.dart';

/// Helper class for caching API responses using the local storage system
class ApiCacheHelper {
  static const Duration _defaultCacheDuration = Duration(hours: 1);
  static const String _defaultMethod = 'GET';

  /// Get the cached API query box from local storage
  static CachedApiQueryBox get _cacheBox =>
      EcLocalDatabase.instance.cachedApiQueryBox;

  /// Cache a response with optional expiration
  static Future<void> cacheResponse<T>(
    String key,
    T data, {
    Duration? expiration,
    String? method,
    String? requestBody,
    int? userId,
  }) async {
    try {
      final responseData = data is String ? data : json.encode(data);
      final cacheDuration = expiration ?? _defaultCacheDuration;
      final httpMethod = method ?? _defaultMethod;

      await _cacheBox.cacheQuery(
        endpoint: key,
        method: httpMethod,
        requestBody: requestBody,
        responseData: responseData,
        cacheDuration: cacheDuration,
        userId: userId,
      );
    } catch (e) {
      // Cache errors should not break the app
      log('Failed to cache response for key $key: $e');
    }
  }

  /// Retrieve cached response if not expired
  static Future<T?> getCachedResponse<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson, {
    String? method,
    String? requestBody,
    int? userId,
  }) async {
    try {
      final httpMethod = method ?? _defaultMethod;
      final cachedQuery = await _cacheBox.getCachedQuery(
        endpoint: key,
        method: httpMethod,
        requestBody: requestBody,
        userId: userId,
      );

      if (cachedQuery == null || cachedQuery.responseData == null) {
        return null;
      }

      // Parse the response data
      final responseData = json.decode(cachedQuery.responseData!);

      // If the response is already a Map, use it directly
      if (responseData is Map<String, dynamic>) {
        // Check if it has a 'responseData' wrapper and extract it
        if (responseData.containsKey('responseData')) {
          return fromJson({'responseData': responseData['responseData']});
        }
        return fromJson(responseData);
      }

      // If it's a string, try to parse it as JSON again
      if (responseData is String) {
        final parsedData = json.decode(responseData);
        if (parsedData is Map<String, dynamic>) {
          // Check if it has a 'responseData' wrapper and extract it
          if (parsedData.containsKey('responseData')) {
            return fromJson({'responseData': parsedData['responseData']});
          }
          return fromJson(parsedData);
        }
      }

      return null;
    } catch (e) {
      // Cache errors should not break the app
      log('Failed to retrieve cached response for key $key: $e');
      return null;
    }
  }

  /// Retrieve cached list response if not expired
  /// This is a specialized method for list responses that automatically handles
  /// the responseData extraction and list deserialization
  static Future<List<T>?> getCachedListResponse<T>(
    String key,
    T Function(Map<String, dynamic>) itemFromJson, {
    String? method,
    String? requestBody,
    int? userId,
  }) async {
    try {
      final httpMethod = method ?? _defaultMethod;
      final cachedQuery = await _cacheBox.getCachedQuery(
        endpoint: key,
        method: httpMethod,
        requestBody: requestBody,
        userId: userId,
      );

      if (cachedQuery == null || cachedQuery.responseData == null) {
        log('📦 Cache miss for $key: cachedQuery is null or has no data');
        return null;
      }

      log('📦 Cache hit for $key: Found cached data');

      // Parse the response data
      final responseData = json.decode(cachedQuery.responseData!);

      // Extract the list from responseData wrapper if it exists
      List<dynamic> dataList;
      if (responseData is Map<String, dynamic>) {
        if (responseData.containsKey('responseData') &&
            responseData['responseData'] is List) {
          dataList = responseData['responseData'] as List;
          log(
            '📦 Extracted list from "responseData" key: ${dataList.length} items',
          );
        } else if (responseData.containsKey('data') &&
            responseData['data'] is List) {
          dataList = responseData['data'] as List;
          log('📦 Extracted list from "data" key: ${dataList.length} items');
        } else {
          log('⚠️ Cache data is Map but has no "responseData" or "data" key');
          return <T>[];
        }
      } else if (responseData is List) {
        dataList = responseData;
        log('📦 Cache data is direct list: ${dataList.length} items');
      } else {
        log(
          '⚠️ Cache data is neither Map nor List: ${responseData.runtimeType}',
        );
        return <T>[];
      }

      // Convert each item in the list using the provided fromJson function
      final result =
          dataList
              .map((item) => itemFromJson(item as Map<String, dynamic>))
              .toList();
      log('✅ Successfully deserialized ${result.length} items from cache');
      return result;
    } catch (e, stackTrace) {
      // Cache errors should not break the app
      log(
        '❌ Failed to retrieve cached list response for key $key: $e\n$stackTrace',
      );
      return null;
    }
  }

  /// Check if cached response exists and is not expired
  static Future<bool> hasCachedResponse(
    String key, {
    String? method,
    String? requestBody,
    int? userId,
  }) async {
    try {
      final httpMethod = method ?? _defaultMethod;
      final cachedQuery = await _cacheBox.getCachedQuery(
        endpoint: key,
        method: httpMethod,
        requestBody: requestBody,
        userId: userId,
      );

      return cachedQuery != null && !cachedQuery.isExpired;
    } catch (e) {
      return false;
    }
  }

  /// Remove cached response
  static Future<void> removeCachedResponse(
    String key, {
    String? method,
    String? requestBody,
    int? userId,
  }) async {
    try {
      await _cacheBox.clearCacheForEndpoint(key);
    } catch (e) {
      log('Failed to remove cached response for key $key: $e');
    }
  }

  /// Clear all cached responses
  static Future<void> clearAllCache() async {
    try {
      await _cacheBox.clearAllCache();
    } catch (e) {
      log('Failed to clear cache: $e');
    }
  }

  /// Clear cache for specific user
  static Future<void> clearCacheForUser(int userId) async {
    try {
      await _cacheBox.clearCacheForUser(userId);
    } catch (e) {
      log('Failed to clear cache for user $userId: $e');
    }
  }

  /// Clear cache for specific endpoint
  static Future<void> clearCacheForEndpoint(String endpoint) async {
    try {
      await _cacheBox.clearCacheForEndpoint(endpoint);
    } catch (e) {
      log('Failed to clear cache for endpoint $endpoint: $e');
    }
  }

  /// Get cache statistics
  static Future<Map<String, dynamic>> getCacheStats() async {
    try {
      // Note: The current CachedApiQueryBox doesn't provide statistics
      // This is a placeholder implementation
      // You might want to extend CachedApiQueryBox to include statistics
      return {
        'totalEntries': 0,
        'validEntries': 0,
        'expiredEntries': 0,
        'totalSizeBytes': 0,
        'totalSizeKB': '0.00',
        'note': 'Cache statistics not available in current implementation',
      };
    } catch (e) {
      return {'error': 'Failed to get cache stats: $e'};
    }
  }

  /// Clean up expired cache entries
  static Future<void> cleanupExpiredCache() async {
    try {
      await _cacheBox.clearExpiredCache();
    } catch (e) {
      log('Failed to cleanup expired cache: $e');
    }
  }

  /// Cache API response using CacheConfig
  static Future<void> cacheResponseWithConfig<T>(
    String key,
    T data,
    CacheConfig config,
  ) async {
    if (!config.enabled) return;

    await cacheResponse<T>(
      config.customKey ?? key,
      data,
      expiration: config.duration,
      method: config.method,
      requestBody: config.requestBody,
      userId: config.userId,
    );
  }

  /// Get cached response using CacheConfig
  static Future<T?> getCachedResponseWithConfig<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
    CacheConfig config,
  ) async {
    if (!config.enabled) return null;

    return getCachedResponse<T>(
      config.customKey ?? key,
      fromJson,
      method: config.method,
      requestBody: config.requestBody,
      userId: config.userId,
    );
  }

  /// Check if cached response exists using CacheConfig
  static Future<bool> hasCachedResponseWithConfig(
    String key,
    CacheConfig config,
  ) async {
    if (!config.enabled) return false;

    return hasCachedResponse(
      config.customKey ?? key,
      method: config.method,
      requestBody: config.requestBody,
      userId: config.userId,
    );
  }

  /// Remove cached response using CacheConfig
  static Future<void> removeCachedResponseWithConfig(
    String key,
    CacheConfig config,
  ) async {
    await removeCachedResponse(
      config.customKey ?? key,
      method: config.method,
      requestBody: config.requestBody,
      userId: config.userId,
    );
  }

  /// Get cache key for API endpoint with parameters
  static String getCacheKey(
    String endpoint, {
    String? method,
    String? requestBody,
    int? userId,
    Map<String, dynamic>? queryParams,
  }) {
    final buffer = StringBuffer();
    buffer.write(endpoint);

    if (method != null && method != 'GET') {
      buffer.write('_$method');
    }

    if (userId != null) {
      buffer.write('_user_$userId');
    }

    if (requestBody != null && requestBody.isNotEmpty) {
      buffer.write('_body_${requestBody.hashCode}');
    }

    if (queryParams != null && queryParams.isNotEmpty) {
      final sortedParams = Map.fromEntries(
        queryParams.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
      );
      buffer.write('_params_${sortedParams.hashCode}');
    }

    return buffer.toString();
  }

  /// Cache API response with automatic key generation
  static Future<void> cacheApiResponse<T>(
    String endpoint,
    T data, {
    String? method,
    String? requestBody,
    int? userId,
    Map<String, dynamic>? queryParams,
    Duration? expiration,
  }) async {
    final cacheKey = getCacheKey(
      endpoint,
      method: method,
      requestBody: requestBody,
      userId: userId,
      queryParams: queryParams,
    );

    await cacheResponse<T>(
      cacheKey,
      data,
      expiration: expiration,
      method: method,
      requestBody: requestBody,
      userId: userId,
    );
  }

  /// Get cached API response with automatic key generation
  static Future<T?> getCachedApiResponse<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    String? method,
    String? requestBody,
    int? userId,
    Map<String, dynamic>? queryParams,
  }) async {
    final cacheKey = getCacheKey(
      endpoint,
      method: method,
      requestBody: requestBody,
      userId: userId,
      queryParams: queryParams,
    );

    return getCachedResponse<T>(
      cacheKey,
      fromJson,
      method: method,
      requestBody: requestBody,
      userId: userId,
    );
  }

  /// Check if API response is cached with automatic key generation
  static Future<bool> hasCachedApiResponse(
    String endpoint, {
    String? method,
    String? requestBody,
    int? userId,
    Map<String, dynamic>? queryParams,
  }) async {
    final cacheKey = getCacheKey(
      endpoint,
      method: method,
      requestBody: requestBody,
      userId: userId,
      queryParams: queryParams,
    );

    return hasCachedResponse(
      cacheKey,
      method: method,
      requestBody: requestBody,
      userId: userId,
    );
  }
}

/// Cache configuration for different types of API calls
class CacheConfig {
  final Duration duration;
  final bool enabled;
  final String? customKey;
  final String? method;
  final String? requestBody;
  final int? userId;

  const CacheConfig({
    this.duration = const Duration(hours: 1),
    this.enabled = true,
    this.customKey,
    this.method,
    this.requestBody,
    this.userId,
  });

  /// Default cache configuration
  static const CacheConfig defaultConfig = CacheConfig();

  /// Short-term cache (5 minutes)
  static const CacheConfig shortTerm = CacheConfig(
    duration: Duration(minutes: 5),
  );

  /// Medium-term cache (1 hour)
  static const CacheConfig mediumTerm = CacheConfig(
    duration: Duration(hours: 1),
  );

  /// Long-term cache (24 hours)
  static const CacheConfig longTerm = CacheConfig(
    duration: Duration(hours: 24),
  );

  /// No cache
  static const CacheConfig noCache = CacheConfig(enabled: false);

  /// User-specific cache configuration
  CacheConfig forUser(int userId) {
    return CacheConfig(
      duration: duration,
      enabled: enabled,
      customKey: customKey,
      method: method,
      requestBody: requestBody,
      userId: userId,
    );
  }

  /// Method-specific cache configuration
  CacheConfig forMethod(String method) {
    return CacheConfig(
      duration: duration,
      enabled: enabled,
      customKey: customKey,
      method: method,
      requestBody: requestBody,
      userId: userId,
    );
  }

  /// Request body specific cache configuration
  CacheConfig forRequestBody(String requestBody) {
    return CacheConfig(
      duration: duration,
      enabled: enabled,
      customKey: customKey,
      method: method,
      requestBody: requestBody,
      userId: userId,
    );
  }
}
