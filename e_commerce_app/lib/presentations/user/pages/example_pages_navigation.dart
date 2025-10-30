import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

import '../comments/comments_page.dart';
import '../items/items_page.dart';

class ExamplePagesNavigation extends StatelessWidget {
  const ExamplePagesNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcAppBar(
        title: EcHeadlineSmallText('Example Pages'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ExamplePageCard(
            title: 'Items Page',
            description: 'View a list of items with mock data scenarios',
            icon: Icons.list,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ItemsPage()),
              );
            },
          ),
          const SizedBox(height: 16),
          _ExamplePageCard(
            title: 'Comments Page',
            description:
                'View comments for a specific post with mock scenarios',
            icon: Icons.comment,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CommentsPage(postId: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ExamplePageCard extends StatelessWidget {
  const _ExamplePageCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      shadowColor: colorScheme.onSecondary.withValues(alpha: 0.9),
      color: colorScheme.onSecondary,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colorScheme.surfaceDim,
                radius: 24,
                child: Icon(icon, color: colorScheme.secondary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EcTitleMediumText(title),
                    const SizedBox(height: 4),
                    EcBodySmallText(description, color: colorScheme.outline),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colorScheme.outline),
            ],
          ),
        ),
      ),
    );
  }
}
