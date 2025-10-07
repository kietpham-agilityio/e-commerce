import 'package:flutter/material.dart';
import '../textfield/dropdown.dart';
import '../../app_colors.dart';
import '../app_bar.dart';
import '../text.dart';

/// Example page showcasing EcDropdown widget usage
class EcDropdownExample extends StatefulWidget {
  const EcDropdownExample({super.key});

  @override
  State<EcDropdownExample> createState() => _EcDropdownExampleState();
}

class _EcDropdownExampleState extends State<EcDropdownExample> {
  String? selectedCountry;
  String? selectedCity;
  String? selectedCategory;
  String? countryError;
  String? categoryError;

  final List<EcDropdownItem<String>> countries = [
    EcDropdownItem(value: 'us', label: 'United States', icon: Icons.flag),
    EcDropdownItem(value: 'ca', label: 'Canada', icon: Icons.flag),
    EcDropdownItem(value: 'mx', label: 'Mexico', icon: Icons.flag),
    EcDropdownItem(value: 'uk', label: 'United Kingdom', icon: Icons.flag),
    EcDropdownItem(value: 'de', label: 'Germany', icon: Icons.flag),
    EcDropdownItem(value: 'fr', label: 'France', icon: Icons.flag),
    EcDropdownItem(value: 'jp', label: 'Japan', icon: Icons.flag),
    EcDropdownItem(value: 'au', label: 'Australia', icon: Icons.flag),
  ];

  final List<EcDropdownItem<String>> cities = [
    EcDropdownItem(
      value: 'nyc',
      label: 'New York',
      subtitle: 'United States',
      icon: Icons.location_city,
    ),
    EcDropdownItem(
      value: 'la',
      label: 'Los Angeles',
      subtitle: 'United States',
      icon: Icons.location_city,
    ),
    EcDropdownItem(
      value: 'toronto',
      label: 'Toronto',
      subtitle: 'Canada',
      icon: Icons.location_city,
    ),
    EcDropdownItem(
      value: 'london',
      label: 'London',
      subtitle: 'United Kingdom',
      icon: Icons.location_city,
    ),
    EcDropdownItem(
      value: 'tokyo',
      label: 'Tokyo',
      subtitle: 'Japan',
      icon: Icons.location_city,
    ),
  ];

  Future<List<EcDropdownItem<String>>> _fetchCategories() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    return [
      EcDropdownItem(
        value: 'electronics',
        label: 'Electronics',
        subtitle: '150 products',
        icon: Icons.phone_android,
      ),
      EcDropdownItem(
        value: 'clothing',
        label: 'Clothing',
        subtitle: '300 products',
        icon: Icons.checkroom,
      ),
      EcDropdownItem(
        value: 'books',
        label: 'Books',
        subtitle: '500 products',
        icon: Icons.book,
      ),
      EcDropdownItem(
        value: 'home',
        label: 'Home & Garden',
        subtitle: '200 products',
        icon: Icons.home,
      ),
      EcDropdownItem(
        value: 'sports',
        label: 'Sports & Outdoors',
        subtitle: '180 products',
        icon: Icons.sports_soccer,
      ),
    ];
  }

  void _validateForm() {
    setState(() {
      countryError = selectedCountry == null ? 'Please select a country' : null;
      categoryError =
          selectedCategory == null ? 'Please select a category' : null;
    });

    if (selectedCountry != null && selectedCategory != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: const EcAppBar(titleText: 'Dropdown Examples'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Dropdown
            EcHeadlineMediumText(
              '1. Basic Dropdown',
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            EcDropdown<String>(
              items: countries,
              label: 'Country',
              hintText: 'Select your country...',
              helperText: 'Choose your country of residence',
              required: true,
              errorText: countryError,
              selectedValue: selectedCountry,
              onSelected: (value) {
                setState(() {
                  selectedCountry = value;
                  countryError = null;
                });
              },
              themeType: ECThemeType.user,
            ),
            const SizedBox(height: 32),

            // Dropdown with Search
            EcHeadlineMediumText(
              '2. Dropdown with Search',
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            EcDropdown<String>(
              items: cities,
              label: 'City',
              hintText: 'Search cities...',
              helperText: 'Type to search for cities',
              enableSearch: true,
              searchHintText: 'Search...',
              selectedValue: selectedCity,
              onSelected: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
              onChanged: (query) {
                debugPrint('Searching: $query');
              },
              themeType: ECThemeType.user,
            ),
            const SizedBox(height: 32),

            // Async Dropdown
            EcHeadlineMediumText(
              '3. Async Data Fetching Dropdown',
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            EcDropdown<String>(
              items: const [],
              label: 'Product Category',
              hintText: 'Select category...',
              helperText: 'Categories will load when you tap',
              required: true,
              errorText: categoryError,
              enableSearch: true,
              onFetchItems: _fetchCategories,
              selectedValue: selectedCategory,
              onSelected: (value) {
                setState(() {
                  selectedCategory = value;
                  categoryError = null;
                });
              },
              themeType: ECThemeType.user,
            ),
            const SizedBox(height: 32),

            // Selected Values Display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcTitleMediumText(
                    'Selected Values:',
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  _buildSelectedValue('Country', selectedCountry),
                  _buildSelectedValue('City', selectedCity),
                  _buildSelectedValue('Category', selectedCategory),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _validateForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const EcLabelLargeText('Validate & Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedValue(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          EcBodyMediumText('$label: ', fontWeight: FontWeight.w600),
          EcBodyMediumText(
            value ?? 'Not selected',
            color: value != null ? Colors.green : Colors.grey,
          ),
        ],
      ),
    );
  }
}
