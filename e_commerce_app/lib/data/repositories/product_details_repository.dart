import 'package:e_commerce_app/domain/entities/product_entities.dart';
import 'package:e_commerce_app/domain/repositories/product_details_repository.dart';
import 'package:ec_core/api_client/apis/dtos/product_details_request_body.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/services/ec_local_store/boxes/user_session_box.dart';

class ProductDetailsRepositoryImpl extends ProductDetailsRepository {
  ProductDetailsRepositoryImpl({
    required ApiClient apiClient,
    required UserSessionBox userSessionBox,
  }) : _apiClient = apiClient,
       _userSessionBox = userSessionBox;

  final ApiClient _apiClient;
  final UserSessionBox _userSessionBox;

  @override
  Future<EcProductDetails> fetchProductDetails(String id) async {
    try {
      final response = await _apiClient.productApi.getProductDetails(
        body: ProductDetailsRequestBodyDto(id: id),
      );

      final product = response.data.product.toEcProduct();
      final relatedProducts =
          response.data.relatedProduct
              .asMap()
              .entries
              .map((entry) => entry.value.toEcProduct())
              .toList();

      return EcProductDetails(
        product: product,
        relatedProducts: relatedProducts,
      );
    } catch (e) {
      throw Failure('Failed to fetch product details');
    }
  }
}
