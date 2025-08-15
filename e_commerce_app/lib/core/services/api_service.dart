import 'dart:developer';
import 'package:ec_flavor/ec_flavor.dart';

/// API service that uses flavor configuration and dependency injection
class ApiService {
  final String baseUrl;
  final Duration timeout;
  final int maxRetries;

  /// Constructor with dependency injection
  ApiService({
    required this.baseUrl,
    required this.timeout,
    required this.maxRetries,
  });

  /// Get the base URL for API calls
  String get apiBaseUrl => baseUrl;

  /// Get timeout duration
  Duration get apiTimeout => timeout;

  /// Get max retry attempts
  int get apiMaxRetries => maxRetries;

  /// Make a GET request with flavor-specific configuration
  Future<Map<String, dynamic>> get(String endpoint) async {
    final url = '$baseUrl$endpoint';

    // Log the request if logging is enabled
    if (FlavorManager.isFeatureEnabled('logging')) {
      log('GET request to: $url');
      log('Timeout: ${timeout.inSeconds}s, Max retries: $maxRetries');
    }

    // Simulate API call with timeout
    try {
      // In a real app, this would be an actual HTTP request
      await Future.delayed(const Duration(milliseconds: 500));

      if (FlavorManager.isFeatureEnabled('logging')) {
        log('Request completed successfully');
      }

      return {
        'success': true,
        'data': 'Sample data from $endpoint',
        'flavor': FlavorManager.currentFlavor.displayName,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      if (FlavorManager.isFeatureEnabled('logging')) {
        log('Request failed: $e');
      }
      rethrow;
    }
  }

  /// Make a POST request with flavor-specific configuration
  Future<Map<String, dynamic>?> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final url = '$baseUrl$endpoint';

    // Log the request if logging is enabled
    if (FlavorManager.isFeatureEnabled('logging')) {
      log('POST request to: $url');
      log('Data: $data');
      log('Timeout: ${timeout.inSeconds}s, Max retries: $maxRetries');
    }

    // Simulate API call with timeout
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      if (FlavorManager.isFeatureEnabled('logging')) {
        log('Request completed successfully');
      }

      return {
        'success': true,
        'data': 'Data posted to $endpoint',
        'flavor': FlavorManager.currentFlavor.displayName,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      if (FlavorManager.isFeatureEnabled('logging')) {
        log('Request failed: $e');
      }
      rethrow;
    }
  }

  /// Get API configuration summary for debugging
  Map<String, dynamic> getApiConfig() {
    return {
      'baseUrl': baseUrl,
      'timeout': '${timeout.inSeconds}s',
      'maxRetries': maxRetries,
      'flavor': FlavorManager.currentFlavor.displayName,
      'logging': FlavorManager.isFeatureEnabled('logging'),
      'analytics': FlavorManager.isFeatureEnabled('analytics'),
    };
  }

  /// Check if API is available (useful for offline detection)
  Future<bool> isApiAvailable() async {
    try {
      await get('/health');
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Make a request with retry logic
  Future<Map<String, dynamic>> getWithRetry(String endpoint) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      try {
        attempts++;
        return await get(endpoint);
      } catch (e) {
        if (attempts >= maxRetries) {
          rethrow;
        }
        
        if (FlavorManager.isFeatureEnabled('logging')) {
          log('Attempt $attempts failed, retrying... Error: $e');
        }
        
        // Wait before retry (exponential backoff)
        await Future.delayed(Duration(milliseconds: 100 * attempts));
      }
    }
    
    throw Exception('Max retries exceeded');
  }

  /// Make a POST request with retry logic
  Future<Map<String, dynamic>?> postWithRetry(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      try {
        attempts++;
        return await post(endpoint, data);
      } catch (e) {
        if (attempts >= maxRetries) {
          rethrow;
        }
        
        if (FlavorManager.isFeatureEnabled('logging')) {
          log('Attempt $attempts failed, retrying... Error: $e');
        }
        
        // Wait before retry (exponential backoff)
        await Future.delayed(Duration(milliseconds: 100 * attempts));
      }
    }
    
    throw Exception('Max retries exceeded');
  }
}
