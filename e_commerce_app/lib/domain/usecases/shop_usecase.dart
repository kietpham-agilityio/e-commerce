import 'package:e_commerce_app/domain/entities/category_entity.dart';
import 'package:e_commerce_app/domain/repositories/shop_repository.dart';

class ShopUseCase {
  const ShopUseCase({required ShopRepository shopRepository})
    : _shopRepository = shopRepository;

  final ShopRepository _shopRepository;

  Future<List<EcCategoryEntity>> fetchShopCategories({
    bool isRefetched = false,
  }) async {
    return await _shopRepository.fetchShopCategories(isRefetched: isRefetched);
  }
}
