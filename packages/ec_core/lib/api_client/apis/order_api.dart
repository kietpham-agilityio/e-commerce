import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dtos/order_dto.dart';
import 'dtos/base_response.dart';

part 'order_api.g.dart';

/// Order API service interface using Retrofit
@RestApi()
abstract class OrderApi {
  factory OrderApi(Dio dio, {String? baseUrl}) = _OrderApi;

  // ============================================================================
  // ORDER ENDPOINTS
  // ============================================================================

  /// Get user's orders
  @GET('/orders')
  Future<PaginatedResponseDto<OrderDto>> getOrders(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('status') String? status,
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );

  /// Get order by ID
  @GET('/orders/{orderId}')
  Future<BaseResponseDto<OrderDto>> getOrderById(@Path('orderId') int orderId);

  /// Create new order
  @POST('/orders')
  Future<BaseResponseDto<OrderDto>> createOrder(
    @Body() CreateOrderRequestDto request,
  );

  /// Cancel order
  @PUT('/orders/{orderId}/cancel')
  Future<BaseResponseDto<OrderDto>> cancelOrder(
    @Path('orderId') int orderId,
    @Body() CancelOrderRequestDto request,
  );

  /// Request order return
  @POST('/orders/{orderId}/return')
  Future<BaseResponseDto<OrderDto>> requestReturn(
    @Path('orderId') int orderId,
    @Body() ReturnOrderRequestDto request,
  );

  // ============================================================================
  // PAYMENT ENDPOINTS
  // ============================================================================

  /// Process payment for order
  @POST('/orders/{orderId}/payment')
  Future<BaseResponseDto<OrderDto>> processPayment(
    @Path('orderId') int orderId,
    @Body() PaymentRequestDto request,
  );

  /// Get payment methods
  @GET('/payment/methods')
  Future<BaseResponseDto<List<OrderPaymentDto>>> getPaymentMethods();
}
