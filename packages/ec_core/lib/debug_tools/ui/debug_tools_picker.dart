import 'package:flutter/material.dart';

class DebugToolsPickerPage<T> extends StatelessWidget {
  const DebugToolsPickerPage({
    required this.title,
    required this.items,
    super.key,
  });

  final String title;
  final List<DebugToolsItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            title: Text(item.name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              item.onTap();
              Navigator.of(context).pop(item);
            },
          );
        },
      ),
    );
  }
}

class DebugToolPicker<T> extends StatelessWidget {
  const DebugToolPicker({super.key, required this.title, required this.items});

  final String title;
  final List<DebugToolsItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            title: Text(item.name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              item.onTap();
              Navigator.of(context).pop(item);
            },
          );
        },
      ),
    );
  }
}

class DebugToolsItem {
  const DebugToolsItem({required this.name, required this.onTap});

  final String name;
  final VoidCallback onTap;
}
