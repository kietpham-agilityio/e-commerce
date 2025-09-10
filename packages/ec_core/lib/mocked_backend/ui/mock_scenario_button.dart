import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/api_mode.dart';
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
        // Determine current index to preselect
        final currentScenarioType = ApiModeService.currentScenarioType;
        final currentMode = ApiModeService.currentMode;
        final int initialIndex = _computeInitialIndex(
          scenarios,
          currentMode,
          currentScenarioType,
        );

        final result = await showDialog<MockScenario<T>>(
          context: context,
          barrierDismissible: true,
          builder:
              (_) => MockScenarioDialog<T>(
                title: title,
                scenarios: scenarios,
                initialSelectedIndex: initialIndex,
              ),
        );
        if (result != null) onSelected(result);
      },
      icon: const Icon(Icons.bug_report),
      label: const Text('Scenarios'),
    );
  }

  int _computeInitialIndex(
    List<MockScenario<T>> items,
    ApiMode mode,
    String? scenarioType,
  ) {
    // Try exact match by apiMode + payload string (if payload is String)
    if (scenarioType != null) {
      final idx = items.indexWhere(
        (s) =>
            s.apiMode == mode &&
            (s.payload is String ? s.payload == scenarioType : false),
      );
      if (idx != -1) return idx;
    }

    // Otherwise, pick the first item that matches the mode
    final modeIdx = items.indexWhere((s) => s.apiMode == mode);
    if (modeIdx != -1) return modeIdx;

    // Default to 0
    return 0;
  }
}
