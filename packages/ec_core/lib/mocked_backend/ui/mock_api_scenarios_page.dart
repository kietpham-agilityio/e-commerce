import 'package:flutter/material.dart';

import '../core/mock_api.dart';
import '../core/mock_scenario.dart';

class MockApiScenariosPage<T> extends StatelessWidget {
  const MockApiScenariosPage({super.key, required this.api});

  final MockApi<T> api;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(api.name),
      ),
      body: _ScenarioList<T>(scenarios: api.scenarios),
    );
  }
}

class _ScenarioList<T> extends StatelessWidget {
  const _ScenarioList({required this.scenarios});

  final List<MockScenario<T>> scenarios;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: scenarios.length,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final item = scenarios[index];

        return ListTile(
          title: Text(item.name),
          subtitle: item.description == null ? null : Text(item.description!),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pop(item),
        );
      },
    );
  }
}
