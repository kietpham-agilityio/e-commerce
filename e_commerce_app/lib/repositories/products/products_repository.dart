import 'package:dio/dio.dart';
import 'models/models.dart';
import 'abstract_products_repository.dart';

const _mockProducts = [
  Product(
    id: '1',
    name: 'Nike Air Plus',
    type: 'Running shoes',
    price: 299,
    image: 'assets/air_max_plus.png',
  ),
  Product(
    id: '2',
    name: 'Nike Air White',
    type: 'Running shoes',
    price: 299,
    image: 'assets/air_max_plus_white.png',
  ),
  Product(
    id: '3',
    name: 'Dark shoes',
    type: 'Walking shoes',
    price: 449,
    image: 'assets/black.png',
  ),
  Product(
    id: '4',
    name: 'Blue shoes',
    type: 'Running shoes',
    price: 300,
    image: 'assets/blue_shoe.png',
  ),
  Product(
    id: '5',
    name: 'Red shoes',
    type: 'Walking shoes',
    price: 300,
    image: 'assets/red_shoe.png',
  ),
];

// Mock data for favorites
final _mockFavorites = [
  Favorite(
    productId: '1',
    userId: 'user123',
    addedAt: DateTime.parse('2024-01-15T10:30:00Z'),
  ),
  Favorite(
    productId: '3',
    userId: 'user123',
    addedAt: DateTime.parse('2024-01-16T14:20:00Z'),
  ),
];

// Mock data for cart items
final _mockCartItems = [
  CartItem(
    productId: '1',
    userId: 'user123',
    quantity: 2,
    addedAt: DateTime.parse('2024-01-15T10:30:00Z'),
  ),
  CartItem(
    productId: '2',
    userId: 'user123',
    quantity: 1,
    addedAt: DateTime.parse('2024-01-16T14:20:00Z'),
  ),
  CartItem(
    productId: '4',
    userId: 'user123',
    quantity: 3,
    addedAt: DateTime.parse('2024-01-17T09:15:00Z'),
  ),
];

/// [_requestsCount > 1] - special mock logic
/// to check how logs working in differend ways of logic
class ProductsRepository implements AbstractProductsRepository {
  ProductsRepository({required Dio dio}) : _dio = dio;
  var _requestsCount = 0;

  final Dio _dio;

  @override
  Future<List<Product>> getProductsList() async {
    _requestsCount += 1;
    if (_requestsCount % 2 != 0) {
      await _dio.get('https://jsonplaceholder.typicode.com/users/1');
      // Mock successful products list retrieval
      return _mockProducts;
    }

    /// Incorrect http request path
    // await _dio.get('https://jsonplaceholder.typicode.com/usetyrtyergvf/1');
    // Mock successful products list retrieval even on "incorrect" request
    return _mockProducts;
  }

  @override
  Future<Product> getProduct(String id) async {
    await _dio.get('https://jsonplaceholder.typicode.com/users/1');
    // Mock product retrieval with additional data
    final product = _mockProducts.firstWhere((e) => e.id == id);
    return product;
  }

  @override
  Future<Favorite> addToFavorites(String id) async {
    _requestsCount += 1;
    if (_requestsCount % 2 != 0) {
      await _dio.put('https://jsonplaceholder.typicode.com/users/1');
      // Mock successful favorite addition
      final favorite = _mockFavorites.first.copyWith(productId: id);
      return favorite;
    }

    /// Incorrect request
    // await _dio.put('https://jsonplaceholder.typicode.com/invalid-endpoint/1');
    // Return mock favorite even on "incorrect" request
    final favorite = _mockFavorites.last.copyWith(productId: id);
    return favorite;
  }

  @override
  Future<CartItem> addToCart(String id) async {
    _requestsCount += 1;
    if (_requestsCount % 2 != 0) {
      await _dio.post('https://jsonplaceholder.typicode.com/users/1');
      // Mock successful cart addition
      final cartItem = _mockCartItems.first.copyWith(productId: id);

      return cartItem;
    }

    /// Incorrect request
    await _dio.post('https://jsonplaceholder.typicode.com/posts');
    // Mock successful cart addition even on "incorrect" request
    final cartItem = _mockCartItems.last.copyWith(productId: id);

    return cartItem;
  }
}
