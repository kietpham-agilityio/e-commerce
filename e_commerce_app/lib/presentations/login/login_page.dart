import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSoldOut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EcAppBar(title: EcHeadlineSmallText('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Center(
              child: EcElevatedButton(
                text: 'Go to home',
                onPressed: () {
                  context.pushNamed(AppPaths.home.name);
                },
              ),
            ),
            EcProductCardInBag(
              title: 'Pullover',
              imageUrl:
                  'https://static.vecteezy.com/system/resources/thumbnails/057/068/323/small/single-fresh-red-strawberry-on-table-green-background-food-fruit-sweet-macro-juicy-plant-image-photo.jpg',
              isSoldOut: isSoldOut,
              color: 'Black',
              size: 'L',
              quantity: 1,
              price: 51,
            ),
            EcCardInGrid(
              url:
                  'https://static.vecteezy.com/system/resources/thumbnails/057/068/323/small/single-fresh-red-strawberry-on-table-green-background-food-fruit-sweet-macro-juicy-plant-image-photo.jpg',
              content: Text('content'),
              actions: [
                Positioned(
                  right: 0,
                  bottom: -19,
                  child: EcIconButton(icon: Icon(Icons.favorite)),
                ),
              ],
              isSoldOut: isSoldOut,
              onClose: () {},
            ),
            SizedBox(height: 100),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isSoldOut = !isSoldOut;
                  });
                },
                child: Text('Change state'),
              ),
            ),
            RatingStars(rating: 1.0, count: 120),
          ],
        ),
      ),
    );
  }
}

class RatingStars extends StatelessWidget {
  final double rating; // số sao trung bình (vd: 4.2)
  final int count; // số lượng người rating (vd: 120)

  const RatingStars({super.key, required this.rating, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Hiển thị 5 sao
        Row(
          children: List.generate(5, (index) {
            if (index < rating.floor()) {
              return const Icon(Icons.star, color: Colors.orange, size: 13);
            } else if (index < rating) {
              return const Icon(
                Icons.star_half,
                color: Colors.orange,
                size: 13,
              );
            } else {
              return const Icon(
                Icons.star_border,
                color: Colors.orange,
                size: 13,
              );
            }
          }),
        ),
        const SizedBox(width: 8),
        Text(
          "($count)",
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
