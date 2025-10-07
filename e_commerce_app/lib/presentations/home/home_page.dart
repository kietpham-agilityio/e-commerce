import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/bloc/app_state.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/presentations/pages/api_client_example.dart';
import 'package:e_commerce_app/presentations/pages/database_inspector_page.dart';
import 'package:e_commerce_app/presentations/pages/debug_overlay_page.dart';
import 'package:e_commerce_app/presentations/pages/example_pages_navigation.dart';
import 'package:e_commerce_app/presentations/pages/feature_flag_debug_panel.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (previous, current) {
        // Listen when Database Inspector flag changes from true to false
        return previous.flags.enableDatabaseInspector !=
            current.flags.enableDatabaseInspector;
      },
      listener: (context, state) {
        // Navigate back to first route when Database Inspector is turned off
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      builder: (context, state) {
        final flags = state.flags;

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
            key: ValueKey(
              'fab_debug_${flags.enableDatabaseInspector}_${flags.enableDebugOverlay}',
            ),
            onSelectedMockBackend: (scenario) {
              // Handle mock backend scenario selection if needed
            },
            onFeatureFlags: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FeatureFlagDebugPanel(),
                ),
              );
            },
            onApiClientExample: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ApiClientExample(),
                ),
              );
            },
            onExamplePages: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ExamplePagesNavigation(),
                ),
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
            enableMockBackend: false,
          ),
        );
      },
    );
  }
}
