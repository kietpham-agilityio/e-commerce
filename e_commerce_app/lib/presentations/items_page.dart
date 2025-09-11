import 'package:ec_core/mocked_backend/mock_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/api_client_module.dart';
import 'items/bloc/items_bloc.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              ItemsBloc(apiClient: ApiClientModule.apiClient)
                ..add(LoadRequested()),
      child: const _ItemsView(),
    );
  }
}

class _ItemsView extends StatelessWidget {
  const _ItemsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed:
                () => context.read<ItemsBloc>().add(const LoadRequested()),
            tooltip: 'Refresh data',
          ),
        ],
      ),
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          if (state.status == ItemsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ItemsStatus.failure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(height: 12),
                    Text(
                      'Error: ${state.errorMessage ?? 'Unknown error'}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed:
                          () => context.read<ItemsBloc>().add(
                            const LoadRequested(),
                          ),
                      child: const Text('Try again!'),
                    ),
                  ],
                ),
              ),
            );
          }

          final items = state.items;

          if (items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No data available'),
                ],
              ),
            );
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
      floatingActionButton: MockScenarioButton<String>(
        title: 'API Scenarios',
        apis: const [
          MockApi<String>(
            name: 'Posts',
            path: '/posts',
            scenarios: [
              MockScenario<String>(
                name: 'Real API',
                description: 'Use real API endpoint',
                payload: 'real',
                apiMode: ApiMode.real,
              ),
              MockScenario<String>(
                name: 'Mock Success',
                description: 'Mock successful response with data',
                payload: 'success',
                apiMode: ApiMode.mock,
              ),
              MockScenario<String>(
                name: 'Mock Empty',
                description: 'Mock empty response',
                payload: 'empty',
                apiMode: ApiMode.mock,
              ),
              MockScenario<String>(
                name: 'Mock Error',
                description: 'Mock error response',
                payload: 'error',
                apiMode: ApiMode.mock,
              ),
            ],
          ),
        ],
        onSelected: (scenario) {
          ApiModeService.setModeAndScenario(scenario.apiMode, scenario.payload);
          context.read<ItemsBloc>().add(const LoadRequested());
        },
      ),
    );
  }
}
