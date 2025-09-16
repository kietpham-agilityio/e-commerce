import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// FloatingActionButton that opens scenario selector and mocked backend controls.
class EcDebugFab extends StatelessWidget {
  const EcDebugFab({super.key, this.title = 'Debug Tools'});

  final String title;

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) return const SizedBox.shrink();

    return FloatingActionButton.extended(
      heroTag: const ValueKey('ec_debug_fab'),
      icon: const Icon(Icons.bug_report_outlined),
      label: const Text('Debug'),
      onPressed: () async {
        // await showDialog<void>(
        //   context: context,
        //   builder: (context) => DebugScenarioDialog(title: title),
        // );
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     fullscreenDialog: true,
        //     builder: (_) => MockApiPickerPage<T>(title: title, apis: apisToUse),
        //     settings: const RouteSettings(name: 'mock_api_picker'),
        //   ),
        // );
      },
    );
  }
}
