import 'dart:async';
import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../button.dart';

/// Simple logger interface for the API client example
class ApiClientLogger {
  static final List<String> _logs = [];
  static final List<void Function(String)> _listeners = [];

  /// Add a log message
  static void log(String message) {
    final timestampedMessage =
        '${DateTime.now().toString().substring(11, 19)}: $message';
    _logs.insert(0, timestampedMessage);
    if (_logs.length > 50) {
      _logs.removeLast();
    }

    // Notify listeners
    for (final listener in _listeners) {
      listener(timestampedMessage);
    }
  }

  /// Add a listener for log updates
  static void addListener(void Function(String) listener) {
    _listeners.add(listener);
  }

  /// Remove a listener
  static void removeListener(void Function(String) listener) {
    _listeners.remove(listener);
  }

  /// Get all logs
  static List<String> get logs => List.unmodifiable(_logs);

  /// Clear all logs
  static void clear() {
    _logs.clear();
    for (final listener in _listeners) {
      listener('Logs cleared');
    }
  }

  /// Log info message
  static void info(String message) => log('INFO: $message');

  /// Log error message
  static void error(String message) => log('ERROR: $message');

  /// Log success message
  static void success(String message) => log('SUCCESS: $message');

  /// Log warning message
  static void warning(String message) => log('WARNING: $message');
}

/// Example page demonstrating API client concepts with mock implementations
class ApiClientExample extends StatefulWidget {
  const ApiClientExample({super.key});

  @override
  State<ApiClientExample> createState() => _ApiClientExampleState();
}

class _ApiClientExampleState extends State<ApiClientExample> {
  bool _isLoading = false;

  // Mock API client for demonstration
  late MockApiClient _mockApiClient;

  @override
  void initState() {
    super.initState();
    _mockApiClient = MockApiClient();

    // Listen to logger updates
    ApiClientLogger.addListener(_onLogUpdate);
  }

  @override
  void dispose() {
    // Remove listener
    ApiClientLogger.removeListener(_onLogUpdate);
    super.dispose();
  }

  void _onLogUpdate(String message) {
    if (mounted) {
      setState(() {});
    }
  }

  void _setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  // ============================================================================
  // BASIC HTTP METHODS EXAMPLES
  // ============================================================================

