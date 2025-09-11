import 'models/models.dart';

abstract class AbstractProductsRepository {
  Future<List<Product>> getProductsList();
  Future<Product> getProduct(String id);
  Future<Favorite> addToFavorites(String id);
  Future<CartItem> addToCart(String id);
}
