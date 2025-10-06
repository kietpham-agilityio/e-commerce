import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dtos/cart_dto.dart';
import 'dtos/base_response.dart';

part 'cart_api.g.dart';

/// Cart API service interface using Retrofit
@RestApi()
abstract class CartApi {
  factory CartApi(Dio dio, {String? baseUrl}) = _CartApi;

  // ============================================================================
  // CART ENDPOINTS
  // ============================================================================

  /// Get current user's cart
  @GET('/carts')
  Future<BaseResponseDto<CartDto>> getCart();

  /// Update cart item quantity
  @PUT('/carts/items/{itemId}')
  Future<BaseResponseDto<CartDto>> updateCartItem(
    @Path('itemId') int itemId,
    @Body() UpdateCartItemRequestDto request,
  );

  /// Clear entire cart
  @DELETE('/carts')
  Future<SuccessResponseDto> clearCart();
}
