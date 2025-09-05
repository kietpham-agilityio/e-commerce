import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/mock_scenario.dart';
import 'mock_scenario_dialog.dart';

/// Mock-only FloatingActionButton that opens a fullscreen scenario dialog in non-release builds.
class MockScenarioButton<T> extends StatelessWidget {
  const MockScenarioButton({
    super.key,
    required this.title,
    required this.scenarios,
    required this.onSelected,
  });

  final String title;
  final List<MockScenario<T>> scenarios;
  final ValueChanged<MockScenario<T>> onSelected;
  // No persistence. Dialog controls its own selection.

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) return const SizedBox.shrink();

    return FloatingActionButton.extended(
      heroTag: const ValueKey('mock_scenario_fab'),
      onPressed: () async {
        final result = await showDialog<MockScenario<T>>(
          context: context,
          barrierDismissible: true,
          builder:
              (_) => MockScenarioDialog<T>(title: title, scenarios: scenarios),
        );
        if (result != null) onSelected(result);
      },
      icon: const Icon(Icons.bug_report),
      label: const Text('Scenarios'),
    );
  }
}
