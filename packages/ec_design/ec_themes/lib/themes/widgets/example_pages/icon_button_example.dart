import 'package:flutter/material.dart';
import '../icon_button.dart';
import '../../app_shadows.dart';
import '../ec_app_bar.dart';

/// Example page demonstrating EcIconButton usage
class EcIconButtonExample extends StatelessWidget {
  const EcIconButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(titleText: 'EcIconButton Examples'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Examples
            _buildSection(
              title: 'Basic Examples',
              children: [
                Row(
                  children: [
                    EcIconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed:
                          () => _showSnackBar(context, 'Favorite pressed'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () => _showSnackBar(context, 'Share pressed'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.settings),
                      onPressed:
                          () => _showSnackBar(context, 'Settings pressed'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Different Sizes
            _buildSection(
              title: 'Different Sizes',
              children: [
                Row(
                  children: [
                    EcIconButton(
                      icon: const Icon(Icons.star),
                      size: EcIconButtonSizes.small,
                      onPressed: () => _showSnackBar(context, 'Small button'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.star),
                      size: EcIconButtonSizes.medium,
                      onPressed: () => _showSnackBar(context, 'Medium button'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.star),
                      size: EcIconButtonSizes.large,
                      onPressed: () => _showSnackBar(context, 'Large button'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Custom Colors
            _buildSection(
              title: 'Custom Colors',
              children: [
                Row(
                  children: [
                    EcIconButton(
                      icon: const Icon(Icons.add),
                      backgroundColor: Colors.red,
                      iconColor: Colors.white,
                      onPressed: () => _showSnackBar(context, 'Red button'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.remove),
                      backgroundColor: Colors.green,
                      iconColor: Colors.white,
                      onPressed: () => _showSnackBar(context, 'Green button'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.edit),
                      backgroundColor: Colors.blue,
                      iconColor: Colors.white,
                      onPressed: () => _showSnackBar(context, 'Blue button'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Different Border Radius
            _buildSection(
              title: 'Different Border Radius',
              children: [
                Row(
                  children: [
                    EcIconButton(
                      icon: const Icon(Icons.home),
                      borderRadius: EcIconButtonRadius.small,
                      onPressed: () => _showSnackBar(context, 'Small radius'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.home),
                      borderRadius: EcIconButtonRadius.medium,
                      onPressed: () => _showSnackBar(context, 'Medium radius'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.home),
                      borderRadius: EcIconButtonRadius.large,
                      onPressed: () => _showSnackBar(context, 'Large radius'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.home),
                      borderRadius: EcIconButtonRadius.fullyRounded(48),
                      onPressed: () => _showSnackBar(context, 'Fully rounded'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // With Shadows
            _buildSection(
              title: 'With Shadows',
              children: [
                Row(
                  children: [
                    EcIconButton(
                      icon: const Icon(Icons.lightbulb),
                      showShadow: true,
                      onPressed: () => _showSnackBar(context, 'With shadow'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.lightbulb),
                      showShadow: true,
                      customShadow: EcShadows.dropShadowSoft(context),
                      onPressed: () => _showSnackBar(context, 'Custom shadow'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.lightbulb),
                      showShadow: true,
                      customShadow: EcShadows.dropShadowRed(context),
                      backgroundColor: Colors.red,
                      iconColor: Colors.white,
                      onPressed: () => _showSnackBar(context, 'Red shadow'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Disabled State
            _buildSection(
              title: 'Disabled State',
              children: [
                Row(
                  children: [
                    EcIconButton(
                      icon: const Icon(Icons.block),
                      enabled: false,
                      onPressed:
                          () => _showSnackBar(context, 'This should not show'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.block),
                      enabled: false,
                      backgroundColor: Colors.grey,
                      iconColor: Colors.white,
                      onPressed:
                          () => _showSnackBar(context, 'This should not show'),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // With Tooltips
            _buildSection(
              title: 'With Tooltips',
              children: [
                Row(
                  children: [
                    EcIconButton(
                      icon: const Icon(Icons.info),
                      tooltip: 'Information',
                      onPressed: () => _showSnackBar(context, 'Info pressed'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.help),
                      tooltip: 'Help',
                      onPressed: () => _showSnackBar(context, 'Help pressed'),
                    ),
                    const SizedBox(width: 16),
                    EcIconButton(
                      icon: const Icon(Icons.warning),
                      tooltip: 'Warning',
                      backgroundColor: Colors.orange,
                      iconColor: Colors.white,
                      onPressed:
                          () => _showSnackBar(context, 'Warning pressed'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
