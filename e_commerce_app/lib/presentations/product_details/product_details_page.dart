import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcAppBar(title: EcHeadlineSmallText('Product Details')),
      // body: SingleChildScrollView(
      //   child: Center(child: EcElevatedButton(text: 'Go to home')),
      // ),
    );
  }
}
