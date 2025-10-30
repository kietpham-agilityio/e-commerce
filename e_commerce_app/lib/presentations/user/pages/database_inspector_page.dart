import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

/// Database Inspector Example Page
/// Demonstrates how to inspect and manage local database
class DatabaseInspectorPage extends StatefulWidget {
  const DatabaseInspectorPage({super.key});

  @override
  State<DatabaseInspectorPage> createState() => _DatabaseInspectorPageState();
}

class _DatabaseInspectorPageState extends State<DatabaseInspectorPage> {
  String _selectedTable = 'users';
  final List<String> _tables = ['users', 'products', 'orders', 'cart_items'];

  // Mock database data
  final Map<String, List<Map<String, dynamic>>> _mockData = {
    'users': [
      {
        'id': 1,
        'name': 'John Doe',
        'email': 'john@example.com',
        'created_at': '2024-01-15',
      },
      {
        'id': 2,
        'name': 'Jane Smith',
        'email': 'jane@example.com',
        'created_at': '2024-01-16',
      },
      {
        'id': 3,
        'name': 'Bob Wilson',
        'email': 'bob@example.com',
        'created_at': '2024-01-17',
      },
    ],
    'products': [
      {'id': 1, 'name': 'iPhone 15', 'price': 999.99, 'stock': 50},
      {'id': 2, 'name': 'MacBook Pro', 'price': 2499.99, 'stock': 30},
      {'id': 3, 'name': 'AirPods Pro', 'price': 249.99, 'stock': 100},
    ],
    'orders': [
      {
        'id': 1,
        'user_id': 1,
        'total': 1249.98,
        'status': 'completed',
        'date': '2024-01-20',
      },
      {
        'id': 2,
        'user_id': 2,
        'total': 999.99,
        'status': 'pending',
        'date': '2024-01-21',
      },
    ],
    'cart_items': [
      {'id': 1, 'user_id': 1, 'product_id': 1, 'quantity': 2},
      {'id': 2, 'user_id': 2, 'product_id': 3, 'quantity': 1},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      appBar: EcAppBar(
        title: const EcTitleMediumText('🗄️ Database Inspector'),
      ),
      body: Column(
        children: [
          // Quick Actions
          Container(
            padding: const EdgeInsets.all(16),
            color: colorScheme.outline,
            child: Row(
              children: [
                Expanded(
                  child: EcElevatedButton(
                    text: 'Clear All',
                    onPressed: _clearDatabase,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: EcElevatedButton(
                    text: 'Export DB',
                    onPressed: _exportDatabase,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: EcElevatedButton(
                    text: 'Refresh',
                    onPressed: () => setState(() {}),
                  ),
                ),
              ],
            ),
          ),

          // Table Selector
          Container(
            padding: const EdgeInsets.all(16),
            color: colorScheme.outline,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EcTitleSmallText('Select Table:'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children:
                      _tables.map((table) {
                        final isSelected = table == _selectedTable;
                        return ChoiceChip(
                          label: Text(table),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedTable = table;
                            });
                          },
                        );
                      }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Database Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const EcBodyMediumText('Database Size:'),
                        EcBodyMediumText('2.4 MB', color: colorScheme.primary),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const EcBodyMediumText('Total Tables:'),
                        EcBodyMediumText(
                          '${_tables.length}',
                          color: colorScheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EcBodyMediumText('$_selectedTable Records:'),
                        EcBodyMediumText(
                          '${_mockData[_selectedTable]?.length ?? 0}',
                          color: colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Table Data
          Expanded(child: _buildTableData(colorScheme)),
        ],
      ),
    );
  }

  Widget _buildTableData(ColorScheme colorScheme) {
    final data = _mockData[_selectedTable] ?? [];

    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 64, color: colorScheme.secondary),
            const SizedBox(height: 16),
            EcBodyLargeText(
              'No data in $_selectedTable table',
              color: colorScheme.secondary,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final record = data[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ExpansionTile(
            title: EcTitleSmallText('Record #${record['id']}'),
            subtitle: EcBodySmallText(
              '${record.keys.length} fields',
              color: colorScheme.secondary,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children:
                      record.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: EcBodyMediumText(
                                  '${entry.key}:',
                                  color: colorScheme.primary,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: EcBodyMediumText('${entry.value}'),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ),
              const Divider(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => _editRecord(record),
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit'),
                  ),
                  TextButton.icon(
                    onPressed: () => _deleteRecord(record),
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text('Delete'),
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _clearDatabase() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Clear Database'),
            content: const Text(
              'Are you sure you want to clear all database tables? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Database cleared successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
                child: const Text('Clear'),
              ),
            ],
          ),
    );
  }

  void _exportDatabase() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('📤 Database exported to /exports/database.json'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _editRecord(Map<String, dynamic> record) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✏️ Editing record #${record['id']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _deleteRecord(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Record'),
            content: Text(
              'Are you sure you want to delete record #${record['id']}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('🗑️ Record #${record['id']} deleted'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }
}
