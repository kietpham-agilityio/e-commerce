import 'package:e_commerce_app/presentations/comments/comments_page.dart';
import 'package:e_commerce_app/presentations/pages/api_client_example.dart';
import 'package:e_commerce_app/presentations/pages/feature_flag_demo_page.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:flutter/material.dart';

import '../items/items_page.dart';

/// Simple navigation widget for testing features
class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Test feature flag service
    try {
      final featureFlagService = getFeatureFlagService();
      final flags = featureFlagService.flags;
      debugPrint('🎯 Feature flags loaded successfully');
      debugPrint('📊 Debug Mode: ${flags.enableDebugMode}');
    } catch (e) {
      debugPrint('❌ Feature flag error: $e');
    }

    return Scaffold(
      appBar: EcAppBar(title: const EcTitleLargeText('E-Commerce Example')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const EcHeadlineSmallText('Navigation Examples'),
          const SizedBox(height: 16),

          _buildNavigationCard(
            context,
            title: 'Items Page',
            description: 'View items with API integration',
            icon: Icons.inventory,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ItemsPage()),
              );
            },
          ),

          const SizedBox(height: 12),

          _buildNavigationCard(
            context,
            title: 'Comments Page',
            description: 'View comments with BLoC pattern',
            icon: Icons.comment,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CommentsPage(postId: 1),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          _buildNavigationCard(
            context,
            title: 'API Client Example',
            description:
                'Demonstrate API client concepts with mock implementations',
            icon: Icons.api,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ApiClientExample(),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          _buildNavigationCard(
            context,
            title: 'Feature Flag Demo',
            description: 'See feature flags in action with real examples',
            icon: Icons.play_circle,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FeatureFlagDemoWidget(),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          const EcHeadlineSmallText('Environment Info'),
          const SizedBox(height: 8),

          Card(
            color: Theme.of(context).colorScheme.onSecondary,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EcTitleSmallText('Current Configuration'),
                  const SizedBox(height: 8),
                  const EcBodyMediumText(
                    'This page demonstrates the simplified feature flag system with environment-based configurations.',
                  ),
                  const SizedBox(height: 8),
                  const EcBodySmallText(
                    '• Development: Debug features enabled',
                  ),
                  const EcBodySmallText('• Staging: Limited debug features'),
                  const EcBodySmallText('• Production: Minimal debug features'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      elevation: 4,
      shadowColor: Theme.of(
        context,
      ).colorScheme.onSecondary.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: Theme.of(context).colorScheme.onSecondary,
        leading: Icon(icon),
        title: EcTitleLargeText(title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: EcBodyMediumText(
            description,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