  Future<void> _testGetRequest() async {
    _setLoading(true);
    ApiClientLogger.info('Starting GET request to /posts/1');

    try {
      final response = await _mockApiClient.get<Map<String, dynamic>>(
        '/posts/1',
      );
      ApiClientLogger.success('GET Success: ${response['title']}');
    } catch (e) {
      ApiClientLogger.error('GET Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testPostRequest() async {
    _setLoading(true);
    ApiClientLogger.info('Starting POST request to /posts');

    try {
      final postData = {
        'title': 'API Client Example Post',
        'body': 'This is a test post created by the API client example',
        'userId': 1,
      };

      final response = await _mockApiClient.post<Map<String, dynamic>>(
        '/posts',
        data: postData,
      );
      ApiClientLogger.success(
        'POST Success: Created post with ID ${response['id']}',
      );
    } catch (e) {
      ApiClientLogger.error('POST Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testPutRequest() async {
    _setLoading(true);
    ApiClientLogger.info('Starting PUT request to /posts/1');

    try {
      final putData = {
        'id': 1,
        'title': 'Updated Post Title',
        'body': 'This post has been updated via PUT request',
        'userId': 1,
      };

      final response = await _mockApiClient.put<Map<String, dynamic>>(
        '/posts/1',
        data: putData,
      );
      ApiClientLogger.success(
        'PUT Success: Updated post - ${response['title']}',
      );
    } catch (e) {
      ApiClientLogger.error('PUT Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testPatchRequest() async {
    _setLoading(true);
    ApiClientLogger.info('Starting PATCH request to /posts/1');

    try {
      final patchData = {'title': 'Partially Updated Title'};

      final response = await _mockApiClient.patch<Map<String, dynamic>>(
        '/posts/1',
        data: patchData,
      );
      ApiClientLogger.success(
        'PATCH Success: Updated title to - ${response['title']}',
      );
    } catch (e) {
      ApiClientLogger.error('PATCH Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testDeleteRequest() async {
    _setLoading(true);
    ApiClientLogger.info('Starting DELETE request to /posts/1');

    try {
      await _mockApiClient.delete('/posts/1');
      ApiClientLogger.success('DELETE Success: Post deleted');
    } catch (e) {
      ApiClientLogger.error('DELETE Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================================
  // MAYBE FETCH EXAMPLES
  // ============================================================================

  Future<void> _testMaybeFetch() async {
    _setLoading(true);
    ApiClientLogger.info('Starting maybe fetch with retry logic');

    try {
      final result = await _mockApiClient.maybeFetch<Map<String, dynamic>>(
        () => _mockApiClient.get<Map<String, dynamic>>('/posts/2'),
        maxRetries: 3,
        delay: const Duration(seconds: 1),
      );
      ApiClientLogger.success('Maybe Fetch Success: ${result['title']}');
    } catch (e) {
      ApiClientLogger.error('Maybe Fetch Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testMaybeFetchWithFailure() async {
    _setLoading(true);
    ApiClientLogger.info('Starting maybe fetch with intentional failure');

    try {
      final result = await _mockApiClient.maybeFetch<Map<String, dynamic>>(
        () => _mockApiClient.get<Map<String, dynamic>>('/nonexistent-endpoint'),
        maxRetries: 2,
        delay: const Duration(milliseconds: 500),
      );
      ApiClientLogger.success('Maybe Fetch Success: $result');
    } catch (e) {
      ApiClientLogger.error('Maybe Fetch Failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================================
  // FORCE FETCH EXAMPLES
  // ============================================================================

  Future<void> _testForceFetch() async {
    _setLoading(true);
    ApiClientLogger.info('Starting force fetch (bypasses cache)');

    try {
      final result = await _mockApiClient.forceFetch<Map<String, dynamic>>(
        () => _mockApiClient.get<Map<String, dynamic>>('/posts/3'),
        maxRetries: 2,
        delay: const Duration(seconds: 1),
      );
      ApiClientLogger.success('Force Fetch Success: ${result['title']}');
    } catch (e) {
      ApiClientLogger.error('Force Fetch Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================================
  // BACKGROUND API CALL EXAMPLES
  // ============================================================================

  Future<void> _testBackgroundGet() async {
    ApiClientLogger.info('Starting background GET request');

    try {
      final result = await _mockApiClient
          .getRunBackground<Map<String, dynamic>>(
            '/posts/4',
            errorContext: 'Background GET Test',
            timeout: const Duration(seconds: 15),
          );
      await Future.delayed(const Duration(seconds: 5));
      ApiClientLogger.success('Background GET Success: ${result['title']}');
    } catch (e) {
      ApiClientLogger.error('Background GET Error: $e');
    }
  }

  Future<void> _testBackgroundPost() async {
    ApiClientLogger.info('Starting background POST request');

    try {
      final postData = {
        'title': 'Background Post',
        'body': 'This post was created in the background',
        'userId': 1,
      };

      final result = await _mockApiClient
          .postRunBackground<Map<String, dynamic>>(
            '/posts',
            data: postData,
            errorContext: 'Background POST Test',
            timeout: const Duration(seconds: 15),
          );
      ApiClientLogger.success(
        'Background POST Success: Created post ${result['id']}',
      );
    } catch (e) {
      ApiClientLogger.error('Background POST Error: $e');
    }
  }

  // ============================================================================
  // RESPONSE HANDLING EXAMPLES
  // ============================================================================

  Future<void> _testListResponse() async {
    _setLoading(true);
    ApiClientLogger.info('Starting list response handling test');

    try {
      final response = await _mockApiClient.get<List<dynamic>>(
        '/posts?_limit=5',
      );
      final posts = _mockApiClient.handleListResponse<Map<String, dynamic>>(
        response,
        (item) => Map<String, dynamic>.from(item),
      );
      ApiClientLogger.success(
        'List Response Success: Got ${posts.length} posts',
      );
      for (int i = 0; i < posts.length && i < 3; i++) {
        ApiClientLogger.info('  - Post ${i + 1}: ${posts[i]['title']}');
      }
    } catch (e) {
      ApiClientLogger.error('List Response Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _testErrorHandling() async {
    _setLoading(true);
    ApiClientLogger.info('Starting error handling test');

    try {
      // This should fail with 404
      await _mockApiClient.get('/posts/99999');
      ApiClientLogger.warning('Error Handling: Unexpected success');
    } catch (e) {
      final handledError = _mockApiClient.handleError(e as Exception);
      ApiClientLogger.success(
        'Error Handling Success: ${handledError.message}',
      );
    } finally {
      _setLoading(false);
    }
  }

  // ============================================================================
  // HEADER MANAGEMENT EXAMPLES
  // ============================================================================

  Future<void> _testHeaderManagement() async {
    _setLoading(true);
    ApiClientLogger.info('Testing header management');

    try {
      // Add custom headers
      _mockApiClient.addHeader('X-Custom-Header', 'Example-Value');
      _mockApiClient.addHeader(
        'X-Request-ID',
        '${DateTime.now().millisecondsSinceEpoch}',
      );

      // Make a request with custom headers
      final response = await _mockApiClient.get<Map<String, dynamic>>(
        '/posts/5',
      );
      ApiClientLogger.success('Header Test Success: ${response['title']}');

      // Remove custom headers
      _mockApiClient.removeHeader('X-Custom-Header');
      _mockApiClient.removeHeader('X-Request-ID');
      ApiClientLogger.info('Headers removed successfully');
    } catch (e) {
      ApiClientLogger.error('Header Test Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _clearLogs() {
    ApiClientLogger.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(titleText: 'API Client Examples'),
      body: Column(
        children: [
          // Loading indicator
          if (_isLoading) const LinearProgressIndicator(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            Icon(
                              Icons.info,
                              color: Colors.blue.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Mock API Client Demo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This example demonstrates API client concepts using mock implementations. '
                          'In a real app, you would use the actual ApiClient from ec_core package.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Basic HTTP Methods Section
                  _buildSection(
                    title: 'Basic HTTP Methods',
                    children: [
                      _buildButtonGrid([
                        ('GET Request', _testGetRequest),
                        ('POST Request', _testPostRequest),
                        ('PUT Request', _testPutRequest),
                        ('PATCH Request', _testPatchRequest),
                        ('DELETE Request', _testDeleteRequest),
                      ]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Maybe Fetch Section
                  _buildSection(
                    title: 'Maybe Fetch (with retry)',
                    children: [
                      _buildButtonGrid([
                        ('Maybe Fetch Success', _testMaybeFetch),
                        ('Maybe Fetch with Retry', _testMaybeFetchWithFailure),
                      ]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Force Fetch Section
                  _buildSection(
                    title: 'Force Fetch (bypass cache)',
                    children: [
                      _buildButtonGrid([('Force Fetch', _testForceFetch)]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Background API Calls Section
                  _buildSection(
                    title: 'Background API Calls',
                    children: [
                      _buildButtonGrid([
                        ('Background GET', _testBackgroundGet),
                        ('Background POST', _testBackgroundPost),
                      ]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Response Handling Section
                  _buildSection(
                    title: 'Response Handling',
                    children: [
                      _buildButtonGrid([
                        ('List Response', _testListResponse),
                        ('Error Handling', _testErrorHandling),
                        ('Header Management', _testHeaderManagement),
                      ]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Logs Section
                  _buildSection(
                    title: 'Request Logs',
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('API Call Results:'),
                          EcTextButton(
                            text: 'Clear Logs',
                            onPressed: _clearLogs,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 300,
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade600),
                        ),
                        child:
                            ApiClientLogger.logs.isEmpty
                                ? const Center(
                                  child: Text(
                                    'No logs yet. Make some API calls!',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                                : ListView.builder(
                                  itemCount: ApiClientLogger.logs.length,
                                  itemBuilder: (context, index) {
                                    final log = ApiClientLogger.logs[index];
                                    final isError = log.contains('ERROR:');
                                    final isWarning = log.contains('WARNING:');
                                    final isSuccess = log.contains('SUCCESS:');

                                    Color logColor;
                                    if (isError) {
                                      logColor = Colors.red.shade300;
                                    } else if (isWarning) {
                                      logColor = Colors.orange.shade300;
                                    } else if (isSuccess) {
                                      logColor = Colors.green.shade300;
                                    } else {
                                      logColor = Colors.blue.shade300;
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: Text(
                                        log,
                                        style: TextStyle(
                                          color: logColor,
                                          fontSize: 12,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildButtonGrid(List<(String, VoidCallback)> buttons) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          buttons.map((button) {
            return SizedBox(
              width: 150,
              child: EcElevatedButton(
                text: button.$1,
                onPressed: _isLoading ? null : button.$2,
              ),
            );
          }).toList(),
    );
  }
}

// ============================================================================
// MOCK API CLIENT IMPLEMENTATION
// ============================================================================

/// Mock API client that simulates the behavior of the real ApiClient
/// This demonstrates the concepts without requiring actual HTTP calls
class MockApiClient {
  final Map<String, String> _headers = {};

  // Simulate network delay
  Future<void> _simulateDelay() async {
    await Future.delayed(
      Duration(milliseconds: 500 + (DateTime.now().millisecond % 1000)),
    );
  }

  // Simulate random failures for demonstration
  bool _shouldFail() {
    return DateTime.now().millisecond % 10 == 0; // 10% chance of failure
  }

  Future<T> get<T>(String uri) async {
    await _simulateDelay();

    if (uri.contains('99999') || uri.contains('nonexistent')) {
      throw Exception('404 Not Found');
    }

    if (_shouldFail()) {
      throw Exception('Network Error');
    }

    final mockData = <String, dynamic>{
      'id': 1,
      'title': 'Sample Post Title',
      'body': 'This is a sample post body content.',
      'userId': 1,
    };

    if (uri.contains('_limit=5')) {
      return List.generate(
            5,
            (index) => {
              ...mockData,
              'id': index + 1,
              'title': 'Sample Post ${index + 1}',
            },
          )
          as T;
    }

    return mockData as T;
  }

  Future<T> post<T>(String uri, {required dynamic data}) async {
    await _simulateDelay();

    if (_shouldFail()) {
      throw Exception('Network Error');
    }

    final responseData = <String, dynamic>{
      'id': DateTime.now().millisecondsSinceEpoch,
      ...Map<String, dynamic>.from(data),
    };

    return responseData as T;
  }

  Future<T> put<T>(String uri, {required dynamic data}) async {
    await _simulateDelay();

    if (_shouldFail()) {
      throw Exception('Network Error');
    }

    return Map<String, dynamic>.from(data) as T;
  }

  Future<T> patch<T>(String uri, {required dynamic data}) async {
    await _simulateDelay();

    if (_shouldFail()) {
      throw Exception('Network Error');
    }

    final baseData = <String, dynamic>{
      'id': 1,
      'title': 'Original Title',
      'body': 'Original body content',
      'userId': 1,
    };

    return {...baseData, ...Map<String, dynamic>.from(data)} as T;
  }

  Future<T?> delete<T>(String uri) async {
    await _simulateDelay();

    if (_shouldFail()) {
      throw Exception('Network Error');
    }

    return null; // DELETE typically returns null
  }

  // Maybe fetch with retry logic
  Future<T> maybeFetch<T>(
    Future<T> Function() apiCall, {
    int maxRetries = 0,
    Duration delay = const Duration(seconds: 1),
  }) async {
    int attempts = 0;

    while (attempts <= maxRetries) {
      try {
        return await apiCall();
      } catch (e) {
        attempts++;
        if (attempts > maxRetries) {
          rethrow;
        }
        await Future.delayed(delay * attempts);
      }
    }

    throw Exception('Maybe fetch failed after $maxRetries attempts');
  }

  // Force fetch (same as maybe fetch but with different semantics)
  Future<T> forceFetch<T>(
    Future<T> Function() apiCall, {
    int maxRetries = 0,
    Duration delay = const Duration(seconds: 1),
  }) async {
    return maybeFetch(apiCall, maxRetries: maxRetries, delay: delay);
  }

  // Background API calls with timeout
  Future<T> getRunBackground<T>(
    String uri, {
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    return _runWithTimeout(() => get<T>(uri), timeout: timeout);
  }

  Future<T> postRunBackground<T>(
    String uri, {
    required dynamic data,
    String? errorContext,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    return _runWithTimeout(() => post<T>(uri, data: data), timeout: timeout);
  }

  Future<T> _runWithTimeout<T>(
    Future<T> Function() apiCall, {
    required Duration timeout,
  }) async {
    final completer = Completer<T>();

    Timer(timeout, () {
      if (!completer.isCompleted) {
        completer.completeError(Exception('Request timeout'));
      }
    });

    try {
      final result = await apiCall();
      if (!completer.isCompleted) {
        completer.complete(result);
      }
      return result;
    } catch (e) {
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
      rethrow;
    }
  }

  // Response handling methods
  List<T> handleListResponse<T>(
    dynamic response,
    T Function(dynamic) fromJson,
  ) {
    if (response is List) {
      return response.map((item) => fromJson(item)).toList();
    } else if (response is Map && response.containsKey('data')) {
      final listData = response['data'] as List;
      return listData.map((item) => fromJson(item)).toList();
    } else {
      throw Exception('Invalid response format for list');
    }
  }

  MockFailure handleError(Exception error) {
    return MockFailure(error.toString());
  }

  // Header management
  void addHeader(String key, String value) {
    _headers[key] = value;
  }

  void removeHeader(String key) {
    _headers.remove(key);
  }

  Map<String, String> get headers => Map.from(_headers);
}

// Mock failure class
class MockFailure {
  final String message;

  MockFailure(this.message);
}
