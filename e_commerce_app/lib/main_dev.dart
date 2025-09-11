import 'setup.dart';
import 'ui/products_widget.dart';
import 'router.dart';
import 'repositories/products/abstract_products_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

void main() {
  // Initialize logger
  setupLogger();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ProductsPage(),
      routes: appRoutes,
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  void _showPresentationWidget() {
    Navigator.pushNamed(context, Routes.talker);
  }

  Future<void> _callGetProductsList() async {
    try {
      final repository = GetIt.instance<AbstractProductsRepository>();
      final products = await repository.getProductsList();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Loaded ${products.length} products')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading products: $e')));
      }
    }
  }

  Future<void> _callGetProduct() async {
    try {
      final repository = GetIt.instance<AbstractProductsRepository>();
      final product = await repository.getProduct('1');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Loaded product: ${product.name}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading product: $e')));
      }
    }
  }

  Future<void> _callAddToFavorites() async {
    try {
      final repository = GetIt.instance<AbstractProductsRepository>();
      final favorite = await repository.addToFavorites('1');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Added product ${favorite.productId} to favorites at ${favorite.addedAt}',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding to favorites: $e')),
        );
      }
    }
  }

  Future<void> _callAddToCart() async {
    try {
      final repository = GetIt.instance<AbstractProductsRepository>();
      final cartItem = await repository.addToCart('1');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Added product ${cartItem.productId} to cart (qty: ${cartItem.quantity})',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error adding to cart: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // API Test Buttons Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'API Test Buttons',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _callGetProductsList,
                      icon: const Icon(Icons.list),
                      label: const Text('Get Products List'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _callGetProduct,
                      icon: const Icon(Icons.shopping_bag),
                      label: const Text('Get Product'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _callAddToFavorites,
                      icon: const Icon(Icons.favorite),
                      label: const Text('Add to Favorites'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _callAddToCart,
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('Add to Cart'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Products Widget Section
          const Expanded(child: ProductsWidget()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPresentationWidget,
        tooltip: 'Show Debug View',
        child: const Icon(Icons.bug_report),
      ),
    );
  }
}
