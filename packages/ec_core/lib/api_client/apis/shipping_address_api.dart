import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dtos/shipping_address_dto.dart';
import 'dtos/base_response.dart';

part 'shipping_address_api.g.dart';

/// Shipping Address API service interface using Retrofit
@RestApi()
abstract class ShippingAddressApi {
  factory ShippingAddressApi(Dio dio, {String? baseUrl}) = _ShippingAddressApi;

  // ============================================================================
  // SHIPPING ADDRESS ENDPOINTS
  // ============================================================================

  /// Get user's shipping addresses
  @GET('/shipping-addresses')
  Future<BaseResponseDto<List<ShippingAddressDto>>> getShippingAddresses();

  /// Get shipping address by ID
  @GET('/shipping-addresses/{addressId}')
  Future<BaseResponseDto<ShippingAddressDto>> getShippingAddressById(
    @Path('addressId') int addressId,
  );

  /// Create new shipping address
  @POST('/shipping-addresses')
  Future<BaseResponseDto<ShippingAddressDto>> createShippingAddress(
    @Body() CreateShippingAddressRequestDto request,
  );

  /// Update shipping address
  @PUT('/shipping-addresses/{addressId}')
  Future<BaseResponseDto<ShippingAddressDto>> updateShippingAddress(
    @Path('addressId') int addressId,
    @Body() UpdateShippingAddressRequestDto request,
  );

  /// Delete shipping address
  @DELETE('/shipping-addresses/{addressId}')
  Future<SuccessResponseDto> deleteShippingAddress(
    @Path('addressId') int addressId,
  );

  /// Set default shipping address
  @PUT('/shipping-addresses/{addressId}/default')
  Future<BaseResponseDto<ShippingAddressDto>> setDefaultShippingAddress(
    @Path('addressId') int addressId,
  );

  /// Validate shipping address
  @POST('/shipping-addresses/validate')
  Future<BaseResponseDto<AddressValidationResponseDto>> validateAddress(
    @Body() AddressValidationRequestDto request,
  );

  // ============================================================================
  // ADMIN SHIPPING ADDRESS MANAGEMENT ENDPOINTS
  // ============================================================================

  /// Get all shipping addresses (Admin only)
  @GET('/admin/shipping-addresses')
  Future<BaseResponseDto<List<ShippingAddressDto>>> getAllShippingAddresses(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('userId') String? userId,
  );

  /// Get shipping address analytics (Admin only)
  @GET('/admin/shipping-addresses/analytics')
  Future<BaseResponseDto<ShippingAddressAnalyticsDto>>
  getShippingAddressAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );
}
