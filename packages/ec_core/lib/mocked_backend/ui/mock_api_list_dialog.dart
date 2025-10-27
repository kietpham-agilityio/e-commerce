import 'package:flutter/material.dart';

import '../core/mock_api.dart';

class MockApiListDialog<T> extends StatelessWidget {
  const MockApiListDialog({super.key, required this.title, required this.apis});

  final String title;
  final List<MockApi<T>> apis;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Close',
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Material(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: ListView.separated(
                  itemCount: apis.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final api = apis[index];
                    return ListTile(
                      title: Text(api.name),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).pop(api),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
