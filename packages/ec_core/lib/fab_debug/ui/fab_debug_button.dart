import 'package:ec_core/debug_tools/ui/debug_tools_picker.dart';
import 'package:ec_core/mocked_backend/core/mock_api_service.dart';
import 'package:ec_core/mocked_backend/core/mock_scenario.dart';
import 'package:ec_core/mocked_backend/ui/mock_api_picker_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FabDebugButton<T> extends StatelessWidget {
  const FabDebugButton({
    super.key,
    required this.onSelectedMockBackend,
    this.debugToolsScenarios = const [],
  });

  final ValueChanged<MockScenario<T>> onSelectedMockBackend;
  final List<DebugToolsItem> debugToolsScenarios;

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) return const SizedBox.shrink();

    return FloatingActionButton(
      heroTag: const ValueKey('mock_scenario_fab'),
      onPressed: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder:
                (_) => FabDebugPage(
                  onDebugTools:
                      debugToolsScenarios.isEmpty
                          ? null
                          : () async {
                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                fullscreenDialog: false,
                                builder:
                                    (_) => DebugToolsPickerPage<String>(
                                      title: 'Debug Scenarios',
                                      items: debugToolsScenarios,
                                    ),
                                settings: const RouteSettings(
                                  name: 'debug_scenarios',
                                ),
                              ),
                            );

                            if (result != null && context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                  onMockedBackend: () async {
                    final result = await Navigator.of(
                      context,
                    ).push<MockScenario<T>>(
                      MaterialPageRoute(
                        fullscreenDialog: false,
                        builder:
                            (_) => MockApiPickerPage<dynamic>(
                              title: 'Mocked Backend',
                              apis: MockApiService.apis,
                            ),
                        settings: const RouteSettings(name: 'mock_api_picker'),
                      ),
                    );

                    // Pop back to FabDebugPage after scenario selection
                    if (result != null && context.mounted) {
                      onSelectedMockBackend(result);
                      Navigator.of(context).pop();
                    }
                  },
                ),
            settings: const RouteSettings(name: 'fab_debug_page'),
          ),
        );
      },
      child: const Icon(Icons.bug_report),
    );
  }
}

class FabDebugPage extends StatelessWidget {
  const FabDebugPage({
    super.key,
    required this.onMockedBackend,
    this.onDebugTools,
  });

  final VoidCallback onMockedBackend;
  final VoidCallback? onDebugTools;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Fab Debug'),
      ),
      body: Column(
        children: [
          if (onDebugTools != null)
            ListTile(
              title: const Text('Debug tools'),
              onTap: onDebugTools,
              trailing: const Icon(Icons.chevron_right),
            ),
          const Divider(height: 0),
          ListTile(
            title: const Text('Mocked Backend'),
            onTap: onMockedBackend,
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
