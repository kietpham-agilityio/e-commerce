import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../slide_range_filter.dart';
import '../text.dart';

/// Example page demonstrating EcSlideRangeFilter usage
class EcSlideRangeFilterExample extends StatefulWidget {
  const EcSlideRangeFilterExample({super.key});

  @override
  State<EcSlideRangeFilterExample> createState() =>
      _EcSlideRangeFilterExampleState();
}

class _EcSlideRangeFilterExampleState extends State<EcSlideRangeFilterExample> {
  // Price range filter
  RangeValues _priceRange = const RangeValues(0, 1000);

  // Rating range filter
  RangeValues _ratingRange = const RangeValues(1, 5);

  // Year range filter
  RangeValues _yearRange = const RangeValues(2020, 2024);

  // Size range filter
  RangeValues _sizeRange = const RangeValues(0, 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(titleText: 'Slide Range Filter Examples'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Range Filter Section
            _buildSection(
              title: 'Basic Range Filter',
              description: 'Simple price range filter with default styling',
              children: [
                EcSlideRangeFilter(
                  min: 0,
                  max: 1000,
                  lowerValue: _priceRange.start,
                  upperValue: _priceRange.end,
                  label: 'Price Range (\$)',
                  onChanged: (values) {
                    setState(() {
                      _priceRange = values;
                    });
                  },
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
                  child: EcBodyMediumText(
                    'Selected Price Range: \$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Rating Filter Section
            _buildSection(
              title: 'Rating Filter',
              description:
                  'Rating range filter with custom divisions and formatting',
              children: [
                EcSlideRangeFilter(
                  min: 1,
                  max: 5,
                  lowerValue: _ratingRange.start,
                  upperValue: _ratingRange.end,
                  divisions: 40, // 0.1 increments
                  label: 'Rating Range',
                  valueFormatter: (value) => '${value.toStringAsFixed(1)} ⭐',
                  onChanged: (values) {
                    setState(() {
                      _ratingRange = values;
                    });
                  },
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
                  child: EcBodyMediumText(
                    'Selected Rating Range: ${_ratingRange.start.toStringAsFixed(1)} - ${_ratingRange.end.toStringAsFixed(1)} stars',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Year Filter Section
            _buildSection(
              title: 'Year Filter',
              description: 'Year range filter with integer divisions',
              children: [
                EcSlideRangeFilter(
                  min: 2020,
                  max: 2024,
                  lowerValue: _yearRange.start,
                  upperValue: _yearRange.end,
                  divisions: 4, // Integer steps
                  label: 'Year Range',
                  valueFormatter: (value) => value.toInt().toString(),
                  onChanged: (values) {
                    setState(() {
                      _yearRange = values;
                    });
                  },
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
                  child: EcBodyMediumText(
                    'Selected Year Range: ${_yearRange.start.toInt()} - ${_yearRange.end.toInt()}',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Custom Styling Section
            _buildSection(
              title: 'Custom Styling',
              description: 'Range filter with custom colors and dimensions',
              children: [
                EcSlideRangeFilter(
                  min: 0,
                  max: 50,
                  lowerValue: _sizeRange.start,
                  upperValue: _sizeRange.end,
                  label: 'Size Range (cm)',
                  activeColor: Colors.purple,
                  thumbColor: Colors.purple,
                  overlayColor: Colors.purple.withValues(alpha: 0.12),
                  trackHeight: 8,
                  valueFormatter: (value) => '${value.toInt()} cm',
                  onChanged: (values) {
                    setState(() {
                      _sizeRange = values;
                    });
                  },
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
                  child: EcBodyMediumText(
                    'Selected Size Range: ${_sizeRange.start.toInt()} - ${_sizeRange.end.toInt()} cm',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Disabled State Section
            _buildSection(
              title: 'Disabled State',
              description: 'Range filter in disabled state',
              children: [
                EcSlideRangeFilter(
                  min: 0,
                  max: 100,
                  lowerValue: 20,
                  upperValue: 80,
                  label: 'Disabled Range Filter',
                  enabled: false,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Multiple Filters Section
            _buildSection(
              title: 'Multiple Filters',
              description: 'Using multiple range filters together',
              children: [
                EcSlideRangeFilterColumn(
                  filters: [
                    EcSlideRangeFilter(
                      min: 0,
                      max: 1000,
                      lowerValue: _priceRange.start,
                      upperValue: _priceRange.end,
                      label: 'Price Range (\$)',
                      onChanged: (values) {
                        setState(() {
                          _priceRange = values;
                        });
                      },
                    ),
                    EcSlideRangeFilter(
                      min: 1,
                      max: 5,
                      lowerValue: _ratingRange.start,
                      upperValue: _ratingRange.end,
                      divisions: 40,
                      label: 'Rating Range',
                      valueFormatter:
                          (value) => '${value.toStringAsFixed(1)} ⭐',
                      onChanged: (values) {
                        setState(() {
                          _ratingRange = values;
                        });
                      },
                    ),
                  ],
                  spacing: 24,
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
                      EcTitleMediumText('Applied Filters:'),
                      const SizedBox(height: 8),
                      EcBodyMediumText(
                        'Price: \$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
                      ),
                      EcBodyMediumText(
                        'Rating: ${_ratingRange.start.toStringAsFixed(1)} - ${_ratingRange.end.toStringAsFixed(1)} stars',
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Product Filter Example
            _buildSection(
              title: 'Product Filter Example',
              description:
                  'Real-world example of using range filters for product filtering',
              children: [_buildProductFilterExample()],
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

  Widget _buildProductFilterExample() {
    return Container(
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
          EcTitleLargeText('Filter Products'),
          const SizedBox(height: 16),
          EcSlideRangeFilter(
            min: 0,
            max: 500,
            lowerValue: _priceRange.start,
            upperValue: _priceRange.end,
            label: 'Price Range (\$)',
            divisions: 50,
            onChanged: (values) {
              setState(() {
                _priceRange = values;
              });
            },
          ),
          const SizedBox(height: 16),
          EcSlideRangeFilter(
            min: 1,
            max: 5,
            lowerValue: _ratingRange.start,
            upperValue: _ratingRange.end,
            label: 'Minimum Rating',
            divisions: 40,
            valueFormatter: (value) => '${value.toStringAsFixed(1)} ⭐',
            onChanged: (values) {
              setState(() {
                _ratingRange = values;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Apply filters
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Filters applied: Price \$${_priceRange.start.toInt()}-\$${_priceRange.end.toInt()}, Rating ${_ratingRange.start.toStringAsFixed(1)}+',
                        ),
                      ),
                    );
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _priceRange = const RangeValues(0, 500);
                      _ratingRange = const RangeValues(1, 5);
                    });
                  },
                  child: const Text('Reset'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
