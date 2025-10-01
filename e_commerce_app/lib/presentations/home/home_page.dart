import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/presentations/pages/api_client_example.dart';
import 'package:e_commerce_app/presentations/pages/database_inspector_page.dart';
import 'package:e_commerce_app/presentations/pages/debug_overlay_page.dart';
import 'package:e_commerce_app/presentations/pages/feature_flag_debug_panel.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final featureFlagService = getFeatureFlagService();
    final flags = featureFlagService.flags;

    return Scaffold(
      appBar: EcAppBar(title: EcHeadlineSmallText('Home')),
      body: Center(
        child: EcElevatedButton(
          text: 'Go product details page',
          onPressed: () {
            context.pushNamed(AppPaths.productDetails.name);
          },
        ),
      ),
      floatingActionButton: FabDebugButton(
        onSelectedMockBackend: (scenario) {
          // Handle mock backend scenario selection if needed
        },
        onFeatureFlags: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FeatureFlagDebugPanel(),
            ),
          );
          // Rebuild the page after returning from feature flags
          if (mounted) setState(() {});
        },
        onApiClientExample: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ApiClientExample()),
          );
        },
        // Only enable Database Inspector if feature flag is on
        onDatabaseInspector:
            flags.enableDatabaseInspector == true
                ? () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DatabaseInspectorPage(),
                    ),
                  );
                }
                : null,
        // Only enable Debug Overlay if feature flag is on
        onDebugOverlay:
            flags.enableDebugOverlay == true
                ? () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DebugOverlayPage(),
                    ),
                  );
                }
                : null,
        enableMockBackend: false, // Disable Mock Backend option
      ),
    );
  }
}
