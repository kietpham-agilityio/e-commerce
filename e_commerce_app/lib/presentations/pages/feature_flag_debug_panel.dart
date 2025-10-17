import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/bloc/app_event.dart';
import 'package:flutter/material.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Debug panel for runtime configuration of feature flags
class FeatureFlagDebugPanel extends StatefulWidget {
  const FeatureFlagDebugPanel({super.key});

  @override
  State<FeatureFlagDebugPanel> createState() => _FeatureFlagDebugPanelState();
}

class _FeatureFlagDebugPanelState extends State<FeatureFlagDebugPanel> {
  late FeatureFlagService _featureFlagService;
  late EcFeatureFlag _currentFlags;

  @override
  void initState() {
    super.initState();
    _featureFlagService = getFeatureFlagService();
    _currentFlags = _featureFlagService.flags;
  }

  void _updateFlag(EcFeatureFlag newFlags, {bool navigateToHome = false}) {
    setState(() {
      _currentFlags = newFlags;
      _featureFlagService.updateFlags(newFlags);
    });

    // Dispatch event to AppBloc to update global state
    context.read<AppBloc>().add(AppFeatureFlagsUpdated(newFlags));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          navigateToHome
              ? 'Feature flag updated - navigating to home'
              : 'Feature flag updated successfully',
        ),
        duration: const Duration(seconds: 1),
      ),
    );

    // Navigate to home to see the changes in action
    if (navigateToHome) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          // Pop all routes until we reach the root (home)
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      });
    }
  }

  void _resetToDefaults() {
    final defaultFlags = EcFeatureFlag.withEnvironment();
    _updateFlag(defaultFlags);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reset to environment defaults'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _enableDebugMode() {
    _featureFlagService.enableDebugMode();
    setState(() {
      _currentFlags = _featureFlagService.flags;
    });

    // Dispatch event to AppBloc to update global state
    context.read<AppBloc>().add(AppFeatureFlagsUpdated(_currentFlags));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Debug mode enabled - navigating to home'),
        duration: Duration(seconds: 1),
      ),
    );

    // Navigate to home to see the changes in action
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  void _enableProductionMode() {
    _featureFlagService.enableProductionMode();
    setState(() {
      _currentFlags = _featureFlagService.flags;
    });

    // Dispatch event to AppBloc to update global state
    context.read<AppBloc>().add(AppFeatureFlagsUpdated(_currentFlags));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Production mode enabled - navigating to home'),
        duration: Duration(seconds: 1),
      ),
    );

    // Navigate to home to see the changes in action
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(
        title: const EcTitleMediumText('🛠️ Feature Flag Debug Panel'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Actions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EcTitleSmallText('Quick Actions'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _enableDebugMode,
                          icon: const Icon(Icons.bug_report),
                          label: const EcLabelMediumText('Enable Debug'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _enableProductionMode,
                          icon: const Icon(Icons.security),
                          label: const EcLabelMediumText('Enable Production'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _resetToDefaults,
                          icon: const Icon(Icons.refresh),
                          label: const EcLabelMediumText('Reset to .env'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Debug & Development Features
            _buildFlagSection(
              context,
              title: '🐛 Debug & Development',
              children: [
                _buildFlagToggle(
                  context,
                  title: 'Debug Mode',
                  subtitle: 'Enable debug mode features',
                  value: _currentFlags.enableDebugMode ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableDebugMode: value),
                      navigateToHome: true,
                    );
                  },
                ),
                _buildFlagToggle(
                  context,
                  title: 'API Logging',
                  subtitle: 'Log all API requests and responses',
                  value: _currentFlags.enableApiLogging ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableApiLogging: value),
                    );
                  },
                ),
                _buildFlagToggle(
                  context,
                  title: 'Mock Backend',
                  subtitle: 'Use mocked API responses',
                  value: _currentFlags.enableMockBackend ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableMockBackend: value),
                      navigateToHome: true,
                    );
                  },
                ),
                _buildFlagToggle(
                  context,
                  title: 'Database Inspector',
                  subtitle: 'Enable database inspection tools',
                  value: _currentFlags.enableDatabaseInspector ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableDatabaseInspector: value),
                      navigateToHome: true,
                    );
                  },
                ),
                _buildFlagToggle(
                  context,
                  title: 'Debug Overlay',
                  subtitle: 'Show debug overlay on screen',
                  value: _currentFlags.enableDebugOverlay ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableDebugOverlay: value),
                      navigateToHome: true,
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Admin Features
            _buildFlagSection(
              context,
              title: '👨‍💼 Admin Features',
              children: [
                _buildFlagToggle(
                  context,
                  title: 'Admin Debug Panel',
                  subtitle: 'Show admin-only debug features',
                  value: _currentFlags.enableAdminDebugPanel ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableAdminDebugPanel: value),
                      navigateToHome: true,
                    );
                  },
                ),
                _buildFlagToggle(
                  context,
                  title: 'User Impersonation',
                  subtitle: 'Allow admin to impersonate users',
                  value: _currentFlags.enableUserImpersonation ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableUserImpersonation: value),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Analytics & Monitoring
            _buildFlagSection(
              context,
              title: '📊 Analytics & Monitoring',
              children: [
                _buildFlagToggle(
                  context,
                  title: 'Analytics',
                  subtitle: 'Track user behavior and events',
                  value: _currentFlags.enableAnalytics ?? false,
                  onChanged: (value) {
                    _updateFlag(_currentFlags.copyWith(enableAnalytics: value));
                  },
                ),
                _buildFlagToggle(
                  context,
                  title: 'Crash Reporting',
                  subtitle: 'Send crash reports to server',
                  value: _currentFlags.enableCrashReporting ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableCrashReporting: value),
                    );
                  },
                ),
                _buildFlagToggle(
                  context,
                  title: 'Performance Monitoring',
                  subtitle: 'Monitor app performance metrics',
                  value: _currentFlags.enablePerformanceMonitoring ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(
                        enablePerformanceMonitoring: value,
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // API Configuration
            _buildFlagSection(
              context,
              title: '🌐 API Configuration',
              children: [
                _buildFlagToggle(
                  context,
                  title: 'API Cache',
                  subtitle: 'Enable API response caching',
                  value: _currentFlags.enableApiCache ?? false,
                  onChanged: (value) {
                    _updateFlag(_currentFlags.copyWith(enableApiCache: value));
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // UI Features
            _buildFlagSection(
              context,
              title: '🎨 UI Features',
              children: [
                _buildFlagToggle(
                  context,
                  title: 'Dark Mode',
                  subtitle: 'Enable dark theme',
                  value: _currentFlags.enableDarkMode ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableDarkMode: value),
                      navigateToHome: true,
                    );
                  },
                ),
                _buildFlagToggle(
                  context,
                  title: 'Animations',
                  subtitle: 'Enable UI animations',
                  value: _currentFlags.enableAnimations ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableAnimations: value),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Feature Toggles
            _buildFlagSection(
              context,
              title: '🚀 Feature Toggles',
              children: [
                _buildFlagToggle(
                  context,
                  title: 'New Checkout Flow',
                  subtitle: 'Use new checkout experience',
                  value: _currentFlags.enableNewCheckoutFlow ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableNewCheckoutFlow: value),
                    );
                  },
                ),
                _buildFlagToggle(
                  context,
                  title: 'Social Login',
                  subtitle: 'Allow login with social accounts',
                  value: _currentFlags.enableSocialLogin ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enableSocialLogin: value),
                    );
                  },
                ),
                _buildFlagToggle(
                  context,
                  title: 'Push Notifications',
                  subtitle: 'Enable push notifications',
                  value: _currentFlags.enablePushNotifications ?? false,
                  onChanged: (value) {
                    _updateFlag(
                      _currentFlags.copyWith(enablePushNotifications: value),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Page Scenarios for Demo
            _buildPageScenariosSection(context),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFlagSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EcTitleSmallText(title),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildFlagToggle(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EcBodyMediumText(title),
                const SizedBox(height: 2),
                EcBodySmallText(
                  subtitle,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildPageScenariosSection(BuildContext context) {
    return _buildFlagSection(
      context,
      title: '📱 Page Scenarios Demo',
      children: [
        _buildFlagToggle(
          context,
          title: 'Show Home Page',
          subtitle: 'Display home page in demo',
          value: _currentFlags.enableHomePage ?? false,
          onChanged: (value) {
            _updateFlag(_currentFlags.copyWith(enableHomePage: value));
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Shop Page',
          subtitle: 'Display shop page in demo',
          value: _currentFlags.enableShopPage ?? false,
          onChanged: (value) {
            _updateFlag(_currentFlags.copyWith(enableShopPage: value));
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Items Page',
          subtitle: 'Display items listing page in demo',
          value: _currentFlags.enableItemsPage ?? false,
          onChanged: (value) {
            _updateFlag(_currentFlags.copyWith(enableItemsPage: value));
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Product Details',
          subtitle: 'Display product details page in demo',
          value: _currentFlags.enableProductDetailsPage ?? false,
          onChanged: (value) {
            _updateFlag(
              _currentFlags.copyWith(enableProductDetailsPage: value),
            );
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Shopping Bag',
          subtitle: 'Display shopping bag page in demo',
          value: _currentFlags.enableBagPage ?? false,
          onChanged: (value) {
            _updateFlag(_currentFlags.copyWith(enableBagPage: value));
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Favorites',
          subtitle: 'Display favorites page in demo',
          value: _currentFlags.enableFavoritesPage ?? false,
          onChanged: (value) {
            _updateFlag(_currentFlags.copyWith(enableFavoritesPage: value));
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Login Page',
          subtitle: 'Display login page in demo',
          value: _currentFlags.enableLoginPage ?? false,
          onChanged: (value) {
            _updateFlag(_currentFlags.copyWith(enableLoginPage: value));
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Profile Page',
          subtitle: 'Display user profile page in demo',
          value: _currentFlags.enableProfilePage ?? false,
          onChanged: (value) {
            _updateFlag(_currentFlags.copyWith(enableProfilePage: value));
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Comments Page',
          subtitle: 'Display comments page in demo',
          value: _currentFlags.enableCommentsPage ?? false,
          onChanged: (value) {
            _updateFlag(_currentFlags.copyWith(enableCommentsPage: value));
          },
        ),
      ],
    );
  }
}
