import 'package:e_commerce_app/domain/entities/category_entity.dart';

abstract class ShopRepository {
  Future<List<EcCategoryEntity>> fetchShopCategories({
    bool isRefetched = false,
  });
}
