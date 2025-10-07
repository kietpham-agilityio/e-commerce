import 'package:freezed_annotation/freezed_annotation.dart';
import '../../enums/supabase_enums.dart';
import 'shipping_address_dto.dart';

part 'order_dto.freezed.dart';
part 'order_dto.g.dart';

/// Order Data Transfer Object - matches Supabase orders table
@freezed
class OrderDto with _$OrderDto {
  const factory OrderDto({
    required int id,
    required String? userId, // UUID from Supabase auth
    required OrderStatus orderStatus, // order_status enum from Supabase
    required PaymentStatus paymentStatus, // payment_status enum from Supabase
    required double totalAmount, // numeric from Supabase
    required int? shippingAddressId, // References shipping_addresses.id
    DateTime? createdAt, // timestamptz from Supabase
    // Additional fields for UI display (computed from joins)
    required List<OrderItemDto> items,
    OrderPaymentDto? payment,
    OrderShipmentDto? shipment,
    ShippingAddressDto? shippingAddress,
    String? orderNumber,
    double? subtotal,
    double? taxAmount,
    double? shippingAmount,
    double? discountAmount,
  }) = _OrderDto;

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);
}

/// Order Item Data Transfer Object - matches Supabase order_items table
@freezed
class OrderItemDto with _$OrderItemDto {
  const factory OrderItemDto({
    required int id,
    required int? orderId, // References orders.id
    required int? productVariantId, // References product_variants.id
    required double price, // numeric from Supabase
    required int quantity, // integer from Supabase
    // Additional fields for UI display (computed from joins)
    String? productName,
    String? productSku,
    String? productImage,
    double? unitPrice,
    double? totalPrice,
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

/// Order Payment Data Transfer Object - matches Supabase payments table
@freezed
class OrderPaymentDto with _$OrderPaymentDto {
  const factory OrderPaymentDto({
    required int id,
    required int? orderId, // References orders.id
    required PaymentMethod method, // payment_method enum from Supabase
    required double amount, // numeric from Supabase
    required PaymentStatus status, // payment_status enum from Supabase
    String? transactionId, // text from Supabase
    DateTime? createdAt, // timestamptz from Supabase
    // Additional fields for UI display
    String? gatewayResponse,
    DateTime? processedAt,
  }) = _OrderPaymentDto;

  factory OrderPaymentDto.fromJson(Map<String, dynamic> json) =>
      _$OrderPaymentDtoFromJson(json);
}

/// Order Shipment Data Transfer Object - matches Supabase shipments table
@freezed
class OrderShipmentDto with _$OrderShipmentDto {
  const factory OrderShipmentDto({
    required int id,
    required int? orderId, // References orders.id
    String? carrier, // text from Supabase
    String? trackingNumber, // text from Supabase
    required ShipmentStatus status, // shipment_status enum from Supabase
    DateTime? shippedAt, // timestamptz from Supabase
    // Additional fields for UI display
    String? trackingUrl,
    DateTime? deliveredAt,
    DateTime? estimatedDelivery,
  }) = _OrderShipmentDto;

  factory OrderShipmentDto.fromJson(Map<String, dynamic> json) =>
      _$OrderShipmentDtoFromJson(json);
}

/// Order Shipping Data Transfer Object (Legacy compatibility)
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
    required int shippingAddressId, // References shipping_addresses.id
    required PaymentMethod paymentMethod,
    required double totalAmount,
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

// Enums are now defined in ../enums/supabase_enums.dart
