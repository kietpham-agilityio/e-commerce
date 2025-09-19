import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../label.dart';

/// Example page demonstrating the EcLabel widget usage
class EcLabelExample extends StatelessWidget {
  const EcLabelExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      appBar: EcAppBar(titleText: 'Label Examples'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Labels Section
            _buildSection(
              title: 'Basic Labels',
              children: [
                const EcLabel(text: '-20%', style: EcLabelStyle.primary),
                const SizedBox(height: 16),
                const EcLabel(text: 'NEW', style: EcLabelStyle.secondary),
                const SizedBox(height: 16),
                const EcLabel(text: 'HOT', style: EcLabelStyle.primary),
                const SizedBox(height: 16),
                const EcLabel(text: 'SALE', style: EcLabelStyle.secondary),
              ],
            ),

            const SizedBox(height: 32),

            // Custom Styling Section
            _buildSection(
              title: 'Custom Styling',
              children: [
                const EcLabel(
                  text: 'Custom Size',
                  style: EcLabelStyle.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 16),
                const EcLabel(
                  text: 'Custom Padding',
                  style: EcLabelStyle.secondary,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                const SizedBox(height: 16),
                const EcLabel(
                  text: 'Custom Radius',
                  style: EcLabelStyle.primary,
                  borderRadius: 15,
                ),
                const SizedBox(height: 16),
                const EcLabel(
                  text: 'Custom Colors',
                  style: EcLabelStyle.primary,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Label Rows Section
            _buildSection(
              title: 'Label Rows',
              children: [
                const EcLabelRow(
                  labels: [
                    EcLabel(text: '-20%', style: EcLabelStyle.primary),
                    EcLabel(text: 'NEW', style: EcLabelStyle.secondary),
                    EcLabel(text: 'HOT', style: EcLabelStyle.primary),
                  ],
                ),
                const SizedBox(height: 16),
                const EcLabelRow(
                  labels: [
                    EcLabel(text: 'SALE', style: EcLabelStyle.secondary),
                    EcLabel(text: 'LIMITED', style: EcLabelStyle.primary),
                  ],
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Label Wrap Section
            _buildSection(
              title: 'Label Wrap',
              children: [
                const EcLabelWrap(
                  labels: [
                    EcLabel(text: '-20%', style: EcLabelStyle.primary),
                    EcLabel(text: 'NEW', style: EcLabelStyle.secondary),
                    EcLabel(text: 'HOT', style: EcLabelStyle.primary),
                    EcLabel(text: 'SALE', style: EcLabelStyle.secondary),
                    EcLabel(text: 'LIMITED', style: EcLabelStyle.primary),
                    EcLabel(text: 'EXCLUSIVE', style: EcLabelStyle.secondary),
                  ],
                  horizontalSpacing: 8,
                  verticalSpacing: 8,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Product Card Example
            _buildSection(
              title: 'Product Card Example',
              children: [_buildProductCard()],
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

  Widget _buildProductCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image placeholder with labels
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Text(
                      'Product Image',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                  // Labels positioned on the image
                  Positioned(
                    top: 8,
                    left: 8,
                    child: const EcLabel(
                      text: '-20%',
                      style: EcLabelStyle.primary,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: const EcLabel(
                      text: 'NEW',
                      style: EcLabelStyle.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Sample Product',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is a sample product description that shows how labels can be used in a product card.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  '\$99.99',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  '\$124.99',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                const EcLabel(text: 'HOT', style: EcLabelStyle.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
