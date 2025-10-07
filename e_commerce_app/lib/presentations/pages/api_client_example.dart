import 'package:e_commerce_app/core/config/api_client_config.dart';
import 'package:e_commerce_app/core/di/api_client_module.dart';
import 'package:e_commerce_app/core/services/api_service.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

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

/// API Client Example Page
/// Demonstrates how to use the API client with environment-based configuration
class ApiClientExample extends StatefulWidget {
  const ApiClientExample({super.key});

  @override
  State<ApiClientExample> createState() => _ApiClientExampleState();
}

class _ApiClientExampleState extends State<ApiClientExample> {
  bool _isLoading = false;
  late final ApiService _apiService;

  @override
  void initState() {
    super.initState();

    // Initialize API service
    _apiService = ApiService();

    // Initialize logging
    ApiClientLogger.info('🔌 API Client Example initialized');
    ApiClientLogger.info('🌍 Environment: ${EcFlavor.currentEnvironment}');
    ApiClientLogger.info('🎯 Flavor: ${EcFlavor.current.displayName}');

    // Show current configuration
    final config = ApiClientConfig.getCurrentEnvironmentConfig();
    ApiClientLogger.info('📡 Base URL: ${config['baseUrl']}');
    ApiClientLogger.info('📱 App Version: ${config['appVersion']}');
    ApiClientLogger.info('🔑 API Key: ${config['apiKey']}');

    // Show actual API client configuration
    final apiClient = ApiClientModule.apiClient;
    ApiClientLogger.info('🌐 Actual Base URL: ${apiClient.baseUrl}');
    ApiClientLogger.info(
      '📋 Headers: ${apiClient.getDioClient().options.headers}',
    );
  }

