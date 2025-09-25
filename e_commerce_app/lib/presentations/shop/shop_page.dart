import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: EcAppBar(title: EcHeadlineSmallText('Shop')));
  }
}
