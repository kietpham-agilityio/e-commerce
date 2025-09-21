import 'package:flutter/material.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/themes/themes.dart';

/// Demo widget showing how to use feature flags in the app
class FeatureFlagDemoWidget extends StatelessWidget {
  const FeatureFlagDemoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get feature flag service
    final featureFlagService = getFeatureFlagService();
    final flags = featureFlagService.flags;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(title: const EcTitleMediumText('Feature Flag Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EcHeadlineSmallText('Feature Flag Usage Examples'),
            const SizedBox(height: 16),

            // Example 1: Debug Mode
            if (flags.enableDebugMode == true) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const EcTitleSmallText('🐛 Debug Mode Enabled'),
                      const SizedBox(height: 8),
                      EcBodySmallText(
                        'This card only shows when DEBUG_MODE=true in .env file',
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange),
                        ),
                        child: EcBodySmallText(
                          'Debug information would be displayed here',
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Example 2: New Checkout Flow
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EcTitleSmallText('🛒 Checkout Flow'),
                    const SizedBox(height: 8),
                    if (flags.enableNewCheckoutFlow == true) ...[
                      EcBodySmallText(
                        'Using NEW checkout flow',
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('New checkout flow activated!'),
                            ),
                          );
                        },
                        child: const EcLabelMediumText('New Checkout'),
                      ),
                    ] else ...[
                      const EcBodySmallText('Using OLD checkout flow'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Old checkout flow activated!'),
                            ),
                          );
                        },
                        child: const EcLabelMediumText('Old Checkout'),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Example 3: Social Login
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EcTitleSmallText('🔐 Login Options'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email login activated!'),
                          ),
                        );
                      },
                      child: const EcLabelMediumText('Email Login'),
                    ),
                    if (flags.enableSocialLogin == true) ...[
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Social login activated!'),
                            ),
                          );
                        },
                        child: const EcLabelMediumText('Social Login'),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Example 4: Analytics
            if (flags.enableAnalytics == true) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const EcTitleSmallText('📊 Analytics Enabled'),
                      const SizedBox(height: 8),
                      const EcBodySmallText(
                        'User interactions are being tracked for analytics',
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: const EcBodySmallText(
                          'Analytics data: Page views, clicks, conversions',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Example 5: Admin Features
            if (flags.enableAdminDebugPanel == true) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const EcTitleSmallText('👨‍💼 Admin Debug Panel'),
                      const SizedBox(height: 8),
                      const EcBodySmallText('Admin-only features are visible'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('User management opened'),
                                ),
                              );
                            },
                            child: const EcLabelSmallText('Manage Users'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('System settings opened'),
                                ),
                              );
                            },
                            child: const EcLabelSmallText('System Settings'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Feature Flag Status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EcTitleSmallText('Current Feature Flag Status'),
                    const SizedBox(height: 8),
                    _buildStatusRow(
                      context,
                      'Debug Mode',
                      flags.enableDebugMode,
                    ),
                    _buildStatusRow(
                      context,
                      'API Logging',
                      flags.enableApiLogging,
                    ),
                    _buildStatusRow(
                      context,
                      'Mock Backend',
                      flags.enableMockBackend,
                    ),
                    _buildStatusRow(
                      context,
                      'New Checkout',
                      flags.enableNewCheckoutFlow,
                    ),
                    _buildStatusRow(
                      context,
                      'Social Login',
                      flags.enableSocialLogin,
                    ),
                    _buildStatusRow(
                      context,
                      'Analytics',
                      flags.enableAnalytics,
                    ),
                    _buildStatusRow(
                      context,
                      'Admin Panel',
                      flags.enableAdminDebugPanel,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(BuildContext context, String label, bool? value) {
    final isEnabled = value ?? false;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: EcBodySmallText(
              label,
              overflow: TextOverflow.ellipsis,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            isEnabled ? Icons.check_circle : Icons.cancel,
            color: isEnabled ? Colors.green : Colors.red,
            size: 16,
          ),
        ],
      ),
    );
  }
}
