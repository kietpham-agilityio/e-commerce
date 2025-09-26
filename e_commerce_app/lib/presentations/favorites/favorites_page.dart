import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: EcAppBar(title: EcHeadlineSmallText('Favorites')));
  }
}
