import 'package:flutter/material.dart';
import 'icon_button_example.dart';
import 'form_input_example.dart';
import 'tab_bar_example.dart';
import 'app_bar_example.dart';
import 'tag_example.dart';
import 'checkbox_example.dart';
import 'label_example.dart';
import 'slide_range_filter_example.dart';
import 'api_client_example.dart';
import '../app_bar.dart';

/// Navigation page that lists all example pages
class ExampleNavigation extends StatelessWidget {
  const ExampleNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(titleText: 'Design System Examples'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: 'Widget Examples',
            children: [
              _buildExampleTile(
                context,
                title: 'Icon Button',
                subtitle: 'Customizable icon buttons with themes and shadows',
                icon: Icons.touch_app,
                onTap:
                    () => _navigateToPage(context, const EcIconButtonExample()),
              ),
              _buildExampleTile(
                context,
                title: 'Tab Bar',
                subtitle: 'Three-tab navigation bar with custom styling',
                icon: Icons.tab,
                onTap:
                    () => _navigateToPage(context, const TabBarExamplePage()),
              ),
              _buildExampleTile(
                context,
                title: 'Form Input',
                subtitle: 'Text fields with validation and custom styling',
                icon: Icons.edit,
                onTap:
                    () => _navigateToPage(context, const FormInputExamples()),
              ),
              _buildExampleTile(
                context,
                title: 'App Bar',
                subtitle:
                    'Common app bar with surfaceDim background and variations',
                icon: Icons.web_asset,
                onTap: () => _navigateToPage(context, const EcAppBarExample()),
              ),
              _buildExampleTile(
                context,
                title: 'Tag',
                subtitle:
                    'Multiple selectable tags for filtering with 4 different styles',
                icon: Icons.label,
                onTap: () => _navigateToPage(context, const EcTagExample()),
              ),
              _buildExampleTile(
                context,
                title: 'Checkbox',
                subtitle:
                    'Checkbox widget with text support and multiple selection',
                icon: Icons.check_box,
                onTap:
                    () => _navigateToPage(context, const EcCheckboxExample()),
              ),
              _buildExampleTile(
                context,
                title: 'Label',
                subtitle:
                    'Promotional labels for discounts, new products, and sales',
                icon: Icons.local_offer,
                onTap: () => _navigateToPage(context, const EcLabelExample()),
              ),
              _buildExampleTile(
                context,
                title: 'Slide Range Filter',
                subtitle:
                    'Range slider for filtering values like price, rating, and year',
                icon: Icons.tune,
                onTap:
                    () => _navigateToPage(
                      context,
                      const EcSlideRangeFilterExample(),
                    ),
              ),
              _buildExampleTile(
                context,
                title: 'API Client',
                subtitle:
                    'HTTP methods, maybe fetch, force fetch, and background API calls',
                icon: Icons.api,
                onTap: () => _navigateToPage(context, const ApiClientExample()),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSection(
            title: 'Coming Soon',
            children: [
              _buildExampleTile(
                context,
                title: 'Button Examples',
                subtitle: 'Elevated, outlined, and text button variations',
                icon: Icons.radio_button_checked,
                enabled: false,
                onTap: null,
              ),
              _buildExampleTile(
                context,
                title: 'Card Examples',
                subtitle: 'Various card layouts and styling options',
                icon: Icons.card_membership,
                enabled: false,
                onTap: null,
              ),
              _buildExampleTile(
                context,
                title: 'Typography Examples',
                subtitle: 'Text styles and typography showcase',
                icon: Icons.text_fields,
                enabled: false,
                onTap: null,
              ),
            ],
          ),
        ],
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

  Widget _buildExampleTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback? onTap,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color:
                enabled
                    ? colors.primaryContainer
                    : colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: enabled ? colors.primary : colors.onSurfaceVariant,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: enabled ? colors.onSurface : colors.onSurfaceVariant,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: enabled ? colors.onSurfaceVariant : colors.onSurfaceVariant,
          ),
        ),
        trailing:
            enabled
                ? Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: colors.onSurfaceVariant,
                )
                : Icon(
                  Icons.lock_outline,
                  size: 16,
                  color: colors.onSurfaceVariant,
                ),
        onTap: enabled ? onTap : null,
        enabled: enabled,
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }
}
