import 'package:e_commerce_app/presentations/pages/feature_flag_debug_panel.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

/// Reusable debug floating action button
/// Shows the feature flag debug panel when tapped
class DebugFab extends StatelessWidget {
  const DebugFab({super.key, this.debugToolsScenarios = const []});

  final List<DebugToolsItem> debugToolsScenarios;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        if (debugToolsScenarios.isEmpty) {
          // Navigate to feature flag debug panel if no scenarios provided
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FeatureFlagDebugPanel(),
            ),
          );
        } else {
          // Show debug tools picker if scenarios are provided
          _showDebugToolsPicker(context);
        }
      },
      icon: const Icon(Icons.bug_report),
      label: const EcLabelMediumText('Debug'),
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
    );
  }

  void _showDebugToolsPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) =>
              DebugToolPicker(title: 'Debug Tools', items: debugToolsScenarios),
    );
  }
}

/// Small debug icon button
/// Can be used in app bars or anywhere else
class DebugIconButton extends StatelessWidget {
  const DebugIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FeatureFlagDebugPanel(),
          ),
        );
      },
      icon: const Icon(Icons.bug_report),
      tooltip: 'Feature Flag Debug Panel',
      color: Theme.of(context).colorScheme.error,
    );
  }
}
