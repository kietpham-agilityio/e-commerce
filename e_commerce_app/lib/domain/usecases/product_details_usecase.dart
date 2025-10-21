import 'package:e_commerce_app/domain/entities/product_entities.dart';
import 'package:e_commerce_app/domain/repositories/product_details_repository.dart';

class ProductDetailsUseCase {
  const ProductDetailsUseCase({
    required ProductDetailsRepository productDetailsRepository,
  }) : _productDetailsRepository = productDetailsRepository;

  final ProductDetailsRepository _productDetailsRepository;

  Future<EcProductDetails> fetchProductDetails({
    required String productId,
    required String categoryId,
  }) async {
    return await _productDetailsRepository.fetchProductDetails(
      productId: productId,
      categoryId: categoryId,
    );
  }
}
