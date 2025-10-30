import 'package:flutter/material.dart';

import '../app_bar.dart';
import '../checkbox.dart';
import '../text.dart';

/// Example page demonstrating EcCheckbox usage
class EcCheckboxExample extends StatefulWidget {
  const EcCheckboxExample({super.key});

  @override
  State<EcCheckboxExample> createState() => _EcCheckboxExampleState();
}

class _EcCheckboxExampleState extends State<EcCheckboxExample> {
  // Basic checkbox states
  bool _basicCheckbox = false;
  bool? _tristateCheckbox;

  // Multiple choice checkboxes
  final Map<String, bool> _multipleChoice = {
    'Option 1': false,
    'Option 2': false,
    'Option 3': false,
    'Option 4': false,
  };

  // Settings checkboxes
  final Map<String, bool> _settings = {
    'Enable notifications': true,
    'Auto-save documents': false,
    'Dark mode': false,
    'Sync across devices': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(titleText: 'Checkbox Examples'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Basic Checkboxes',
              description: 'Simple checkbox with text support',
              children: [
                EcCheckbox(
                  value: _basicCheckbox,
                  text: 'Basic checkbox with text',
                  onChanged: (value) {
                    setState(() {
                      _basicCheckbox = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 16),
                EcCheckbox(
                  value: _tristateCheckbox,
                  text: 'Tristate checkbox (indeterminate state)',
                  tristate: true,
                  onChanged: (value) {
                    setState(() {
                      _tristateCheckbox = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                EcCheckbox(
                  value: false,
                  text: 'Disabled checkbox',
                  enabled: false,
                ),
              ],
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: 'Multiple Choice',
              description: 'Multiple checkboxes for selection',
              children: [
                EcCheckboxColumn(
                  items:
                      _multipleChoice.entries.map((entry) {
                        return EcCheckboxItem(
                          value: entry.value,
                          text: entry.key,
                          onChanged: (value) {
                            setState(() {
                              _multipleChoice[entry.key] = value ?? false;
                            });
                          },
                          checkboxFirst: false,
                        );
                      }).toList(),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.4,
                    ),
                  ),
                  child: EcBodyMediumText(() {
                    final selected = _multipleChoice.entries
                        .where((e) => e.value)
                        .map((e) => e.key)
                        .join(', ');
                    return 'Selected: ${selected.isEmpty ? 'None' : selected}';
                  }()),
                ),
              ],
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: 'Settings Panel',
              description: 'Checkboxes for settings and preferences',
              children: [
                EcCheckboxColumn(
                  items:
                      _settings.entries.map((entry) {
                        return EcCheckboxItem(
                          value: entry.value,
                          text: entry.key,
                          onChanged: (value) {
                            setState(() {
                              _settings[entry.key] = value ?? false;
                            });
                          },
                        );
                      }).toList(),
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
    required String description,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EcHeadlineSmallText(title),
        const SizedBox(height: 8),
        EcBodySmallText(description),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}
