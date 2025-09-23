import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/themes/themes.dart';

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
    LoggerDI.info('✅ $message');
  }

  /// Log warning message
  static void warning(String message) {
    LoggerDI.warning(message);
  }
}

/// Example page demonstrating API client concepts with mock implementations
class ApiClientExample extends StatefulWidget {
  const ApiClientExample({super.key});

  @override
  State<ApiClientExample> createState() => _ApiClientExampleState();
}

class _ApiClientExampleState extends State<ApiClientExample> {
  bool _isLoading = false;

  // Real API client from ec_core package
  late ApiClient _apiClient;

  @override
  void initState() {
    super.initState();

    // Get the real ApiClient from DI
    try {
      _apiClient = DI.get<ApiClient>();
      ApiClientLogger.info(
        '✅ Real ApiClient loaded successfully with Talker integration',
      );
    } catch (e) {
      ApiClientLogger.error('❌ Failed to load ApiClient: $e');
      ApiClientLogger.warning(
        '⚠️ ApiClient not available - API calls will fail',
      );
      // We'll handle this in the API call methods
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  /// Check if API client is available and handle error if not
  bool _checkApiClientAvailable() {
    try {
      // Try to access the API client to see if it's properly initialized
      _apiClient.baseUrl;
      return true;
    } catch (e) {
      ApiClientLogger.error('❌ ApiClient not available: $e');
      return false;
    }
  }

  // ============================================================================
  // BASIC HTTP METHODS EXAMPLES
  // ============================================================================

  Future<void> _testGetRequest() async {
    _setLoading(true);
    ApiClientLogger.info('Starting GET request to /posts/1');

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot perform GET request - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      final response = await _apiClient.get<Map<String, dynamic>>('/posts/1');
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

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot perform POST request - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      final postData = {
        'title': 'API Client Example Post',
        'body': 'This is a test post created by the API client example',
        'userId': 1,
      };

      final response = await _apiClient.post<Map<String, dynamic>>(
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

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot perform PUT request - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      final putData = {
        'id': 1,
        'title': 'Updated Post Title',
        'body': 'This post has been updated via PUT request',
        'userId': 1,
      };

      final response = await _apiClient.put<Map<String, dynamic>>(
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

      final response = await _apiClient.patch<Map<String, dynamic>>(
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
      await _apiClient.delete('/posts/1');
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

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot perform Maybe Fetch - ApiClient not available',
      );
      _setLoading(false);
      return;
    }

    try {
      final result = await _apiClient.maybeFetch<Map<String, dynamic>>(
        () => _apiClient.get<Map<String, dynamic>>('/posts/2'),
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
      final result = await _apiClient.maybeFetch<Map<String, dynamic>>(
        () => _apiClient.get<Map<String, dynamic>>('/nonexistent-endpoint'),
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
      final result = await _apiClient.forceFetch<Map<String, dynamic>>(
        () => _apiClient.get<Map<String, dynamic>>('/posts/3'),
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

    if (!_checkApiClientAvailable()) {
      ApiClientLogger.error(
        '❌ Cannot perform Background GET - ApiClient not available',
      );
      return;
    }

    try {
      final result = await _apiClient.getRunBackground<Map<String, dynamic>>(
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

      final result = await _apiClient.postRunBackground<Map<String, dynamic>>(
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
      final response = await _apiClient.get<List<dynamic>>('/posts?_limit=5');
      final posts = _apiClient.handleListResponse<Map<String, dynamic>>(
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
    ApiClientLogger.info('Starting comprehensive error handling test');

    try {
      // This should fail with 404
      await _apiClient.get('/posts/99999');
      ApiClientLogger.warning('Error Handling: Unexpected success');
    } catch (e) {
      if (e is Failure) {
        // Demonstrate Failure class capabilities
        _logFailureDetails(e);
      } else if (e is Exception) {
        // Convert Exception to Failure and demonstrate capabilities
        final handledError = _apiClient.handleError(e);
        _logFailureDetails(handledError);
      } else {
        // For any other error type, wrap it as Exception
        final handledError = _apiClient.handleError(Exception(e.toString()));
        _logFailureDetails(handledError);
      }
    } finally {
      _setLoading(false);
    }
  }

  /// Log detailed information about a Failure object
  void _logFailureDetails(Failure failure) {
    ApiClientLogger.success('✅ Error Handling Success!');
    ApiClientLogger.info('📋 Failure Details:');
    ApiClientLogger.info('   Message: ${failure.message}');
    ApiClientLogger.info('   Status Code: ${failure.statusCode}');
    ApiClientLogger.info('   Error Code: ${failure.errorCode}');
    ApiClientLogger.info(
      '   Detailed Description: ${failure.detailedDescription}',
    );

    // Demonstrate error type checking
    if (failure.isAuthError) {
      ApiClientLogger.warning('🔒 Authentication Error Detected');
    } else if (failure.isNetworkError) {
      ApiClientLogger.warning('🌐 Network Error Detected');
    } else if (failure.isClientError) {
      ApiClientLogger.warning('📱 Client Error (4xx) Detected');
    } else if (failure.isServerError) {
      ApiClientLogger.warning('🖥️ Server Error (5xx) Detected');
    }

    // Log ApiClientError details if available
    if (failure.apiClientError != null) {
      _logApiClientErrorDetails(failure.apiClientError!);
    }

    // Log internal error code details if available
    if (failure.internalErrorCode != null) {
      _logInternalErrorCodeDetails(failure.internalErrorCode!);
    }
  }

  /// Log detailed information about an ApiClientError
  void _logApiClientErrorDetails(ApiClientError error) {
    ApiClientLogger.info('🔍 ApiClientError Details:');
    ApiClientLogger.info('   Type: ${error.runtimeType}');
    ApiClientLogger.info('   Original Error: ${error.originalError}');

    if (error.developerResponseError != null) {
      final devError = error.developerResponseError!;
      ApiClientLogger.info('   Developer Response:');
      ApiClientLogger.info('     Message: ${devError.message}');
      ApiClientLogger.info('     Code: ${devError.code}');
    }

    // Demonstrate ApiClientError pattern matching
    error.when(
      userNotFound: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('👤 User not found error');
      },
      requestCancelled: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('❌ Request was cancelled');
      },
      unauthorizedRequest: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🚫 Unauthorized request');
      },
      forbiddenRequest: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔒 Forbidden request');
      },
      badRequest: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('📝 Bad request');
      },
      notFound: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔍 Resource not found (404)');
      },
      methodNotAllowed: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🚫 Method not allowed');
      },
      notAcceptable: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('❌ Not acceptable');
      },
      requestTimeout: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('⏰ Request timeout');
      },
      sendTimeout: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('⏰ Send timeout');
      },
      conflict: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('⚔️ Conflict error');
      },
      internalServerError: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🖥️ Internal server error');
      },
      notImplemented: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🚧 Not implemented');
      },
      serviceUnavailable: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔧 Service unavailable');
      },
      noInternetConnection: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🌐 No internet connection');
      },
      formatException: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('📄 Format exception');
      },
      unableToProcess: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('⚙️ Unable to process');
      },
      defaultError: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('❓ Default error');
      },
      unexpectedError: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('💥 Unexpected error');
      },
      badResponseMapping: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🗺️ Bad response mapping');
      },
      pdfUnableGenerate: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('📄 PDF unable to generate');
      },
      authGeneral: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔐 General auth error');
      },
      authNonActiveUserError: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('👤 Non-active user error');
      },
      authDoNotHavePermissions: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔒 No permissions error');
      },
      authFailed: (originalError, devError, stackTrace) {
        ApiClientLogger.warning('🔐 Auth failed');
      },
    );
  }

  /// Log detailed information about an ApiInternalErrorCode
  void _logInternalErrorCodeDetails(ApiInternalErrorCode errorCode) {
    ApiClientLogger.info('🏷️ Internal Error Code Details:');
    ApiClientLogger.info('   Code: ${errorCode.code}');
    ApiClientLogger.info('   Status Code: ${errorCode.statusCode}');
    ApiClientLogger.info('   Description: ${errorCode.description}');
  }

  /// Test creating custom Failure objects
  Future<void> _testCustomFailures() async {
    _setLoading(true);
    ApiClientLogger.info('Starting custom failure creation test');

    try {
      // Test 1: Create Failure from HTTP status code
      final statusCodeFailure = Failure.fromStatusCode(
        404,
        customMessage: 'Custom 404 message',
      );
      ApiClientLogger.info('✅ Created Failure from status code:');
      _logFailureDetails(statusCodeFailure);

      // Test 2: Create Failure from Supabase error
      final supabaseError = {
        'code': 'InvalidJWT',
        'message': 'The provided JWT is invalid',
      };
      final supabaseFailure = Failure.fromSupabaseError(supabaseError);
      ApiClientLogger.info('✅ Created Failure from Supabase error:');
      _logFailureDetails(supabaseFailure);

      // Test 3: Create Failure from exception
      final exceptionFailure = Failure.fromException(
        Exception('Custom exception message'),
      );
      ApiClientLogger.info('✅ Created Failure from exception:');
      _logFailureDetails(exceptionFailure);

      // Test 4: Create custom Failure with specific internal error code
      final customFailure = Failure(
        'Custom business logic error',
        internalErrorCode: ApiInternalErrorCode.accessDenied(),
      );
      ApiClientLogger.info('✅ Created custom Failure:');
      _logFailureDetails(customFailure);
    } catch (e) {
      ApiClientLogger.error('❌ Error in custom failure test: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Test different error scenarios
  Future<void> _testVariousErrorScenarios() async {
    _setLoading(true);
    ApiClientLogger.info('Starting various error scenarios test');

    // Test different endpoints that will fail
    final testScenarios = [
      {'url': '/nonexistent', 'description': '404 Not Found'},
      {'url': '/unauthorized', 'description': '401 Unauthorized'},
      {'url': '/forbidden', 'description': '403 Forbidden'},
      {'url': '/server-error', 'description': '500 Server Error'},
    ];

    for (final scenario in testScenarios) {
      try {
        ApiClientLogger.info('Testing: ${scenario['description']}');
        await _apiClient.get(scenario['url']!);
        ApiClientLogger.warning('Unexpected success for ${scenario['url']}');
      } catch (e) {
        if (e is Failure) {
          ApiClientLogger.info('Expected failure for ${scenario['url']}:');
          _logFailureDetails(e);
        }
      }
    }

    _setLoading(false);
  }

  /// Test ApiClientError creation and handling
  Future<void> _testApiClientErrorHandling() async {
    _setLoading(true);
    ApiClientLogger.info('Starting ApiClientError handling test');

    try {
      // Simulate different types of errors
      final testErrors = [
        ApiClientError.notFound('Resource not found', null),
        ApiClientError.unauthorizedRequest('Unauthorized', null),
        ApiClientError.internalServerError('Server error', null),
        ApiClientError.noInternetConnection('No connection', null),
        ApiClientError.authFailed('Auth failed', null),
      ];

      for (final error in testErrors) {
        ApiClientLogger.info('Testing ApiClientError: ${error.runtimeType}');

        // Convert ApiClientError to Failure
        final failure = Failure.fromApiClientError(error);
        _logFailureDetails(failure);

        ApiClientLogger.info('---');
      }
    } catch (e) {
      ApiClientLogger.error('❌ Error in ApiClientError test: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Real-world example: User authentication with comprehensive error handling
  Future<void> _testUserAuthenticationExample() async {
    _setLoading(true);
    ApiClientLogger.info('Starting user authentication example');

    try {
      // Simulate user login attempt
      await _authenticateUser('test@example.com', 'password123');
    } catch (e) {
      if (e is Failure) {
        await _handleAuthenticationFailure(e);
      } else {
        ApiClientLogger.error('Unexpected error type: $e');
      }
    } finally {
      _setLoading(false);
    }
  }

  /// Simulate user authentication
  Future<void> _authenticateUser(String email, String password) async {
    try {
      // This would typically be a real API call
      await _apiClient.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      ApiClientLogger.success('✅ Authentication successful!');
    } catch (e) {
      // Re-throw as Failure for consistent handling
      if (e is Failure) {
        rethrow;
      } else if (e is Exception) {
        throw _apiClient.handleError(e);
      } else {
        throw Failure(
          'Authentication failed: ${e.toString()}',
          internalErrorCode: ApiInternalErrorCode.unsupported(),
        );
      }
    }
  }

  /// Handle authentication failure with user-friendly messages
  Future<void> _handleAuthenticationFailure(Failure failure) async {
    ApiClientLogger.error('❌ Authentication failed');

    // Handle different types of authentication errors
    if (failure.isAuthError) {
      await _showAuthErrorDialog(failure);
    } else if (failure.isNetworkError) {
      await _showNetworkErrorDialog(failure);
    } else if (failure.isClientError) {
      await _showClientErrorDialog(failure);
    } else {
      await _showGenericErrorDialog(failure);
    }

    // Log detailed error information for debugging
    _logFailureDetails(failure);
  }

  /// Show authentication-specific error dialog
  Future<void> _showAuthErrorDialog(Failure failure) async {
    String userMessage = 'Authentication failed. Please try again.';
    String action = 'Retry';

    failure.internalErrorCode?.maybeWhen(
      invalidJWT: () {
        userMessage = 'Your session has expired. Please log in again.';
        action = 'Redirect to login';
      },
      accessDenied: () {
        userMessage =
            'Access denied. You don\'t have permission to perform this action.';
        action = 'Contact administrator';
      },
      authFailed: () {
        userMessage =
            'Invalid email or password. Please check your credentials.';
        action = 'Try again';
      },
      authNonActiveUserError: () {
        userMessage = 'Your account is not active. Please contact support.';
        action = 'Contact support';
      },
      orElse: () {
        userMessage = 'Authentication failed. Please try again.';
        action = 'Retry';
      },
    );

    ApiClientLogger.warning('🔒 Auth Error Dialog:');
    ApiClientLogger.warning('   Message: $userMessage');
    ApiClientLogger.warning('   Action: $action');
  }

  /// Show network error dialog
  Future<void> _showNetworkErrorDialog(Failure failure) async {
    ApiClientLogger.warning('🌐 Network Error Dialog:');
    ApiClientLogger.warning(
      '   Message: Please check your internet connection and try again.',
    );
    ApiClientLogger.warning('   Action: Retry when connection is restored');
  }

  /// Show client error dialog
  Future<void> _showClientErrorDialog(Failure failure) async {
    ApiClientLogger.warning('📱 Client Error Dialog:');
    ApiClientLogger.warning(
      '   Message: There was an issue with your request. Please try again.',
    );
    ApiClientLogger.warning(
      '   Action: Retry or contact support if issue persists',
    );
  }

  /// Show generic error dialog
  Future<void> _showGenericErrorDialog(Failure failure) async {
    ApiClientLogger.warning('❓ Generic Error Dialog:');
    ApiClientLogger.warning(
      '   Message: Something went wrong. Please try again later.',
    );
    ApiClientLogger.warning('   Action: Retry or contact support');
  }

  // ============================================================================
  // HEADER MANAGEMENT EXAMPLES
  // ============================================================================

  Future<void> _testHeaderManagement() async {
    _setLoading(true);
    ApiClientLogger.info('Testing header management');

    try {
      // Add custom headers
      _apiClient.addHeader('X-Custom-Header', 'Example-Value');
      _apiClient.addHeader(
        'X-Request-ID',
        '${DateTime.now().millisecondsSinceEpoch}',
      );

      // Make a request with custom headers
      final response = await _apiClient.get<Map<String, dynamic>>('/posts/5');
      ApiClientLogger.success('Header Test Success: ${response['title']}');

      // Remove custom headers
      _apiClient.removeHeader('X-Custom-Header');
      _apiClient.removeHeader('X-Request-ID');
      ApiClientLogger.info('Headers removed successfully');
    } catch (e) {
      ApiClientLogger.error('Header Test Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _showTalkerLogs() {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => Scaffold(
                appBar: EcAppBar(
                  title: const EcTitleMediumText('Talker Logs'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                body: const EcTalkerScreen(),
              ),
        ),
      );
    } catch (e) {
      ApiClientLogger.error('Failed to show Talker logs: $e');

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(
        title: const EcTitleMediumText('API Client Examples'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
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
                              'Real API Client Demo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This example demonstrates API client concepts using the real ApiClient from ec_core package. '
                          'All API calls are now logged through the Talker system configured in your project.',
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
                        ('Custom Failures', _testCustomFailures),
                        ('Various Scenarios', _testVariousErrorScenarios),
                        ('ApiClientError Test', _testApiClientErrorHandling),
                        ('Auth Example', _testUserAuthenticationExample),
                        ('Header Management', _testHeaderManagement),
                      ]),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Talker Logs Button
                  Center(
                    child: EcElevatedButton(
                      text: 'Open Talker Logs',
                      onPressed: _showTalkerLogs,
                    ),
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
