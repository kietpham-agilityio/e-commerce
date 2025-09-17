import 'package:flutter/material.dart';

import '../core/api_mode.dart';
import '../core/mock_api.dart';
import '../core/mock_scenario.dart';
import 'mock_api_scenarios_page.dart';

class MockApiPickerPage<T> extends StatelessWidget {
  const MockApiPickerPage({super.key, required this.title, required this.apis});

  final String title;
  final List<MockApi<T>> apis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Material(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: ListView.separated(
          itemCount: apis.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) {
            final api = apis[index];

            return ListTile(
              title: Text(api.name),
              subtitle: Text(api.path),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final scenario = await Navigator.of(
                  context,
                ).push<MockScenario<T>>(
                  MaterialPageRoute(
                    builder: (_) => MockApiScenariosPage<T>(api: api),
                    fullscreenDialog: false,
                    settings: const RouteSettings(name: 'mock_api_scenarios'),
                  ),
                );

                if (scenario != null && context.mounted) {
                  // Set scenario for the specific API path
                  ApiModeService.setScenarioForApi(
                    api.path,
                    scenario.apiMode,
                    scenario.payload?.toString(),
                  );
                  Navigator.of(context).pop<MockScenario<T>>(scenario);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
