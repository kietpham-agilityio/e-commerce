import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dtos/order_dto.dart';
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
  Future<BaseResponseDto<OrderDto>> getOrderById(
    @Path('orderId') String orderId,
  );

  /// Create new order
  @POST('/orders')
  Future<BaseResponseDto<OrderDto>> createOrder(
    @Body() CreateOrderRequestDto request,
  );

  /// Cancel order
  @PUT('/orders/{orderId}/cancel')
  Future<BaseResponseDto<OrderDto>> cancelOrder(
    @Path('orderId') String orderId,
    @Body() Map<String, String>? reason,
  );

  /// Request order return
  @POST('/orders/{orderId}/return')
  Future<BaseResponseDto<Map<String, dynamic>>> requestReturn(
    @Path('orderId') String orderId,
    @Body() Map<String, dynamic> returnRequest,
  );

  /// Get order tracking information
  @GET('/orders/{orderId}/tracking')
  Future<BaseResponseDto<Map<String, dynamic>>> getOrderTracking(
    @Path('orderId') String orderId,
  );

  /// Download order invoice
  @GET('/orders/{orderId}/invoice')
  @DioResponseType(ResponseType.bytes)
  Future<Response<List<int>>> downloadOrderInvoice(
    @Path('orderId') String orderId,
  );

  /// Reorder items from previous order
  @POST('/orders/{orderId}/reorder')
  Future<BaseResponseDto<Map<String, dynamic>>> reorderItems(
    @Path('orderId') String orderId,
    @Body() Map<String, dynamic>? selectedItems,
  );

  /// Get order history
  @GET('/orders/{orderId}/history')
  Future<BaseResponseDto<List<OrderStatusHistoryDto>>> getOrderHistory(
    @Path('orderId') String orderId,
  );

  // ============================================================================
  // PAYMENT ENDPOINTS
  // ============================================================================

  /// Process payment for order
  @POST('/orders/{orderId}/payment')
  Future<BaseResponseDto<Map<String, dynamic>>> processPayment(
    @Path('orderId') String orderId,
    @Body() Map<String, dynamic> paymentData,
  );

  /// Get payment methods
  @GET('/payment/methods')
  Future<BaseResponseDto<List<Map<String, dynamic>>>> getPaymentMethods();

  /// Validate payment method
  @POST('/payment/validate')
  Future<BaseResponseDto<Map<String, dynamic>>> validatePaymentMethod(
    @Body() Map<String, dynamic> paymentData,
  );

  // ============================================================================
  // SHIPPING ENDPOINTS
  // ============================================================================

  /// Calculate shipping cost
  @POST('/shipping/calculate')
  Future<BaseResponseDto<Map<String, dynamic>>> calculateShipping(
    @Body() Map<String, dynamic> shippingRequest,
  );

  /// Get shipping methods
  @GET('/shipping/methods')
  Future<BaseResponseDto<List<Map<String, dynamic>>>> getShippingMethods(
    @Query('address') String? address,
  );

  /// Update shipping address for order
  @PUT('/orders/{orderId}/shipping-address')
  Future<BaseResponseDto<OrderDto>> updateShippingAddress(
    @Path('orderId') String orderId,
    @Body() Map<String, dynamic> address,
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
    @Path('orderId') String orderId,
    @Body() UpdateOrderStatusRequestDto request,
  );

  /// Update order details (Admin only)
  @PUT('/admin/orders/{orderId}')
  Future<BaseResponseDto<OrderDto>> updateOrder(
    @Path('orderId') String orderId,
    @Body() Map<String, dynamic> updates,
  );

  /// Add order note (Admin only)
  @POST('/admin/orders/{orderId}/notes')
  Future<BaseResponseDto<Map<String, dynamic>>> addOrderNote(
    @Path('orderId') String orderId,
    @Body() Map<String, String> note,
  );

  /// Get order analytics (Admin only)
  @GET('/admin/orders/analytics')
  Future<BaseResponseDto<Map<String, dynamic>>> getOrderAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('groupBy') String? groupBy,
  );

  /// Export orders (Admin only)
  @GET('/admin/orders/export')
  @DioResponseType(ResponseType.bytes)
  Future<Response<List<int>>> exportOrders(
    @Query('format') String format,
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
  );

  // ============================================================================
  // ADMIN PAYMENT MANAGEMENT ENDPOINTS
  // ============================================================================

  /// Refund order payment (Admin only)
  @POST('/admin/orders/{orderId}/refund')
  Future<BaseResponseDto<Map<String, dynamic>>> refundPayment(
    @Path('orderId') String orderId,
    @Body() Map<String, dynamic> refundData,
  );

  /// Get payment analytics (Admin only)
  @GET('/admin/payment/analytics')
  Future<BaseResponseDto<Map<String, dynamic>>> getPaymentAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('groupBy') String? groupBy,
  );
}
