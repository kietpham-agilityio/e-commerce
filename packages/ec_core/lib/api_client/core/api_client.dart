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
