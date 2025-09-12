import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/mock_api.dart';
import '../core/mock_api_service.dart';
import '../core/mock_scenario.dart';
import 'mock_api_picker_page.dart';

/// Mock-only FloatingActionButton that opens a fullscreen scenario dialog in non-release builds.
class MockScenarioButton<T> extends StatelessWidget {
  const MockScenarioButton({
    super.key,
    required this.title,
    this.apis,
    required this.onSelected,
  });

  final String title;
  final List<MockApi<T>>? apis;
  final ValueChanged<MockScenario<T>> onSelected;

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) return const SizedBox.shrink();

    return FloatingActionButton.extended(
      heroTag: const ValueKey('mock_scenario_fab'),
      onPressed: () async {
        final apisToUse = apis ?? MockApiService.apis.cast<MockApi<T>>();
        final scenario = await Navigator.of(context).push<MockScenario<T>>(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => MockApiPickerPage<T>(title: title, apis: apisToUse),
            settings: const RouteSettings(name: 'mock_api_picker'),
          ),
        );

        if (scenario != null) onSelected(scenario);
      },
      icon: const Icon(Icons.bug_report),
      label: const Text('Scenarios'),
    );
  }

  // Selection computation is currently unused in the two-step flow.
}
