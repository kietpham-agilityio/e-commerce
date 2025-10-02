import 'package:e_commerce_app/core/config/api_client_config.dart';
import 'package:e_commerce_app/core/di/api_client_module.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

/// API Client Example Page
/// Demonstrates how to use the API client with environment-based configuration
class ApiClientExample extends StatefulWidget {
  const ApiClientExample({super.key});

  @override
  State<ApiClientExample> createState() => _ApiClientExampleState();
}

class _ApiClientExampleState extends State<ApiClientExample> {
  final List<String> _logs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addLog('API Client Example initialized');
    _addLog('Environment: ${EcFlavor.currentEnvironment}');
    _addLog('Flavor: ${EcFlavor.current.displayName}');

    // Show current configuration
    final config = ApiClientConfig.getCurrentEnvironmentConfig();
    _addLog('Base URL: ${config['baseUrl']}');
    _addLog('API Key: ${config['apiKey']}');
    _addLog('App Version: ${config['appVersion']}');
  }

  void _addLog(String message) {
    setState(() {
      _logs.add('${DateTime.now().toIso8601String()}: $message');
    });
  }

  Future<void> _testApiClient() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _addLog('Testing API client...');

      // Get the registered API client
      final apiClient = ApiClientModule.apiClient;

      // Test a simple GET request using the test API
      _addLog('Making GET request to test API...');
      final result = await apiClient.testApiEndpoint('test', () async {
        return await apiClient.getApis();
      });

      if (result['status'] == 'success') {
        _addLog('✅ Request successful!');
        _addLog('Response data: ${result['response']}');
        _addLog('Duration: ${result['duration_ms']}ms');
      } else {
        _addLog('❌ Request failed: ${result['error']}');
      }
    } catch (e) {
      _addLog('❌ Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testComments() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _addLog('Testing comments API...');

      // Get the registered API client
      final apiClient = ApiClientModule.apiClient;

      // Test comments API
      _addLog('Making GET request to comments API...');
      final result = await apiClient.testApiEndpoint('comments', () async {
        return await apiClient.getComments(1);
      });

      if (result['status'] == 'success') {
        _addLog('✅ Comments request successful!');
        _addLog('Response data: ${result['response']}');
        _addLog('Duration: ${result['duration_ms']}ms');
      } else {
        _addLog('❌ Comments request failed: ${result['error']}');
      }
    } catch (e) {
      _addLog('❌ Comments Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testConnectivity() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _addLog('Testing API connectivity...');

      // Get the registered API client
      final apiClient = ApiClientModule.apiClient;

      // Test connectivity
      _addLog('Making connectivity test...');
      final result = await apiClient.testConnectivity();

      _addLog('✅ Connectivity test completed!');
      _addLog('Status: ${result['status']}');
      _addLog('Duration: ${result['duration_ms']}ms');
      _addLog('Timestamp: ${result['timestamp']}');
    } catch (e) {
      _addLog('❌ Connectivity Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
    });
    _addLog('Logs cleared');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      appBar: EcAppBar(title: const EcTitleMediumText('🔌 API Client Example')),
      body: Column(
        children: [
          // Configuration Info
          Container(
            padding: const EdgeInsets.all(16),
            color: colorScheme.surface,
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
                        Expanded(flex: 3, child: EcBodyMediumText(entry.value)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: EcElevatedButton(
                        text: 'Test API Client',
                        onPressed: _isLoading ? null : _testApiClient,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: EcElevatedButton(
                        text: 'Test Comments',
                        onPressed: _isLoading ? null : _testComments,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: EcElevatedButton(
                        text: 'Test Connectivity',
                        onPressed: _isLoading ? null : _testConnectivity,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: EcElevatedButton(
                        text: 'Clear Logs',
                        onPressed: _clearLogs,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Logs Section
          Expanded(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const EcTitleSmallText('API Logs'),
                        const Spacer(),
                        if (_isLoading)
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child:
                        _logs.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 48,
                                    color: colorScheme.secondary,
                                  ),
                                  const SizedBox(height: 16),
                                  EcBodyLargeText(
                                    'No logs yet',
                                    color: colorScheme.secondary,
                                  ),
                                  const SizedBox(height: 8),
                                  EcBodySmallText(
                                    'Tap "Test API Client" to start',
                                    color: colorScheme.secondary,
                                  ),
                                ],
                              ),
                            )
                            : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _logs.length,
                              itemBuilder: (context, index) {
                                final log = _logs[index];
                                final isError = log.contains('❌');
                                final isSuccess = log.contains('✅');

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (isError)
                                        Icon(
                                          Icons.error,
                                          size: 16,
                                          color: colorScheme.error,
                                        )
                                      else if (isSuccess)
                                        Icon(
                                          Icons.check_circle,
                                          size: 16,
                                          color: Colors.green,
                                        )
                                      else
                                        Icon(
                                          Icons.info,
                                          size: 16,
                                          color: colorScheme.secondary,
                                        ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: EcBodySmallText(
                                          log,
                                          color:
                                              isError
                                                  ? colorScheme.error
                                                  : isSuccess
                                                  ? Colors.green
                                                  : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
