import 'package:freezed_annotation/freezed_annotation.dart';

/// Order Status Enum - matches Supabase order_status type
enum OrderStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('shipped')
  shipped,
  @JsonValue('delivered')
  delivered,
  @JsonValue('cancelled')
  cancelled,
}

/// Payment Status Enum - matches Supabase payment_status type
enum PaymentStatus {
  @JsonValue('unpaid')
  unpaid,
  @JsonValue('pending')
  pending,
  @JsonValue('paid')
  paid,
  @JsonValue('failed')
  failed,
  @JsonValue('refunded')
  refunded,
}

/// Payment Method Enum - matches Supabase payment_method type
enum PaymentMethod {
  @JsonValue('credit_card')
  creditCard,
  @JsonValue('paypal')
  paypal,
  @JsonValue('bank_transfer')
  bankTransfer,
  @JsonValue('cod')
  cod,
}

/// Product Status Enum - matches Supabase product_status type
enum ProductStatus {
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
  @JsonValue('archived')
  archived,
}

/// User Role Enum - matches Supabase user_role type
enum UserRole {
  @JsonValue('admin')
  admin,
  @JsonValue('customer')
  customer,
}

/// Size Option Enum - matches Supabase size_option type
enum SizeOption {
  @JsonValue('XS')
  xs,
  @JsonValue('S')
  s,
  @JsonValue('M')
  m,
  @JsonValue('L')
  l,
  @JsonValue('XL')
  xl,
  @JsonValue('XXL')
  xxl,
  @JsonValue('35')
  size35,
  @JsonValue('36')
  size36,
  @JsonValue('37')
  size37,
  @JsonValue('38')
  size38,
  @JsonValue('39')
  size39,
  @JsonValue('40')
  size40,
  @JsonValue('41')
  size41,
  @JsonValue('42')
  size42,
  @JsonValue('43')
  size43,
  @JsonValue('44')
  size44,
  @JsonValue('45')
  size45,
  @JsonValue('46')
  size46,
  @JsonValue('One Size')
  oneSize,
}

/// Color Option Enum - matches Supabase color_option type
enum ColorOption {
  @JsonValue('red')
  red,
  @JsonValue('blue')
  blue,
  @JsonValue('green')
  green,
  @JsonValue('black')
  black,
  @JsonValue('white')
  white,
  @JsonValue('yellow')
  yellow,
  @JsonValue('pink')
  pink,
  @JsonValue('purple')
  purple,
  @JsonValue('gray')
  gray,
  @JsonValue('brown')
  brown,
  @JsonValue('navy')
  navy,
  @JsonValue('beige')
  beige,
  @JsonValue('burgundy')
  burgundy,
  @JsonValue('olive')
  olive,
  @JsonValue('tan')
  tan,
  @JsonValue('khaki')
  khaki,
  @JsonValue('gold')
  gold,
  @JsonValue('silver')
  silver,
  @JsonValue('cream')
  cream,
  @JsonValue('multicolor')
  multicolor,
}

/// Shipment Status Enum - matches Supabase shipment_status type
enum ShipmentStatus {
  @JsonValue('preparing')
  preparing,
  @JsonValue('shipped')
  shipped,
  @JsonValue('in_transit')
  inTransit,
  @JsonValue('delivered')
  delivered,
  @JsonValue('returned')
  returned,
  @JsonValue('canceled')
  canceled,
}

/// Shipping Method Enum - for shipping calculations
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

/// Shipping Status Enum - for shipping status tracking
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

/// Discount Type Enum - for discount calculations
enum DiscountType {
  @JsonValue('percentage')
  percentage,
  @JsonValue('fixed_amount')
  fixedAmount,
  @JsonValue('free_shipping')
  freeShipping,
  @JsonValue('buy_one_get_one')
  buyOneGetOne,
}

/// Review Rating Enum - for product reviews
enum ReviewRating {
  @JsonValue(1)
  one,
  @JsonValue(2)
  two,
  @JsonValue(3)
  three,
  @JsonValue(4)
  four,
  @JsonValue(5)
  five,
}

/// Wishlist Item Status Enum
enum WishlistItemStatus {
  @JsonValue('active')
  active,
  @JsonValue('removed')
  removed,
  @JsonValue('purchased')
  purchased,
}


