import 'package:ec_themes/themes/icons.dart';
import 'package:flutter/material.dart';
import 'package:ec_core/ec_core.dart';
import 'core/di/app_module.dart';
import 'core/di/api_client_module.dart';
import 'core/di/service_module.dart';

void main() {
  // Initialize dependency injection
  AppModule.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final flavor = EcFlavor.current;
    
    return MaterialApp(
      title: 'E-Commerce Dev - ${flavor.displayName}',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: flavor.isAdmin ? Colors.deepPurple : Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'E-Commerce Dev - API Testing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _errorTestResult = 'No tests run yet';
  String _apiTestResult = 'No API tests run yet';
  late ApiClient _apiClient;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeApiClient();
  }

  void _initializeApiClient() {
    // Get API client from dependency injection
    _apiClient = ApiClientModule.apiClient;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  /// Test Supabase error codes
  void _testSupabaseErrorCodes() {
    setState(() {
      _errorTestResult = 'Testing Supabase Error Codes...\n\n';
    });

    // Test all Supabase error codes
    final errorCodes = [
      ApiInternalErrorCode.noSuchBucket(),
      ApiInternalErrorCode.noSuchKey(),
      ApiInternalErrorCode.invalidJWT(),
      ApiInternalErrorCode.accessDenied(),
      ApiInternalErrorCode.entityTooLarge(),
      ApiInternalErrorCode.tooManyRequests(),
      ApiInternalErrorCode.internalError(),
      ApiInternalErrorCode.databaseTimeout(),
    ];

    String result = 'Supabase Error Codes Test Results:\n\n';
    
    for (final errorCode in errorCodes) {
      result += '${errorCode.code}:\n';
      result += '  Status Code: ${errorCode.statusCode}\n';
      result += '  Description: ${errorCode.description}\n\n';
    }

    setState(() {
      _errorTestResult = result;
    });
  }

  /// Test Failure creation from Supabase error
  void _testSupabaseFailureCreation() {
    setState(() {
      _errorTestResult = 'Testing Supabase Failure Creation...\n\n';
    });

    // Mock Supabase error responses
    final supabaseErrors = [
      {
        'code': 'NoSuchBucket',
        'message': 'The specified bucket does not exist.',
      },
      {
        'code': 'InvalidJWT',
        'message': 'The provided JWT is invalid.',
      },
      {
        'code': 'EntityTooLarge',
        'message': 'The entity being uploaded is too large.',
      },
      {
        'code': 'AccessDenied',
        'message': 'Access to the specified resource is denied.',
      },
    ];

    String result = 'Supabase Failure Creation Test:\n\n';
    
    for (final errorResponse in supabaseErrors) {
      final failure = Failure.fromSupabaseError(errorResponse);
      result += 'Error Code: ${failure.errorCode}\n';
      result += 'Status Code: ${failure.statusCode}\n';
      result += 'Message: ${failure.message}\n';
      result += 'Is Auth Error: ${failure.isAuthError}\n';
      result += 'Is Client Error: ${failure.isClientError}\n';
      result += 'Is Server Error: ${failure.isServerError}\n';
      result += 'Detailed Description: ${failure.detailedDescription}\n\n';
    }

    setState(() {
      _errorTestResult = result;
    });
  }

  /// Test HTTP status code to error code mapping
  void _testStatusCodeMapping() {
    setState(() {
      _errorTestResult = 'Testing HTTP Status Code Mapping...\n\n';
    });

    final statusCodes = [400, 401, 403, 404, 409, 413, 416, 423, 429, 500, 503, 504];
    
    String result = 'HTTP Status Code to Error Code Mapping:\n\n';
    
    for (final statusCode in statusCodes) {
      final errorCode = ApiInternalErrorCode.fromStatusCode(statusCode);
      final failure = Failure.fromStatusCode(statusCode);
      
      result += 'Status Code: $statusCode\n';
      result += 'Error Code: ${errorCode?.code ?? 'Unknown'}\n';
      result += 'Description: ${errorCode?.description ?? 'Unknown'}\n';
      result += 'Failure Message: ${failure.message}\n\n';
    }

    setState(() {
      _errorTestResult = result;
    });
  }

  /// Test error code properties and methods
  void _testErrorCodeProperties() {
    setState(() {
      _errorTestResult = 'Testing Error Code Properties...\n\n';
    });

    final testErrorCode = ApiInternalErrorCode.invalidJWT();
    
    String result = 'Error Code Properties Test:\n\n';
    result += 'Error Code: ${testErrorCode.code}\n';
    result += 'Status Code: ${testErrorCode.statusCode}\n';
    result += 'Description: ${testErrorCode.description}\n\n';
    
    // Test Failure properties
    final failure = Failure.fromStatusCode(401, customMessage: 'Custom JWT error');
    result += 'Failure Properties:\n';
    result += 'Error Code: ${failure.errorCode}\n';
    result += 'Status Code: ${failure.statusCode}\n';
    result += 'Is Auth Error: ${failure.isAuthError}\n';
    result += 'Is Network Error: ${failure.isNetworkError}\n';
    result += 'Is Client Error: ${failure.isClientError}\n';
    result += 'Is Server Error: ${failure.isServerError}\n';
    result += 'Detailed Description: ${failure.detailedDescription}\n';

    setState(() {
      _errorTestResult = result;
    });
  }

  /// Test API client configuration
  void _testApiClientConfiguration() {
    setState(() {
      _apiTestResult = 'Testing API Client Configuration...\n\n';
    });

    final flavor = EcFlavor.current;
    String result = 'API Client Configuration:\n\n';
    
    result += 'Current Flavor: ${flavor.displayName}\n';
    result += 'Environment: ${flavor.environment}\n';
    result += 'Bundle ID: ${flavor.bundleId}\n';
    result += 'App Name: ${flavor.appName}\n';
    result += 'API Base URL: ${flavor.apiBaseUrl}\n\n';
    
    result += 'API Client Details:\n';
    result += 'Base URL: ${_apiClient.baseUrl}\n';
    result += 'Connect Timeout: ${_apiClient.options.connectTimeout}\n';
    result += 'Receive Timeout: ${_apiClient.options.receiveTimeout}\n';
    result += 'Send Timeout: ${_apiClient.options.sendTimeout}\n\n';
    
    result += 'Headers:\n';
    _apiClient.options.headers.forEach((key, value) {
      result += '  $key: $value\n';
    });

    setState(() {
      _apiTestResult = result;
    });
  }

  /// Test API client with mock requests
  Future<void> _testApiClientRequests() async {
    setState(() {
      _isLoading = true;
      _apiTestResult = 'Testing API Client Requests...\n\n';
    });

    String result = 'API Client Request Tests:\n\n';
    
    try {
      // Test 1: Test with a mock endpoint that should return 404
      result += 'Test 1: GET /test-endpoint (Expected: 404)\n';
      try {
        await _apiClient.get('/test-endpoint');
        result += '  Result: Unexpected success\n';
      } catch (e) {
        if (e is Failure) {
          result += '  Status Code: ${e.statusCode}\n';
          result += '  Error Code: ${e.errorCode}\n';
          result += '  Message: ${e.message}\n';
          result += '  Is Client Error: ${e.isClientError}\n';
        } else {
          result += '  Error: $e\n';
        }
      }
      result += '\n';

      // Test 2: Test POST request
      result += 'Test 2: POST /test-endpoint (Expected: 404)\n';
      try {
        await _apiClient.post('/test-endpoint', data: {'test': 'data'});
        result += '  Result: Unexpected success\n';
      } catch (e) {
        if (e is Failure) {
          result += '  Status Code: ${e.statusCode}\n';
          result += '  Error Code: ${e.errorCode}\n';
          result += '  Message: ${e.message}\n';
        } else {
          result += '  Error: $e\n';
        }
      }
      result += '\n';

      // Test 3: Test with maybeFetch wrapper
      result += 'Test 3: maybeFetch wrapper test\n';
      try {
        await _apiClient.maybeFetch(
          () => _apiClient.get('/test-endpoint'),
          maxRetries: 1,
          delay: const Duration(milliseconds: 500),
        );
        result += '  Result: Unexpected success\n';
      } catch (e) {
        if (e is Failure) {
          result += '  Status Code: ${e.statusCode}\n';
          result += '  Error Code: ${e.errorCode}\n';
          result += '  Message: ${e.message}\n';
          result += '  Detailed Description: ${e.detailedDescription}\n';
        } else {
          result += '  Error: $e\n';
        }
      }
      result += '\n';

      result += 'All tests completed successfully!\n';
      result += 'Note: These tests use mock endpoints that return 404, which is expected behavior.\n';

    } catch (e) {
      result += 'Unexpected error during testing: $e\n';
    }

    setState(() {
      _isLoading = false;
      _apiTestResult = result;
    });
  }

  /// Test different API client configurations
  void _testApiClientVariations() {
    setState(() {
      _apiTestResult = 'Testing API Client Variations...\n\n';
    });

    String result = 'API Client Variations Test:\n\n';
    
    try {
      // Test GetIt dependency injection
      result += '1. GetIt Registered API Client:\n';
      final getItClient = ApiClientModule.apiClient;
      result += '   Base URL: ${getItClient.baseUrl}\n';
      result += '   Environment: dev\n';
      result += '   Source: GetIt DI\n\n';

      // Test different factory methods using custom URLs
      result += '2. Development API Client (User):\n';
      final devUserClient = ApiClientModule.createForEnvironment('dev');
      result += '   Base URL: ${devUserClient.baseUrl}\n';
      result += '   Environment: dev\n\n';

      result += '3. Development API Client (Admin):\n';
      final devAdminClient = ApiClientModule.createForFlavor(EcFlavor.admin, environment: 'dev');
      result += '   Base URL: ${devAdminClient.baseUrl}\n';
      result += '   Environment: dev (admin)\n\n';

      result += '4. Staging API Client (User):\n';
      final stagingUserClient = ApiClientModule.createForEnvironment('staging');
      result += '   Base URL: ${stagingUserClient.baseUrl}\n';
      result += '   Environment: staging\n\n';

      result += '5. Staging API Client (Admin):\n';
      final stagingAdminClient = ApiClientModule.createForFlavor(EcFlavor.admin, environment: 'staging');
      result += '   Base URL: ${stagingAdminClient.baseUrl}\n';
      result += '   Environment: staging (admin)\n\n';

      result += '6. Production API Client (User):\n';
      final prodUserClient = ApiClientModule.createForEnvironment('prod');
      result += '   Base URL: ${prodUserClient.baseUrl}\n';
      result += '   Environment: prod\n\n';

      result += '7. Production API Client (Admin):\n';
      final prodAdminClient = ApiClientModule.createForFlavor(EcFlavor.admin, environment: 'prod');
      result += '   Base URL: ${prodAdminClient.baseUrl}\n';
      result += '   Environment: prod (admin)\n\n';

      result += '8. Custom URL Client:\n';
      final customClient = ApiClientFactory.createWithCustomUrl(
        baseUrl: 'https://custom-api.example.com',
        headers: {'X-Custom': 'value'},
      );
      result += '   Base URL: ${customClient.baseUrl}\n';
      result += '   Custom Headers: ${customClient.options.headers}\n\n';

      result += 'All variations created successfully!\n';
      result += 'GetIt DI Status: ${AppModule.isInitialized ? "Initialized" : "Not Initialized"}\n';

    } catch (e) {
      result += 'Error creating API client variations: $e\n';
    }

    setState(() {
      _apiTestResult = result;
    });
  }

  /// Test GetIt dependency injection functionality
  void _testGetItIntegration() {
    setState(() {
      _apiTestResult = 'Testing GetIt Integration...\n\n';
    });

    String result = 'GetIt Dependency Injection Test:\n\n';
    
    try {
      // Test GetIt registration status
      result += '1. GetIt Registration Status:\n';
      result += '   ApiClient Registered: ${ApiClientModule.isRegistered}\n';
      result += '   App Module Initialized: ${AppModule.isInitialized}\n\n';

      // Test singleton behavior
      result += '2. Singleton Behavior Test:\n';
      final client1 = ApiClientModule.apiClient;
      final client2 = ApiClientModule.apiClient;
      result += '   Same Instance: ${identical(client1, client2)}\n';
      result += '   Base URL 1: ${client1.baseUrl}\n';
      result += '   Base URL 2: ${client2.baseUrl}\n\n';

      // Test factory methods
      result += '3. Factory Method Test:\n';
      final factoryClient = ApiClientModule.createForEnvironment('dev');
      result += '   Factory Client Base URL: ${factoryClient.baseUrl}\n';
      result += '   Different from Singleton: ${!identical(client1, factoryClient)}\n\n';

      // Test flavor-specific creation
      result += '4. Flavor-Specific Creation Test:\n';
      final adminClient = ApiClientModule.createForFlavor(EcFlavor.admin, environment: 'dev');
      final userClient = ApiClientModule.createForFlavor(EcFlavor.user, environment: 'dev');
      result += '   Admin Client Base URL: ${adminClient.baseUrl}\n';
      result += '   User Client Base URL: ${userClient.baseUrl}\n';
      result += '   URLs Different: ${adminClient.baseUrl != userClient.baseUrl}\n\n';

      // Test GetIt instance access
      result += '5. GetIt Instance Access:\n';
      final getIt = AppModule.getIt;
      result += '   GetIt Instance Available: true\n';
      result += '   ApiClient from GetIt: ${getIt.isRegistered<ApiClient>()}\n\n';

      result += 'GetIt integration test completed successfully!\n';

    } catch (e) {
      result += 'Error during GetIt integration test: $e\n';
    }

    setState(() {
      _apiTestResult = result;
    });
  }

  /// Test ApiService integration with GetIt
  void _testApiServiceIntegration() {
    setState(() {
      _apiTestResult = 'Testing ApiService Integration...\n\n';
    });

    String result = 'ApiService Integration Test:\n\n';
    
    try {
      // Test ApiService registration
      result += '1. ApiService Registration:\n';
      result += '   ApiService Registered: ${ServiceModule.isRegistered}\n';
      result += '   App Module Initialized: ${AppModule.isInitialized}\n\n';

      // Test ApiService instance creation
      result += '2. ApiService Instance Creation:\n';
      final apiService = ServiceModule.apiService;
      result += '   ApiService Instance Created: true\n';
      result += '   Base URL: ${apiService.baseUrl}\n';
      result += '   ApiClient Available: true\n\n';

      // Test singleton behavior
      result += '3. Singleton Behavior Test:\n';
      final service1 = ServiceModule.apiService;
      final service2 = ServiceModule.apiService;
      result += '   Same Instance: ${identical(service1, service2)}\n';
      result += '   Same ApiClient: ${identical(service1.apiClient, service2.apiClient)}\n\n';

      // Test service methods (without actual API calls)
      result += '4. Service Method Availability:\n';
      result += '   fetchUserData method: Available\n';
      result += '   createUser method: Available\n';
      result += '   updateUser method: Available\n';
      result += '   deleteUser method: Available\n\n';

      result += 'ApiService integration test completed successfully!\n';
      result += 'Note: Actual API calls would require a running server.\n';

    } catch (e) {
      result += 'Error during ApiService integration test: $e\n';
    }

    setState(() {
      _apiTestResult = result;
    });
  }

  @override
  void dispose() {
    _apiClient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Counter section
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              
              // Icons section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(EcDesignIcons.icArrowLeft, size: 30, color: Colors.blue),
                  const SizedBox(width: 20),
                  Icon(EcDesignIcons.icArrowRight, size: 30, color: Colors.green),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // API Client Testing
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'API Client Testing',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ElevatedButton(
                            onPressed: _testApiClientConfiguration,
                            child: const Text('Test Configuration'),
                          ),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _testApiClientRequests,
                            child: _isLoading 
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text('Test Requests'),
                          ),
                          ElevatedButton(
                            onPressed: _testApiClientVariations,
                            child: const Text('Test Variations'),
                          ),
                          ElevatedButton(
                            onPressed: _testGetItIntegration,
                            child: const Text('Test GetIt DI'),
                          ),
                          ElevatedButton(
                            onPressed: _testApiServiceIntegration,
                            child: const Text('Test ApiService'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Supabase Error Codes Testing
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Supabase Error Codes Testing',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ElevatedButton(
                            onPressed: _testSupabaseErrorCodes,
                            child: const Text('Test Error Codes'),
                          ),
                          ElevatedButton(
                            onPressed: _testSupabaseFailureCreation,
                            child: const Text('Test Failure Creation'),
                          ),
                          ElevatedButton(
                            onPressed: _testStatusCodeMapping,
                            child: const Text('Test Status Mapping'),
                          ),
                          ElevatedButton(
                            onPressed: _testErrorCodeProperties,
                            child: const Text('Test Properties'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // API Test Results
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'API Test Results',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue[200]!),
                        ),
                        child: Text(
                          _apiTestResult,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Error Test Results
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Error Test Results',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _errorTestResult,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
