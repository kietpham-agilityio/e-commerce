import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_dto.freezed.dart';
part 'order_dto.g.dart';

/// Order Data Transfer Object
@freezed
class OrderDto with _$OrderDto {
  const factory OrderDto({
    required String id,
    required String userId,
    required String orderNumber,
    required OrderStatus status,
    required double subtotal,
    required double taxAmount,
    required double shippingAmount,
    required double discountAmount,
    required double totalAmount,
    required String currency,
    required OrderAddressDto shippingAddress,
    required OrderAddressDto billingAddress,
    required List<OrderItemDto> items,
    OrderPaymentDto? payment,
    OrderShippingDto? shipping,
    List<OrderStatusHistoryDto>? statusHistory,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _OrderDto;

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);
}

/// Order Item Data Transfer Object
@freezed
class OrderItemDto with _$OrderItemDto {
  const factory OrderItemDto({
    required String id,
    required String productId,
    required String productName,
    required String productSku,
    required String productImage,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    String? variantId,
    Map<String, String>? variantAttributes,
  }) = _OrderItemDto;

  factory OrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoFromJson(json);
}

/// Order Address Data Transfer Object
@freezed
class OrderAddressDto with _$OrderAddressDto {
  const factory OrderAddressDto({
    required String firstName,
    required String lastName,
    required String street,
    required String city,
    required String state,
    required String postalCode,
    required String country,
    String? apartment,
    String? phoneNumber,
  }) = _OrderAddressDto;

  factory OrderAddressDto.fromJson(Map<String, dynamic> json) =>
      _$OrderAddressDtoFromJson(json);
}

/// Order Payment Data Transfer Object
@freezed
class OrderPaymentDto with _$OrderPaymentDto {
  const factory OrderPaymentDto({
    required String id,
    required PaymentMethod paymentMethod,
    required PaymentStatus status,
    required double amount,
    required String currency,
    String? transactionId,
    String? gatewayResponse,
    DateTime? processedAt,
    DateTime? createdAt,
  }) = _OrderPaymentDto;

  factory OrderPaymentDto.fromJson(Map<String, dynamic> json) =>
      _$OrderPaymentDtoFromJson(json);
}

/// Order Shipping Data Transfer Object
@freezed
class OrderShippingDto with _$OrderShippingDto {
  const factory OrderShippingDto({
    required String id,
    required ShippingMethod method,
    required ShippingStatus status,
    required String carrier,
    String? trackingNumber,
    String? trackingUrl,
    DateTime? shippedAt,
    DateTime? deliveredAt,
    DateTime? estimatedDelivery,
  }) = _OrderShippingDto;

  factory OrderShippingDto.fromJson(Map<String, dynamic> json) =>
      _$OrderShippingDtoFromJson(json);
}

/// Order Status History Data Transfer Object
@freezed
class OrderStatusHistoryDto with _$OrderStatusHistoryDto {
  const factory OrderStatusHistoryDto({
    required OrderStatus status,
    required String comment,
    required DateTime timestamp,
    String? updatedBy,
  }) = _OrderStatusHistoryDto;

  factory OrderStatusHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusHistoryDtoFromJson(json);
}

/// Create Order Request DTO
@freezed
class CreateOrderRequestDto with _$CreateOrderRequestDto {
  const factory CreateOrderRequestDto({
    required OrderAddressDto shippingAddress,
    required OrderAddressDto billingAddress,
    required PaymentMethod paymentMethod,
    required ShippingMethod shippingMethod,
    String? notes,
    String? couponCode,
  }) = _CreateOrderRequestDto;

  factory CreateOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestDtoFromJson(json);
}

/// Update Order Status Request DTO
@freezed
class UpdateOrderStatusRequestDto with _$UpdateOrderStatusRequestDto {
  const factory UpdateOrderStatusRequestDto({
    required OrderStatus status,
    String? comment,
  }) = _UpdateOrderStatusRequestDto;

  factory UpdateOrderStatusRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderStatusRequestDtoFromJson(json);
}

/// Cancel Order Request DTO
@freezed
class CancelOrderRequestDto with _$CancelOrderRequestDto {
  const factory CancelOrderRequestDto({required String reason, String? note}) =
      _CancelOrderRequestDto;

  factory CancelOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CancelOrderRequestDtoFromJson(json);
}

/// Return Order Request DTO
@freezed
class ReturnOrderRequestDto with _$ReturnOrderRequestDto {
  const factory ReturnOrderRequestDto({
    required String reason,
    required List<String> itemIds,
    String? note,
    List<String>? attachments,
  }) = _ReturnOrderRequestDto;

