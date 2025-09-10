import 'package:e_commerce_app/core/di/api_client_module.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/api_client/core/api_client_factory.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  late Future<dynamic> _future;
  late ApiClient _apiClient;

  final testClient = ApiClientFactory.createWithCustomUrl(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    headers: {'Content-Type': 'application/json'},
  );

  void _initializeApiClient() {
    // Get API client from dependency injection
    _apiClient = ApiClientModule.apiClient;
  }

  @override
  void initState() {
    super.initState();
    _initializeApiClient();
    _future = testClient.testApis.getApis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: FutureBuilder<dynamic>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(height: 12),
                    Text(
                      'Failure: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _future = testClient.testApis.getApis();
                        });
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final items = snapshot.data ?? const [];

          if (items.isEmpty) {
            return const Center(child: Text('Empty'));
          }

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = items[index] as Map<String, dynamic>?;
              final title = item?['title']?.toString() ?? 'Item ${index + 1}';
              final subtitle = item?['body']?.toString();
              return ListTile(
                title: Text(title),
                subtitle: subtitle != null ? Text(subtitle) : null,
                leading: CircleAvatar(child: Text('${index + 1}')),
              );
            },
          );
        },
      ),
    );
  }
}
