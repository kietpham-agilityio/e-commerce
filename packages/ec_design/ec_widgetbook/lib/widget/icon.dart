import 'package:ec_themes/themes/widgets/image.dart';
import 'package:ec_widgetbook/widgetbook_container.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookComponent iconsWidgetBooks() {
  return WidgetbookComponent(
    name: 'Icons',
    useCases: [
      WidgetbookUseCase(
        name: 'Icons',
        builder: (context) {
          final iconEntries = _allIconEntries();

          return ECUiWidgetbook(
            copyCode: '''
            ''',
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: iconEntries.length,
                itemBuilder: (context, index) {
                  final entry = iconEntries[index];
                  return _IconTile(name: entry.name, builder: entry.builder);
                },
              ),
            ),
          );
        },
      ),
    ],
  );
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.name, required this.builder});

  final String name;
  final Widget Function({Color? color, double? width, double? height}) builder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            child: builder(width: 32, height: 32),
          ),
        ),

        const SizedBox(height: 8),
        Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class _IconEntry {
  _IconEntry(this.name, this.builder);
  final String name;
  final Widget Function({Color? color, double? width, double? height}) builder;
}

List<_IconEntry> _allIconEntries() {
  return [
    _IconEntry('google', EcAssets.google),
    _IconEntry('facebook', EcAssets.facebook),
    // Navigation
    _IconEntry('Arrow Left', EcAssets.arrowLeft),
    _IconEntry('Arrow Right', EcAssets.arrowRight),
    _IconEntry('Arrow Right Filled', EcAssets.arrowRightFilled),
    // E-commerce
    _IconEntry('Shopping Bag', EcAssets.shoppingBag),
    _IconEntry('Shopping Bag Filled', EcAssets.shoppingBagFilled),
    _IconEntry('Shopping Bag Outlined', EcAssets.shoppingBagOutlined),
    _IconEntry('Shop', EcAssets.shop),
    _IconEntry('Shop Filled', EcAssets.shopFilled),
    _IconEntry('Shop Outlined', EcAssets.shopOutlined),
    // UI Controls
    _IconEntry('Close', EcAssets.close),
    _IconEntry('Plus', EcAssets.plus),
    _IconEntry('Filter', EcAssets.filter),
    _IconEntry('Search', EcAssets.search),
    _IconEntry('Three Dots', EcAssets.threeDots),
    _IconEntry('Swap', EcAssets.swap),
    _IconEntry('Sync', EcAssets.sync),
    // View Modes
    _IconEntry('Grid View', EcAssets.gridView),
    _IconEntry('List View', EcAssets.listView),
    // Action & State
    _IconEntry('Heart', EcAssets.heart),
    _IconEntry('Heart Filled', EcAssets.heartFilled),
    _IconEntry('Heart Outlined', EcAssets.heartOutlined),
    _IconEntry('Liked', EcAssets.liked),
    _IconEntry('Star', EcAssets.star),
    _IconEntry('Star Filled', EcAssets.starFilled),
    _IconEntry('Star Half', EcAssets.starHalf),
    _IconEntry('Star Outlined Big', EcAssets.starOutlinedBig),
    _IconEntry('Star Filled Big', EcAssets.starFilledBig),
    _IconEntry('Star Outlined', EcAssets.starOutlined),
    // Navigation & Location
    _IconEntry('Home', EcAssets.home),
    _IconEntry('Home Filled', EcAssets.homeFilled),
    _IconEntry('Home Outlined', EcAssets.homeOutlined),
    _IconEntry('Profile', EcAssets.profile),
    _IconEntry('Profile Filled', EcAssets.profileFilled),
    _IconEntry('Profile Outlined', EcAssets.profileOutlined),
    // Media & Camera
    _IconEntry('Photo Camera', EcAssets.photoCamera),
    _IconEntry('Flash Camera', EcAssets.flashCamera),
    // Social & Communication
    _IconEntry('Share Link', EcAssets.shareLink),
    // Help & Information
    _IconEntry('Help Outlined', EcAssets.helpOutlined),
    // Utility
    _IconEntry('Minor', EcAssets.minor),
    _IconEntry('Bag', EcAssets.bag),
  ];
}
