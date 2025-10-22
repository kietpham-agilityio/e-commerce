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

  void _updateFlag(
    EcFeatureFlag newFlags, {
    bool navigateToFirstRoute = true,
    String? flagName,
    bool? flagValue,
  }) {
    setState(() {
      _currentFlags = newFlags;
      _featureFlagService.updateFlags(newFlags);
    });

    // Dispatch event to AppBloc to update global state
    context.read<AppBloc>().add(
      AppFeatureFlagsUpdated(
        newFlags,
        flagName: flagName,
        oldValue: flagValue == true ? false : true,
        newValue: flagValue,
      ),
    );

    // Show specific feedback about what changed
    final statusText = flagValue == true ? 'enabled ✅' : 'disabled ❌';
    final message =
        flagName != null
            ? '$flagName $statusText'
            : 'Feature flag updated successfully';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        backgroundColor:
            flagValue == true ? Colors.green.shade700 : Colors.orange.shade700,
      ),
    );

    // Navigate to home to see the changes in action
    if (navigateToFirstRoute) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          // Pop all routes until we reach the root (home)
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      });
    }
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
            // Debug & Development Features

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
          title: 'Show Shop Page',
          subtitle: 'Display shop page in demo',
          value: _currentFlags.enableShopPage ?? false,
          onChanged: (value) {
            _updateFlag(
              _currentFlags.copyWith(enableShopPage: value),
              flagName: 'Show Shop Page',
              flagValue: value,
            );
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Items Page',
          subtitle: 'Display items listing page in demo',
          value: _currentFlags.enableItemsPage ?? false,
          onChanged: (value) {
            _updateFlag(
              _currentFlags.copyWith(enableItemsPage: value),
              flagName: 'Show Items Page',
              flagValue: value,
            );
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
              flagName: 'Show Product Details',
              flagValue: value,
            );
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Shopping Bag',
          subtitle: 'Display shopping bag page in demo',
          value: _currentFlags.enableBagPage ?? false,
          onChanged: (value) {
            _updateFlag(
              _currentFlags.copyWith(enableBagPage: value),
              flagName: 'Show Shopping Bag',
              flagValue: value,
            );
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Favorites',
          subtitle: 'Display favorites page in demo',
          value: _currentFlags.enableFavoritesPage ?? false,
          onChanged: (value) {
            _updateFlag(
              _currentFlags.copyWith(enableFavoritesPage: value),
              flagName: 'Show Favorites',
              flagValue: value,
            );
          },
        ),

        _buildFlagToggle(
          context,
          title: 'Show Profile Page',
          subtitle: 'Display user profile page in demo',
          value: _currentFlags.enableProfilePage ?? false,
          onChanged: (value) {
            _updateFlag(
              _currentFlags.copyWith(enableProfilePage: value),
              flagName: 'Show Profile Page',
              flagValue: value,
            );
          },
        ),
        _buildFlagToggle(
          context,
          title: 'Show Comments Page',
          subtitle: 'Display comments page in demo',
          value: _currentFlags.enableCommentsPage ?? false,
          onChanged: (value) {
            _updateFlag(
              _currentFlags.copyWith(enableCommentsPage: value),
              flagName: 'Show Comments Page',
              flagValue: value,
            );
          },
        ),
      ],
    );
  }
}
