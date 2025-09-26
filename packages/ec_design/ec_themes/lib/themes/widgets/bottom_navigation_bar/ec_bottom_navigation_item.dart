import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

class EcBottomNavigationItem {
  const EcBottomNavigationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

const ecBottomNavigationItem = [
  EcBottomNavigationItem(
    label: 'Home',
    icon: EcDesignIcons.icHomeOutlined,
    selectedIcon: EcDesignIcons.icHomeFilled,
  ),
  EcBottomNavigationItem(
    label: 'Shop',
    icon: EcDesignIcons.icShopOutlined,
    selectedIcon: EcDesignIcons.icShopFilled,
  ),
  EcBottomNavigationItem(
    label: 'Bag',
    icon: EcDesignIcons.icShoppingBagOutlined,
    selectedIcon: EcDesignIcons.icShoppingBagFilled,
  ),
  EcBottomNavigationItem(
    label: 'Favorites',
    icon: EcDesignIcons.icHeartOutlined,
    selectedIcon: EcDesignIcons.icHeartFilled,
  ),
  EcBottomNavigationItem(
    label: 'Profile',
    icon: EcDesignIcons.icProfileOutlined,
    selectedIcon: EcDesignIcons.icProfileFilled,
  ),
];
