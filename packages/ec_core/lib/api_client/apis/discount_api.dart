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

  /// Get discount by code
  @GET('/discounts/code/{code}')
  Future<BaseResponseDto<DiscountDto>> getDiscountByCode(
    @Path('code') String code,
  );

  /// Validate discount code
  @POST('/discounts/validate')
  Future<BaseResponseDto<DiscountValidationDto>> validateDiscount(
    @Body() ValidateDiscountRequestDto request,
  );

  // ============================================================================
  // ADMIN DISCOUNT MANAGEMENT ENDPOINTS
  // ============================================================================

  /// Create new discount (Admin only)
  @POST('/admin/discounts')
  Future<BaseResponseDto<DiscountDto>> createDiscount(
    @Body() CreateDiscountRequestDto request,
  );

  /// Update discount (Admin only)
  @PUT('/admin/discounts/{discountId}')
  Future<BaseResponseDto<DiscountDto>> updateDiscount(
    @Path('discountId') int discountId,
    @Body() UpdateDiscountRequestDto request,
  );

  /// Delete discount (Admin only)
  @DELETE('/admin/discounts/{discountId}')
  Future<SuccessResponseDto> deleteDiscount(@Path('discountId') int discountId);

  /// Get discount analytics (Admin only)
  @GET('/admin/discounts/analytics')
  Future<BaseResponseDto<Map<String, dynamic>>> getDiscountAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );
}
