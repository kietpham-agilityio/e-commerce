import 'dart:async';
import '../api_client/apis/failure.dart';
import '../api_client/core/base_api_service.dart';
import 'api_status.dart';

/// Configuration for maybeFetch operations
class MaybeFetchConfig {
  const MaybeFetchConfig({
    this.forceRefresh = false,
    this.cacheTimeout = const Duration(minutes: 5),
    this.retryOnError = true,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  /// Force refresh even if data exists
  final bool forceRefresh;
  
  /// How long to cache successful responses
  final Duration cacheTimeout;
  
  /// Whether to retry on error
  final bool retryOnError;
  
  /// Maximum number of retry attempts
  final int maxRetries;
  
  /// Delay between retry attempts
  final Duration retryDelay;
}

/// Cache entry for maybeFetch operations
class _CacheEntry<T> {
  _CacheEntry(this.data, this.timestamp);
  
  final T data;
  final DateTime timestamp;
  
  bool get isExpired => DateTime.now().difference(timestamp) > const Duration(minutes: 5);
}

/// Utility class for maybeFetch operations with status tracking
class MaybeFetchUtils {
  static final Map<String, _CacheEntry> _cache = {};
  static final Map<String, StreamController<ApiState>> _streamControllers = {};
  
  /// Clear all cached data
  static void clearCache() {
    _cache.clear();
  }
  
  /// Clear specific cached data
  static void clearCacheForKey(String key) {
    _cache.remove(key);
  }
  
  /// Get cached data if available and not expired
  static T? getCachedData<T>(String key) {
    final entry = _cache[key] as _CacheEntry<T>?;
    if (entry != null && !entry.isExpired) {
      return entry.data;
    }
    return null;
  }
  
  /// Cache data with timestamp
  static void cacheData<T>(String key, T data) {
    _cache[key] = _CacheEntry(data, DateTime.now());
  }
  
  /// Get or create stream controller for a key
  static StreamController<ApiState> _getStreamController(String key) {
    return _streamControllers.putIfAbsent(key, () => StreamController<ApiState>.broadcast());
  }
  
  /// Dispose stream controller for a key
  static void disposeStreamController(String key) {
    _streamControllers[key]?.close();
    _streamControllers.remove(key);
  }
  
  /// Dispose all stream controllers
  static void disposeAllStreamControllers() {
    for (final controller in _streamControllers.values) {
      controller.close();
    }
    _streamControllers.clear();
  }
  
  /// Maybe fetch data with status tracking
  /// Returns a stream of ApiState that emits status updates
  static Stream<ApiState<T>> maybeFetch<T>({
    required String key,
    required Future<T> Function() fetchFunction,
    MaybeFetchConfig config = const MaybeFetchConfig(),
  }) {
    final controller = _getStreamController(key);
    
    // Check cache first
    final cachedData = getCachedData<T>(key);
    if (cachedData != null && !config.forceRefresh) {
      // Emit cached data immediately
      controller.add(ApiState.success(cachedData));
      return controller.stream.cast<ApiState<T>>();
    }
    
    // Start fetching
    _performFetch<T>(
      key: key,
      fetchFunction: fetchFunction,
      controller: controller,
      config: config,
    );
    
    return controller.stream.cast<ApiState<T>>();
  }
  
  /// Perform the actual fetch operation with retry logic
  static Future<void> _performFetch<T>({
    required String key,
    required Future<T> Function() fetchFunction,
    required StreamController<ApiState> controller,
    required MaybeFetchConfig config,
  }) async {
    // Emit loading state
    controller.add(ApiState.loading(isRefreshing: false));
    
    int attempts = 0;
    while (attempts < config.maxRetries) {
      try {
        attempts++;
        
        // Perform the fetch
        final data = await fetchFunction();
        
        // Cache the successful result
        cacheData(key, data);
        
        // Emit success state
        controller.add(ApiState.success(data));
        return;
        
      } on Failure catch (failure) {
        // Check if we should retry
        if (attempts >= config.maxRetries || !config.retryOnError || !_shouldRetry(failure)) {
          // Emit error state
          controller.add(ApiState.error(failure));
          return;
        }
        
        // Wait before retrying
        if (attempts < config.maxRetries) {
          await Future.delayed(config.retryDelay * attempts);
        }
        
      } catch (e) {
        // Handle unexpected errors
        final failure = Failure<dynamic>(
          'Unexpected error: $e',
          internalErrorCode: null,
        );
        
        if (attempts >= config.maxRetries || !config.retryOnError) {
          controller.add(ApiState.error(failure));
          return;
        }
        
        // Wait before retrying
        if (attempts < config.maxRetries) {
          await Future.delayed(config.retryDelay * attempts);
        }
      }
    }
    
    // If we get here, all retries failed
    controller.add(ApiState.error(
      Failure<dynamic>(
        'Failed after ${config.maxRetries} attempts',
        internalErrorCode: null,
      ),
    ));
  }
  
  /// Check if a failure should trigger a retry
  static bool _shouldRetry(Failure failure) {
    // Don't retry on authentication errors
    if (failure.isAuthError) return false;
    
    // Retry on network and server errors
    if (failure.isNetworkError || failure.isServerError) return true;
    
    // Don't retry on client errors (4xx)
    if (failure.apiClientError != null) {
      return failure.apiClientError!.maybeWhen(
        badRequest: (_, __, ___) => false,
        unauthorizedRequest: (_, __, ___) => false,
        forbiddenRequest: (_, __, ___) => false,
        notFound: (_, __, ___) => false,
        methodNotAllowed: (_, __, ___) => false,
        notAcceptable: (_, __, ___) => false,
        orElse: () => true,
      );
    }
    
    return false;
  }
  
  /// Maybe fetch with BaseApiService integration
  static Stream<ApiState<T>> maybeFetchWithService<T>({
    required String key,
    required BaseApiService service,
    required Future<T> Function() apiCall,
    MaybeFetchConfig config = const MaybeFetchConfig(),
  }) {
    return maybeFetch<T>(
      key: key,
      fetchFunction: () => service.safeApiCall(apiCall),
      config: config,
    );
  }
  
  /// Maybe fetch with retry logic using BaseApiService
  static Stream<ApiState<T>> maybeFetchWithRetry<T>({
    required String key,
    required BaseApiService service,
    required Future<T> Function() apiCall,
    MaybeFetchConfig config = const MaybeFetchConfig(),
  }) {
    return maybeFetch<T>(
      key: key,
      fetchFunction: () => service.safeApiCallWithRetry(
        apiCall,
        maxRetries: config.maxRetries,
        delay: config.retryDelay,
      ),
      config: config.copyWith(retryOnError: false), // Retry is handled by service
    );
  }
  
  /// Refresh data (force fetch regardless of cache)
  static Stream<ApiState<T>> refresh<T>({
    required String key,
    required Future<T> Function() fetchFunction,
    MaybeFetchConfig config = const MaybeFetchConfig(),
  }) {
    return maybeFetch<T>(
      key: key,
      fetchFunction: fetchFunction,
      config: config.copyWith(forceRefresh: true),
    );
  }
  
  /// Refresh with BaseApiService integration
  static Stream<ApiState<T>> refreshWithService<T>({
    required String key,
    required BaseApiService service,
    required Future<T> Function() apiCall,
    MaybeFetchConfig config = const MaybeFetchConfig(),
  }) {
    return refresh<T>(
      key: key,
      fetchFunction: () => service.safeApiCall(apiCall),
      config: config,
    );
  }
}

/// Extension for MaybeFetchConfig to create copies with modifications
extension MaybeFetchConfigExtension on MaybeFetchConfig {
  /// Create a copy with modified properties
  MaybeFetchConfig copyWith({
    bool? forceRefresh,
    Duration? cacheTimeout,
    bool? retryOnError,
    int? maxRetries,
    Duration? retryDelay,
  }) {
    return MaybeFetchConfig(
      forceRefresh: forceRefresh ?? this.forceRefresh,
      cacheTimeout: cacheTimeout ?? this.cacheTimeout,
      retryOnError: retryOnError ?? this.retryOnError,
      maxRetries: maxRetries ?? this.maxRetries,
      retryDelay: retryDelay ?? this.retryDelay,
    );
  }
}
