import 'package:dio/dio.dart';
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
      final baseUrl = 'https://ljicqrmblcyidcyqecdf.supabase.co';

      final dio = Dio();
      // dio.options.baseUrl = baseUrl;
      dio.options = BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'apikey':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxqaWNxcm1ibGN5aWRjeXFlY2RmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg4NzYzNjgsImV4cCI6MjA3NDQ1MjM2OH0.QPVhCPTL0qyRQDXAWC_yc168MCgweYpPNw5OoQuMVvg',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxqaWNxcm1ibGN5aWRjeXFlY2RmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg4NzYzNjgsImV4cCI6MjA3NDQ1MjM2OH0.QPVhCPTL0qyRQDXAWC_yc168MCgweYpPNw5OoQuMVvg',
        },
      );

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
