import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../tag.dart';
import '../text.dart';

/// Example page demonstrating EcTag usage with multiple selection
class EcTagExample extends StatefulWidget {
  const EcTagExample({super.key});

  @override
  State<EcTagExample> createState() => _EcTagExampleState();
}

class _EcTagExampleState extends State<EcTagExample> {
  // Selected tags for each pair
  final Set<String> _selectedOutlinedTags = <String>{};
  final Set<String> _selectedRoundedTags = <String>{};

  // Sample tag data
  final List<String> _sampleTags = [
    'Electronics',
    'Clothing',
    'Books',
    'Home',
    'Sports',
    'Beauty',
    'Toys',
    'Automotive',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(titleText: 'Tag Examples'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Pair 1 - Outlined Style',
              description:
                  'Outlined tags with corner radius 8, width 100, height 40. Tap to toggle between selected/unselected states.',
              children: [
                EcTagWrap(
                  tags:
                      _sampleTags
                          .map(
                            (tag) => EcTag(
                              text: tag,
                              style:
                                  _selectedOutlinedTags.contains(tag)
                                      ? EcTagStyle.outlinedSelected
                                      : EcTagStyle.outlinedUnselected,
                              isSelected: _selectedOutlinedTags.contains(tag),
                              onTap:
                                  () => _toggleTag(_selectedOutlinedTags, tag),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 16),
                EcBodyMediumText(
                  'Selected: ${_selectedOutlinedTags.join(', ')}',
                ),
              ],
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: 'Pair 2 - Rounded Style',
              description:
                  'Rounded tags with corner radius 29, width 100, height 30. Tap to toggle between selected/unselected states.',
              children: [
                EcTagWrap(
                  tags:
                      _sampleTags
                          .map(
                            (tag) => EcTag(
                              text: tag,
                              style:
                                  _selectedRoundedTags.contains(tag)
                                      ? EcTagStyle.roundedSelected
                                      : EcTagStyle.roundedUnselected,
                              isSelected: _selectedRoundedTags.contains(tag),
                              onTap:
                                  () => _toggleTag(_selectedRoundedTags, tag),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 16),
                EcBodyMediumText(
                  'Selected: ${_selectedRoundedTags.join(', ')}',
                ),
              ],
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: 'Custom Tags',
              description: 'Tags with custom properties',
              children: [
                EcTagWrap(
                  tags: [
                    EcTag(
                      text: 'Custom Size',
                      style: EcTagStyle.outlinedSelected,
                      width: 120,
                      height: 50,
                    ),
                    EcTag(
                      text: 'Custom Radius',
                      style: EcTagStyle.outlinedUnselected,
                      borderRadius: 20,
                    ),
                    EcTag(
                      text: 'Custom Colors',
                      style: EcTagStyle.outlinedUnselected,
                      backgroundColor: Colors.purple,
                      textColor: Colors.white,
                      borderColor: Colors.purple,
                    ),
                    EcTag(
                      text: 'Disabled',
                      style: EcTagStyle.roundedSelected,
                      enabled: false,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: 'Layout Examples',
              description: 'Different ways to arrange tags',
              children: [
                EcTitleMediumText('Row Layout:'),
                const SizedBox(height: 8),
                EcTagRow(
                  tags:
                      _sampleTags
                          .take(4)
                          .map(
                            (tag) => EcTag(
                              text: tag,
                              style: EcTagStyle.outlinedSelected,
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 16),
                EcTitleMediumText('Column Layout:'),
                const SizedBox(height: 8),
                EcTagColumn(
                  tags:
                      _sampleTags
                          .take(3)
                          .map(
                            (tag) => EcTag(
                              text: tag,
                              style: EcTagStyle.roundedSelected,
                            ),
                          )
                          .toList(),
                ),
              ],
            ),

            const SizedBox(height: 32),

            _buildSection(
              title: 'Filter Example',
              description:
                  'Using tags for filtering with multiple selection. Tap tags to toggle their selection state.',
              children: [
                EcTagWrap(
                  tags:
                      _sampleTags
                          .map(
                            (tag) => EcTag(
                              text: tag,
                              style:
                                  _selectedOutlinedTags.contains(tag)
                                      ? EcTagStyle.outlinedSelected
                                      : EcTagStyle.outlinedUnselected,
                              isSelected: _selectedOutlinedTags.contains(tag),
                              onTap:
                                  () => _toggleTag(_selectedOutlinedTags, tag),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.4,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EcTitleMediumText('Filter Results:'),
                      const SizedBox(height: 8),
                      EcBodyMediumText(
                        _selectedOutlinedTags.isEmpty
                            ? 'No filters applied'
                            : 'Filtering by: ${_selectedOutlinedTags.join(', ')}',
                      ),
                    ],
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

  void _toggleTag(Set<String> selectedTags, String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }
}
