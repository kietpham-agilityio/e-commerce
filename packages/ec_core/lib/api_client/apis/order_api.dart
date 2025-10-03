import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dtos/order_dto.dart';
import '../dtos/base_response.dart';

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

  /// Get order tracking information
  @GET('/orders/{orderId}/tracking')
  Future<BaseResponseDto<OrderDto>> getOrderTracking(
    @Path('orderId') int orderId,
  );

  /// Download order invoice
  @GET('/orders/{orderId}/invoice')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadOrderInvoice(@Path('orderId') int orderId);

  /// Reorder items from previous order
  @POST('/orders/{orderId}/reorder')
  Future<BaseResponseDto<OrderDto>> reorderItems(
    @Path('orderId') int orderId,
    @Body() ReorderItemsRequestDto request,
  );

  /// Get order history
  @GET('/orders/{orderId}/history')
  Future<BaseResponseDto<List<OrderStatusHistoryDto>>> getOrderHistory(
    @Path('orderId') int orderId,
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

  /// Validate payment method
  @POST('/payment/validate')
  Future<BaseResponseDto<OrderPaymentDto>> validatePaymentMethod(
    @Body() PaymentValidationRequestDto request,
  );

  // ============================================================================
  // SHIPPING ENDPOINTS
  // ============================================================================

  /// Update shipping address for order
  @PUT('/orders/{orderId}/shipping-address')
  Future<BaseResponseDto<OrderDto>> updateShippingAddress(
    @Path('orderId') int orderId,
    @Body() UpdateShippingAddressRequestDto request,
  );

  // ============================================================================
  // ADMIN ORDER MANAGEMENT ENDPOINTS
  // ============================================================================

  /// Get all orders (Admin only)
  @GET('/admin/orders')
  Future<PaginatedResponseDto<OrderDto>> getAllOrders(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('status') String? status,
    @Query('customerId') String? customerId,
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('sortBy') String? sortBy,
    @Query('sortOrder') String? sortOrder,
  );

  /// Update order status (Admin only)
  @PUT('/admin/orders/{orderId}/status')
  Future<BaseResponseDto<OrderDto>> updateOrderStatus(
    @Path('orderId') int orderId,
    @Body() UpdateOrderStatusRequestDto request,
  );

  /// Update order details (Admin only)
  @PUT('/admin/orders/{orderId}')
  Future<BaseResponseDto<OrderDto>> updateOrder(
    @Path('orderId') int orderId,
    @Body() UpdateOrderRequestDto request,
  );

  /// Add order note (Admin only)
  @POST('/admin/orders/{orderId}/notes')
  Future<BaseResponseDto<OrderDto>> addOrderNote(
    @Path('orderId') int orderId,
    @Body() AddOrderNoteRequestDto request,
  );

  /// Get order analytics (Admin only)
  @GET('/admin/orders/analytics')
  Future<BaseResponseDto<OrderDto>> getOrderAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('groupBy') String? groupBy,
  );

  /// Export orders (Admin only)
  @GET('/admin/orders/export')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> exportOrders(
    @Query('format') String format,
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );

  // ============================================================================
  // ADMIN PAYMENT MANAGEMENT ENDPOINTS
  // ============================================================================

  /// Refund order payment (Admin only)
  @POST('/admin/orders/{orderId}/refund')
  Future<BaseResponseDto<OrderPaymentDto>> refundPayment(
    @Path('orderId') int orderId,
    @Body() RefundPaymentRequestDto request,
  );

  /// Get payment analytics (Admin only)
  @GET('/admin/payment/analytics')
  Future<BaseResponseDto<OrderPaymentDto>> getPaymentAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('groupBy') String? groupBy,
  );
}
