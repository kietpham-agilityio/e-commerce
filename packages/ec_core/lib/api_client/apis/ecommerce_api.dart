import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'cart_api.dart';
import 'order_api.dart';
import 'product_api.dart';
import 'user_api.dart';
import 'dtos/base_response.dart';
import '../dtos/ecommerce_dto.dart';
import '../dtos/cart_dto.dart';

part 'ecommerce_api.g.dart';

/// Main E-Commerce API client that combines all services
@RestApi()
abstract class EcommerceApi {
  factory EcommerceApi(Dio dio, {String? baseUrl}) = EcommerceApiImpl;

  // ============================================================================
  // TEST API ENDPOINTS
  // ============================================================================

  /// Get posts from test API
  @GET('/posts')
  Future<dynamic> getApis();

  /// Get comments from test API
  @GET('/comments')
  Future<dynamic> getComments(@Query('postId') int postId);
}

/// Concrete implementation of EcommerceApi
class EcommerceApiImpl extends _EcommerceApi {
  EcommerceApiImpl(super._dio, {super.baseUrl});

  // ============================================================================
  // API SERVICE GETTERS
  // ============================================================================

  /// Get User API service
  @override
  UserApi get userApi => UserApi(_dio, baseUrl: baseUrl);

  /// Get Product API service
  @override
  ProductApi get productApi => ProductApi(_dio, baseUrl: baseUrl);

  /// Get Cart API service
  @override
  CartApi get cartApi => CartApi(_dio, baseUrl: baseUrl);

  /// Get Order API service
  @override
  OrderApi get orderApi => OrderApi(_dio, baseUrl: baseUrl);
}
