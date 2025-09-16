// import 'package:ec_core/ec_core.dart';
// import 'package:flutter/material.dart';

// /// Dialog showing mocked backend scenarios and current API list.
// class DebugScenarioDialog extends StatelessWidget {
//   const DebugScenarioDialog({super.key, required this.title});

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding: const EdgeInsets.all(16),
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxHeight: 560),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Row(
//                 children: [
//                   const Icon(Icons.bug_report, size: 20),
//                   const SizedBox(width: 8),
//                   Text(title, style: Theme.of(context).textTheme.titleMedium),
//                   const Spacer(),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(height: 1),
//             Expanded(child: _MockedBackendPane()),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _MockedBackendPane extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Mocked backend', style: Theme.of(context).textTheme.titleSmall),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               ElevatedButton.icon(
//                 onPressed: () async {
//                   await Navigator.of(context).push(
//                     MaterialPageRoute(
//                       fullscreenDialog: true,
//                       builder: (_) => const MockApiScenariosPage(api: api),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.fact_check),
//                 label: const Text('Scenarios'),
//               ),
//               const SizedBox(width: 12),
//               ElevatedButton.icon(
//                 onPressed: () async {
//                   await Navigator.of(context).push(
//                     MaterialPageRoute(
//                       fullscreenDialog: true,
//                       builder: (_) => const MockApiListDialog(),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.list_alt),
//                 label: const Text('APIs'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Expanded(child: _HelpfulText()),
//         ],
//       ),
//     );
//   }
// }

// class _HelpfulText extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Text(
//         'Use Scenarios to switch API responses: loading, success, empty, error.\n'
//         'Use APIs to review and navigate available mock endpoints.',
//         style: Theme.of(context).textTheme.bodySmall,
//       ),
//     );
//   }
// }

import 'package:ec_core/mocked_backend/core/mock_api_service.dart';
import 'package:ec_core/mocked_backend/ui/mock_api_list_dialog.dart';
import 'package:ec_core/mocked_backend/ui/mock_api_scenarios_page.dart';
import 'package:flutter/material.dart';

/// Dialog showing mocked backend scenarios and current API list.
class DebugScenarioDialog extends StatelessWidget {
  const DebugScenarioDialog({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.bug_report, size: 20),
                  const SizedBox(width: 8),
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(child: _MockedBackendPane()),
          ],
        ),
      ),
    );
  }
}

class _MockedBackendPane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mocked backend', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  final api = await showDialog(
                    context: context,
                    builder:
                        (_) => MockApiListDialog(
                          title: 'Select API',
                          apis: MockApiService.apis,
                        ),
                  );
                  if (api != null) {
                    // ignore: use_build_context_synchronously
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (_) => MockApiScenariosPage(api: api),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.fact_check),
                label: const Text('Scenarios'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder:
                        (_) => MockApiListDialog(
                          title: 'APIs',
                          apis: MockApiService.apis,
                        ),
                  );
                },
                icon: const Icon(Icons.list_alt),
                label: const Text('APIs'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(child: _HelpfulText()),
        ],
      ),
    );
  }
}

class _HelpfulText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text(
        'Use Scenarios to switch API responses: loading, success, empty, error.\n'
        'Use APIs to review and navigate available mock endpoints.',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