  Future<void> _testApiClient() async {
    _setLoading(true);
    ApiClientLogger.info('🧪 Testing API client...');

    try {
      // Get the registered API client
      final apiClient = ApiClientModule.apiClient;

      // Test a simple GET request using the test API
      ApiClientLogger.info('📡 Making GET request to test API...');
      final startTime = DateTime.now();
      final result = await apiClient.testApiEndpoint('test', () async {
        return await apiClient.getApis();
      });
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${apiClient.baseUrl}/posts',
        statusCode: 200,
        duration: duration,
        responseData: result,
      );

      if (result['status'] == 'success') {
        ApiClientLogger.success('✅ Request successful!');
        ApiClientLogger.info('📊 Response data: ${result['response']}');
        ApiClientLogger.info('⏱️ Duration: ${result['duration_ms']}ms');
      } else {
        ApiClientLogger.error('❌ Request failed: ${result['error']}');
      }
    } catch (e) {
      ApiClientLogger.error('❌ Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  Future<void> _testFetchProducts() async {
    _setLoading(true);
    ApiClientLogger.info('🛍️ Testing fetch products API...');

    try {
      final startTime = DateTime.now();
      final products = await _apiService.fetchProducts();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiService.baseUrl}/products',
        statusCode: 200,
        duration: duration,
        responseData: products,
      );

      ApiClientLogger.success('✅ Products fetched successfully!');
      ApiClientLogger.info('📊 Found ${products.length} products');
      ApiClientLogger.info('⏱️ Duration: ${duration.inMilliseconds}ms');

      if (products.isNotEmpty) {
        ApiClientLogger.info('🛍️ First product: ${products.first}');
      }
    } catch (e) {
      ApiClientLogger.error('❌ Products Error: $e');

      // Check if it's a 404 error (endpoint doesn't exist)
      if (e.toString().contains('404')) {
        ApiClientLogger.warning(
          '⚠️ Products endpoint not available on current API',
        );
        ApiClientLogger.info(
          '💡 This is expected when using jsonplaceholder.typicode.com',
        );
        ApiClientLogger.info(
          '🔧 To test products API, configure a real e-commerce API endpoint',
        );
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testGetCart() async {
    _setLoading(true);
    ApiClientLogger.info('🛒 Testing get cart API...');

    try {
      final startTime = DateTime.now();
      final cart = await _apiService.getCart();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiService.baseUrl}/cart',
        statusCode: 200,
        duration: duration,
        responseData: cart,
      );

      ApiClientLogger.success('✅ Cart retrieved successfully!');
      ApiClientLogger.info('📊 Cart data: $cart');
      ApiClientLogger.info('⏱️ Duration: ${duration.inMilliseconds}ms');
    } catch (e) {
      ApiClientLogger.error('❌ Cart Error: $e');

      // Check if it's a 404 error (endpoint doesn't exist)
      if (e.toString().contains('404')) {
        ApiClientLogger.warning(
          '⚠️ Cart endpoint not available on current API',
        );
        ApiClientLogger.info(
          '💡 This is expected when using jsonplaceholder.typicode.com',
        );
        ApiClientLogger.info(
          '🔧 To test cart API, configure a real e-commerce API endpoint',
        );
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testGetUserOrders() async {
    _setLoading(true);
    ApiClientLogger.info('📦 Testing get user orders API...');

    try {
      final startTime = DateTime.now();
      final orders = await _apiService.getUserOrders(
        page: 1,
        limit: 5,
        status: 'completed',
      );
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${_apiService.baseUrl}/orders',
        statusCode: 200,
        duration: duration,
        responseData: orders,
      );

      ApiClientLogger.success('✅ User orders retrieved successfully!');
      ApiClientLogger.info('📊 Found ${orders.length} orders');
      ApiClientLogger.info('⏱️ Duration: ${duration.inMilliseconds}ms');

      if (orders.isNotEmpty) {
        ApiClientLogger.info('📦 First order: ${orders.first}');
      }
    } catch (e) {
      ApiClientLogger.error('❌ Orders Error: $e');

      // Check if it's a 404 error (endpoint doesn't exist)
      if (e.toString().contains('404')) {
        ApiClientLogger.warning(
          '⚠️ Orders endpoint not available on current API',
        );
        ApiClientLogger.info(
          '💡 This is expected when using jsonplaceholder.typicode.com',
        );
        ApiClientLogger.info(
          '🔧 To test orders API, configure a real e-commerce API endpoint',
        );
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testComments() async {
    _setLoading(true);
    ApiClientLogger.info('🚀 Testing comments API...');

    try {
      // Get the registered API client
      final apiClient = ApiClientModule.apiClient;

      // Test comments API
      ApiClientLogger.info('📡 Making GET request to comments API...');
      final startTime = DateTime.now();
      final result = await apiClient.testApiEndpoint('comments', () async {
        return await apiClient.getComments(1);
      });
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${apiClient.baseUrl}/posts/1/comments',
        statusCode: 200,
        duration: duration,
        responseData: result,
      );

      if (result['status'] == 'success') {
        ApiClientLogger.success('✅ Comments request successful!');
        ApiClientLogger.info('📊 Response data: ${result['response']}');
        ApiClientLogger.info('⏱️ Duration: ${result['duration_ms']}ms');
      } else {
        ApiClientLogger.error('❌ Comments request failed: ${result['error']}');
      }
    } catch (e) {
      ApiClientLogger.error('❌ Comments Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testConnectivity() async {
    _setLoading(true);
    ApiClientLogger.info('🌐 Testing API connectivity...');

    try {
      // Get the registered API client
      final apiClient = ApiClientModule.apiClient;

      // Test connectivity
      ApiClientLogger.info('📡 Making connectivity test...');
      final startTime = DateTime.now();
      final result = await apiClient.testConnectivity();
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);

      // Use detailed API success logging
      ApiClientLogger.apiSuccess(
        method: 'GET',
        url: '${apiClient.baseUrl}/health',
        statusCode: result['status_code'] ?? 200,
        duration: duration,
        responseData: result,
      );

      ApiClientLogger.success('✅ Connectivity test completed!');
      ApiClientLogger.info('📊 Status: ${result['status']}');
      ApiClientLogger.info('⏱️ Duration: ${result['duration_ms']}ms');
      ApiClientLogger.info('🕒 Timestamp: ${result['timestamp']}');

      if (result['status'] == 'success') {
        ApiClientLogger.success('🌐 API server is reachable');
      } else {
        ApiClientLogger.error('❌ API server is not reachable');
      }
    } catch (e) {
      ApiClientLogger.error('❌ Connectivity Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testApiHeaders() async {
    _setLoading(true);
    ApiClientLogger.info('🔍 Testing API headers and configuration...');

    try {
      final apiClient = ApiClientModule.apiClient;
      final dio = apiClient.getDioClient();

      ApiClientLogger.info('🌐 Base URL: ${apiClient.baseUrl}');
      ApiClientLogger.info('📋 Headers: ${dio.options.headers}');
      ApiClientLogger.info('⏱️ Connect Timeout: ${dio.options.connectTimeout}');
      ApiClientLogger.info('⏱️ Receive Timeout: ${dio.options.receiveTimeout}');

      // Test a simple request to see what headers are actually sent
      ApiClientLogger.info('📡 Making test request to verify headers...');
      final startTime = DateTime.now();

      try {
        final response = await dio.get('/posts/1');
        final endTime = DateTime.now();
        final duration = endTime.difference(startTime);

        ApiClientLogger.success('✅ Headers test successful!');
        ApiClientLogger.info('📊 Status Code: ${response.statusCode}');
        ApiClientLogger.info('⏱️ Duration: ${duration.inMilliseconds}ms');
        ApiClientLogger.info('📋 Response Headers: ${response.headers}');
      } catch (e) {
        ApiClientLogger.error('❌ Headers test failed: $e');
      }
    } catch (e) {
      ApiClientLogger.error('❌ Configuration Error: $e');
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
      ApiClientLogger.error('❌ Failed to show Talker logs: $e');

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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      appBar: EcAppBar(title: const EcTitleMediumText('🔌 API Client Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      Icon(Icons.info, color: Colors.blue.shade700, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'API Client Demo with Logger Integration',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This API client example now uses proper LoggerDI integration with Talker logging. '
                    'All API calls are logged with structured information. Use "Open Talker Logs" to view detailed logs.',
                    style: TextStyle(fontSize: 14, color: Colors.blue.shade600),
                  ),
                ],
              ),
            ),

            // API Endpoint Info Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.orange.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'API Endpoint Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Currently using jsonplaceholder.typicode.com which only supports /posts and /comments endpoints. '
                    'E-commerce endpoints (/products, /cart, /orders) will return 404 errors. '
                    'This is expected behavior for testing purposes.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Configuration Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EcTitleSmallText('Current Configuration'),
                  const SizedBox(height: 8),
                  ...ApiClientConfig.getCurrentEnvironmentConfig().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: EcBodyMediumText(
                              '${entry.key}:',
                              color: colorScheme.primary,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: EcBodyMediumText(entry.value),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                EcElevatedButton(
                  text: 'Test API Client',
                  onPressed: _isLoading ? null : _testApiClient,
                ),
                EcElevatedButton(
                  text: 'Test Headers',
                  onPressed: _isLoading ? null : _testApiHeaders,
                ),
                EcElevatedButton(
                  text: 'Test Comments',
                  onPressed: _isLoading ? null : _testComments,
                ),
                EcElevatedButton(
                  text: 'Test Connectivity',
                  onPressed: _isLoading ? null : _testConnectivity,
                ),
                EcElevatedButton(
                  text: 'Fetch Products',
                  onPressed: _isLoading ? null : _testFetchProducts,
                ),
                EcElevatedButton(
                  text: 'Get Cart',
                  onPressed: _isLoading ? null : _testGetCart,
                ),
                EcElevatedButton(
                  text: 'Get User Orders',
                  onPressed: _isLoading ? null : _testGetUserOrders,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Loading indicator
            if (_isLoading) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const EcBodyMediumText('Testing API endpoints...'),
            ],

            const SizedBox(height: 24),

            // Talker Logs Button
            SizedBox(
              width: double.infinity,
              child: EcElevatedButton(
                text: 'Open Talker Logs',
                onPressed: _showTalkerLogs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