  factory ReturnOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ReturnOrderRequestDtoFromJson(json);
}

/// Reorder Items Request DTO
@freezed
class ReorderItemsRequestDto with _$ReorderItemsRequestDto {
  const factory ReorderItemsRequestDto({
    required List<String> selectedItemIds,
    String? note,
  }) = _ReorderItemsRequestDto;

  factory ReorderItemsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ReorderItemsRequestDtoFromJson(json);
}

/// Payment Request DTO
@freezed
class PaymentRequestDto with _$PaymentRequestDto {
  const factory PaymentRequestDto({
    required String paymentMethodId,
    required PaymentMethod paymentMethod,
    Map<String, dynamic>? paymentDetails,
    String? billingAddressId,
  }) = _PaymentRequestDto;

  factory PaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentRequestDtoFromJson(json);
}

/// Payment Validation Request DTO
@freezed
class PaymentValidationRequestDto with _$PaymentValidationRequestDto {
  const factory PaymentValidationRequestDto({
    required String paymentMethodId,
    required PaymentMethod paymentMethod,
    Map<String, dynamic>? paymentDetails,
  }) = _PaymentValidationRequestDto;

  factory PaymentValidationRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentValidationRequestDtoFromJson(json);
}

/// Shipping Calculation Request DTO
@freezed
class ShippingCalculationRequestDto with _$ShippingCalculationRequestDto {
  const factory ShippingCalculationRequestDto({
    required OrderAddressDto destination,
    required List<ShippingItemDto> items,
    String? preferredCarrier,
  }) = _ShippingCalculationRequestDto;

  factory ShippingCalculationRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingCalculationRequestDtoFromJson(json);
}

/// Shipping Item DTO for calculation
@freezed
class ShippingItemDto with _$ShippingItemDto {
  const factory ShippingItemDto({
    required String productId,
    required int quantity,
    required double weight,
    required double length,
    required double width,
    required double height,
  }) = _ShippingItemDto;

  factory ShippingItemDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingItemDtoFromJson(json);
}

/// Update Shipping Address Request DTO
@freezed
class UpdateShippingAddressRequestDto with _$UpdateShippingAddressRequestDto {
  const factory UpdateShippingAddressRequestDto({
    required OrderAddressDto address,
  }) = _UpdateShippingAddressRequestDto;

  factory UpdateShippingAddressRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateShippingAddressRequestDtoFromJson(json);
}

/// Update Order Request DTO
@freezed
class UpdateOrderRequestDto with _$UpdateOrderRequestDto {
  const factory UpdateOrderRequestDto({
    String? status,
    double? discountAmount,
    String? notes,
    OrderAddressDto? shippingAddress,
    OrderAddressDto? billingAddress,
  }) = _UpdateOrderRequestDto;

  factory UpdateOrderRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderRequestDtoFromJson(json);
}

/// Add Order Note Request DTO
@freezed
class AddOrderNoteRequestDto with _$AddOrderNoteRequestDto {
  const factory AddOrderNoteRequestDto({required String note, String? author}) =
      _AddOrderNoteRequestDto;

  factory AddOrderNoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddOrderNoteRequestDtoFromJson(json);
}

/// Refund Payment Request DTO
@freezed
class RefundPaymentRequestDto with _$RefundPaymentRequestDto {
  const factory RefundPaymentRequestDto({
    required double amount,
    required String reason,
    String? note,
  }) = _RefundPaymentRequestDto;

  factory RefundPaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RefundPaymentRequestDtoFromJson(json);
}

/// Order Status Enum
enum OrderStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('processing')
  processing,
  @JsonValue('shipped')
  shipped,
  @JsonValue('delivered')
  delivered,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('refunded')
  refunded,
}

/// Payment Method Enum
enum PaymentMethod {
  @JsonValue('credit_card')
  creditCard,
  @JsonValue('debit_card')
  debitCard,
  @JsonValue('paypal')
  paypal,
  @JsonValue('bank_transfer')
  bankTransfer,
  @JsonValue('cash_on_delivery')
  cashOnDelivery,
}

/// Payment Status Enum
enum PaymentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('refunded')
  refunded,
}

/// Shipping Method Enum
enum ShippingMethod {
  @JsonValue('standard')
  standard,
  @JsonValue('express')
  express,
  @JsonValue('overnight')
  overnight,
  @JsonValue('pickup')
  pickup,
}

/// Shipping Status Enum
enum ShippingStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('shipped')
  shipped,
  @JsonValue('in_transit')
  inTransit,
  @JsonValue('delivered')
  delivered,
  @JsonValue('failed')
  failed,
}
