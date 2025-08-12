import 'dart:developer';

import 'package:ec_secrets/ec_secrets.dart';

/// Example API service that uses flavor configuration
class ApiService {
  ApiService._();

  /// Get the base URL for API calls based on current flavor
  static String get baseUrl => FlavorManager.apiBaseUrl;

  /// Get timeout duration based on current flavor
  static Duration get timeout =>
      Duration(seconds: FlavorManager.currentConfig.timeoutSeconds);

  /// Get max retry attempts based on current flavor
  static int get maxRetries => FlavorManager.currentConfig.maxRetries;

  /// Make a GET request with flavor-specific configuration
  static Future<Map<String, dynamic>> get(String endpoint) async {
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
  static Future<Map<String, dynamic>> post(
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
  static Map<String, dynamic> getApiConfig() {
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
  static Future<bool> isApiAvailable() async {
    try {
      await get('/health');
      return true;
    } catch (e) {
      return false;
    }
  }
}
