import 'package:e_commerce_app/domain/entities/product_entities.dart';
import 'package:e_commerce_app/domain/repositories/product_details_repository.dart';
import 'package:ec_core/api_client/apis/dtos/related_product_response.dart';
import 'package:ec_core/api_client/apis/dtos/related_products_request_body.dart';
import 'package:ec_core/ec_core.dart';

class ProductDetailsRepositoryImpl extends ProductDetailsRepository {
  ProductDetailsRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<EcProductDetails> fetchProductDetails({
    required String productId,
    required String categoryId,
  }) async {
    try {
      late List<ProductDto> resProduct;
      late BaseResponseDto<RelatedProductResponseDto> resRelatedProducts;

      await Future.wait<void>([
        (() async =>
            resProduct = await _apiClient.productApi.getProductById(
              'eq.$productId',
            ))(),
        (() async =>
            resRelatedProducts = await _apiClient.productApi.getRelatedProducts(
              body: RelatedProductsRequestBodyDto(id: categoryId),
            ))(),
      ]);

      final relatedProducts =
          resRelatedProducts.data.relatedProduct
              .asMap()
              .entries
              .map((entry) => entry.value.toEcProduct())
              .toList();

      return EcProductDetails(
        product: resProduct.first.toEcProduct(),
        relatedProducts: relatedProducts,
      );
    } catch (e) {
      throw Failure('Failed to fetch product details');
    }
  }
}
