import 'package:e_commerce_app/domain/entities/product_entities.dart';

abstract class ProductDetailsRepository {
  Future<EcProductDetails> fetchProductDetails(int id);
}
