import 'package:flutter/material.dart';
import '../ec_app_bar.dart';

/// Example page demonstrating EcAppBar usage
class EcAppBarExample extends StatelessWidget {
  const EcAppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(
        titleText: 'App Bar Examples',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSnackBar(context, 'Search pressed'),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showSnackBar(context, 'More pressed'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Basic App Bars',
              children: [
                _buildExampleCard(
                  title: 'Default App Bar',
                  description: 'Standard app bar with surfaceDim background',
                  child: _buildAppBarPreview(
                    EcAppBar(titleText: 'Default App Bar'),
                  ),
                ),
                _buildExampleCard(
                  title: 'With Actions',
                  description: 'App bar with action buttons',
                  child: _buildAppBarPreview(
                    EcAppBar(
                      titleText: 'With Actions',
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: 'App Bar Variations',
              children: [
                _buildExampleCard(
                  title: 'With Back Button',
                  description: 'App bar with custom back button handler',
                  child: _buildAppBarPreview(
                    EcAppBarVariations.withBackButton(
                      titleText: 'With Back Button',
                      onBackPressed:
                          () => _showSnackBar(context, 'Back pressed'),
                    ),
                  ),
                ),
                _buildExampleCard(
                  title: 'With Custom Leading',
                  description: 'App bar with custom leading widget',
                  child: _buildAppBarPreview(
                    EcAppBarVariations.withCustomLeading(
                      titleText: 'Custom Leading',
                      leading: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => _showSnackBar(context, 'Menu pressed'),
                      ),
                    ),
                  ),
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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildExampleCard({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarPreview(Widget appBar) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: appBar,
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
