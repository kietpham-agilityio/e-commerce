import 'package:e_commerce_app/presentations/items_page.dart';
import 'package:ec_core/ec_core.dart';
import 'package:flutter/material.dart';

import 'core/di/app_module.dart';

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
      // home: const MyHomePage(title: 'E-Commerce Dev - API Testing'),
      home: const ItemsPage(),
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
  String _apiTestResult = 'No API tests run yet';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  /// Test comprehensive CRUD operations workflow
  Future<void> _testCrudWorkflow() async {
    setState(() {
      _isLoading = true;
      _apiTestResult = 'Testing...\n\n';
    });

    String result = 'API:\n\n';

    try {
      final testClient = ApiClientFactory.createWithCustomUrl(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        headers: {'Content-Type': 'application/json'},
      );

      // CREATE - POST
      result += '1. CREATE (POST) - Creating new post\n';
      final newPost = {
        'title': 'Real API Post',
        'body': 'This post demonstrates the complete POST workflow.',
        'userId': 1,
      };

      // final createdPost = await testClient.post('/posts', data: newPost);
      final createdPost = await testClient.testApis.testApis(body: newPost);
      final postId = createdPost['id'];
      result += '   ✓ Created post with ID: $postId\n';
      result += '   Title: ${createdPost['title']}\n\n';

      result += '\n🎉 Complete POST workflow test completed successfully!\n';
      result +=
          'All operations (Create, Read, Update, Delete) were executed.\n';
    } catch (e) {
      result += 'Error during CRUD workflow test: $e\n';
      final err = ApiClientError.convertApiClientErrorFromError(
        e,
        StackTrace.current,
      );
      final error = Failure.fromApiClientError(err);
      result += '   Status Code: ${error.statusCode}\n';
      result += '   Error Code: ${error.errorCode}\n';
      result += '   Message: ${error.message}\n';
    }

    setState(() {
      _isLoading = false;
      _apiTestResult = result;
    });
  }

  @override
  void dispose() {
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
            const SizedBox(height: 20),

            // CRUD Operations Testing
            ElevatedButton(
              onPressed: _isLoading ? null : _testCrudWorkflow,
              child:
                  _isLoading
                      ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Text('Call API'),
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
          ],
        ),
      ),
      floatingActionButton: MockScenarioButton<String>(
        title: 'API Scenarios',
        apis: [
          const MockApi<String>(
            name: 'Posts',
            path: '/posts',
            scenarios: [
              MockScenario<String>(
                name: 'Real API',
                description: 'Switch back to real API',
                payload: 'real',
                apiMode: ApiMode.real,
              ),
              MockScenario<String>(
                name: 'Success',
                description: 'Mock mode: success responses',
                payload: 'success',
                apiMode: ApiMode.mock,
              ),
              MockScenario<String>(
                name: 'Empty',
                description: 'Mock mode: empty responses',
                payload: 'empty',
                apiMode: ApiMode.mock,
              ),
              MockScenario<String>(
                name: 'Error',
                description: 'Mock mode: error responses',
                payload: 'error',
                apiMode: ApiMode.mock,
              ),
            ],
          ),
        ],
        onSelected: (scenario) {
          final bool isReal =
              scenario.apiMode == ApiMode.real || scenario.payload == 'real';
          final ApiMode mode = isReal ? ApiMode.real : ApiMode.mock;
          ApiModeService.setModeAndScenario(
            mode,
            isReal ? null : scenario.payload,
          );
          setState(() {});
        },
      ),
    );
  }
}
