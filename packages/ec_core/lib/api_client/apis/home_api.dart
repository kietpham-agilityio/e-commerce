import 'package:dio/dio.dart';
import 'package:ec_core/api_client/apis/dtos/home_dto.dart';
import 'package:retrofit/retrofit.dart';

import 'dtos/base_response.dart';

part 'home_api.g.dart';

/// Cart API service interface using Retrofit
@RestApi()
abstract class HomeApi {
  factory HomeApi(Dio dio, {String? baseUrl}) = _HomeApi;

  // ============================================================================
  // CART ENDPOINTS
  // ============================================================================

  /// Get current user's cart
  @GET('/rest/v1/rpc/get_home_products')
  // @GET('/rest/v1/products?id=eq.100')
  Future<BaseResponseDto<HomeDto>> getHome();
}
