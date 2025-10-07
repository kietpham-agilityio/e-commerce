import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dtos/discount_dto.dart';
import 'dtos/base_response.dart';

part 'discount_api.g.dart';

/// Discount API service interface using Retrofit
@RestApi()
abstract class DiscountApi {
  factory DiscountApi(Dio dio, {String? baseUrl}) = _DiscountApi;

  // ============================================================================
  // DISCOUNT ENDPOINTS
  // ============================================================================

  /// Get all discounts
  @GET('/discounts')
  Future<BaseResponseDto<List<DiscountDto>>> getDiscounts(
    @Query('active') bool? active,
    @Query('valid') bool? valid,
  );
}
