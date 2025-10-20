import 'package:e_commerce_app/domain/entities/category_entity.dart';
import 'package:e_commerce_app/domain/repositories/shop_repository.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/services/ec_local_store/boxes/user_session_box.dart';

class ShopRepositoryImpl extends ShopRepository {
  ShopRepositoryImpl({
    required ApiClient apiClient,
    required UserSessionBox userSessionBox,
  }) : _apiClient = apiClient,
       _userSessionBox = userSessionBox;

  final ApiClient _apiClient;
  final UserSessionBox _userSessionBox;

  @override
  Future<List<EcCategoryEntity>> fetchShopCategories() async {
    try {
      final response = await _apiClient.productApi.getCategories();

      final result =
          response
              .asMap()
              .entries
              .map((entry) => entry.value.toEcCategoryEntity())
              .toList();

      return result;
    } catch (e) {
      throw Failure('Failed to fetch categories');
    }
  }
}
