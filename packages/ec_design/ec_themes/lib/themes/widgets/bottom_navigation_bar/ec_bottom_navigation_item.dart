import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

class EcBottomNavigationItem {
  const EcBottomNavigationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

final ecBottomNavigationItem = [
  EcBottomNavigationItem(
    label: 'Home',
    icon: EcAssets.homeOutlined(),
    selectedIcon: EcAssets.homeFilled(),
  ),
  EcBottomNavigationItem(
    label: 'Shop',
    icon: EcAssets.shopOutlined(),
    selectedIcon: EcAssets.shopFilled(),
  ),
  EcBottomNavigationItem(
    label: 'Bag',
    icon: EcAssets.shoppingBagOutlined(),
    selectedIcon: EcAssets.shoppingBagFilled(),
  ),
  EcBottomNavigationItem(
    label: 'Favorites',
    icon: EcAssets.heartOutlined(),
    selectedIcon: EcAssets.heartFilled(),
  ),
  EcBottomNavigationItem(
    label: 'Profile',
    icon: EcAssets.profileOutlined(),
    selectedIcon: EcAssets.profileFilled(),
  ),
];
