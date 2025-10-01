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
    this.onFeatureFlags,
    this.onApiClientExample,
    this.onDatabaseInspector,
    this.onDebugOverlay,
    this.enableMockBackend = true,
  });

  final ValueChanged<MockScenario<T>> onSelectedMockBackend;
  final List<DebugToolsItem> debugToolsScenarios;
  final VoidCallback? onFeatureFlags;
  final VoidCallback? onApiClientExample;
  final VoidCallback? onDatabaseInspector;
  final VoidCallback? onDebugOverlay;
  final bool enableMockBackend;

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
                  onFeatureFlags: onFeatureFlags,
                  onApiClientExample: onApiClientExample,
                  onDatabaseInspector: onDatabaseInspector,
                  onDebugOverlay: onDebugOverlay,
                  enableMockBackend: enableMockBackend,
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
      child: const Icon(Icons.accessibility),
    );
  }
}

class FabDebugPage extends StatelessWidget {
  const FabDebugPage({
    super.key,
    required this.onMockedBackend,
    this.onDebugTools,
    this.onFeatureFlags,
    this.onApiClientExample,
    this.onDatabaseInspector,
    this.onDebugOverlay,
    this.enableMockBackend = true,
  });

  final VoidCallback onMockedBackend;
  final VoidCallback? onDebugTools;
  final VoidCallback? onFeatureFlags;
  final VoidCallback? onApiClientExample;
  final VoidCallback? onDatabaseInspector;
  final VoidCallback? onDebugOverlay;
  final bool enableMockBackend;

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
          if (onDebugTools != null) const Divider(height: 0),
          if (onFeatureFlags != null)
            ListTile(
              title: const Text('Feature Flags'),
              onTap: onFeatureFlags,
              trailing: const Icon(Icons.chevron_right),
            ),
          if (onFeatureFlags != null) const Divider(height: 0),
          if (onApiClientExample != null)
            ListTile(
              title: const Text('API Client Example'),
              onTap: onApiClientExample,
              trailing: const Icon(Icons.chevron_right),
            ),
          if (onApiClientExample != null) const Divider(height: 0),
          if (onDatabaseInspector != null)
            ListTile(
              title: const Text('Database Inspector'),
              onTap: onDatabaseInspector,
              trailing: const Icon(Icons.chevron_right),
            ),
          if (onDatabaseInspector != null) const Divider(height: 0),
          if (onDebugOverlay != null)
            ListTile(
              title: const Text('Debug Overlay'),
              onTap: onDebugOverlay,
              trailing: const Icon(Icons.chevron_right),
            ),
          if (onDebugOverlay != null) const Divider(height: 0),
          if (enableMockBackend)
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
