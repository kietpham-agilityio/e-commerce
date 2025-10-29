import 'package:e_commerce_app/core/config/api_client_config.dart';
import 'package:e_commerce_app/core/di/api_client_module.dart';
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

  @override
  void initState() {
    super.initState();
  }

  /// Test home API call - success case
  Future<void> _testHomeApi() async {
    setState(() => _isLoading = true);

    try {
      final apiClient = ApiClientModule.apiClient;

      // Call the home API - this will be automatically logged by Network Logger
      await apiClient.homeApi.getHome();
    } catch (e) {
      // Errors are automatically logged by Network Logger
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Test error logging
  Future<void> _testErrorLogging() async {
    setState(() => _isLoading = true);

    try {
      // Simulate an error by calling invalid endpoint
      final apiClient = ApiClientModule.apiClient;
      final dio = apiClient.getDioClient();

      // This will trigger an error (404 or similar)
      await dio.get('/invalid-endpoint-for-testing-error');
    } catch (e) {
      // Error will be automatically logged by Network Logger
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Test info and warning logs
  void _testInfoWarningLogs() {
    // Log info messages
    ApiClientLogger.info('ℹ️ This is an info message');
    ApiClientLogger.info('📝 Info: Application is running smoothly');
    ApiClientLogger.info('🔔 Info: User logged in successfully');

    // Log warning messages
    ApiClientLogger.warning('⚠️ This is a warning message');
    ApiClientLogger.warning('⚡ Warning: API response time is slow');
    ApiClientLogger.warning('🔋 Warning: Low battery detected');

    // Log success message
    ApiClientLogger.success('✅ This is a success message');

    // Log good message
    LoggerDI.good('👍 This is a good message');
  }

  void _showNetworkLogs() {
    try {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const EcTalkerScreen()));
    } catch (e) {
      ApiClientLogger.error('❌ Failed to show Network logs: $e');

      // Show error dialog
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Network Logger Error'),
              content: Text('Error accessing Network logs: $e'),
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
                        'API Client Demo with Network Logger',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This API client example now uses proper LoggerDI integration with Network logging. '
                    'All API calls are logged with structured information. Use "Open Network Logs" to view detailed logs.',
                    style: TextStyle(fontSize: 14, color: Colors.blue.shade600),
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
                  text: 'Test Success API',
                  onPressed: _isLoading ? null : _testHomeApi,
                ),
                EcElevatedButton(
                  text: 'Test Error API',
                  onPressed: _isLoading ? null : _testErrorLogging,
                ),
                EcElevatedButton(
                  text: 'Test Info & Warning',
                  onPressed: _testInfoWarningLogs,
                ),
                EcElevatedButton(
                  text: '📋 Open Network Logs',
                  onPressed: _showNetworkLogs,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Loading indicator
            if (_isLoading) ...[
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 16),
              const Center(child: EcBodyMediumText('Testing API...')),
            ],
          ],
        ),
      ),
    );
  }
}
