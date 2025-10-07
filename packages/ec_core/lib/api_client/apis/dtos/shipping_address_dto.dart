import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipping_address_dto.freezed.dart';
part 'shipping_address_dto.g.dart';

/// Shipping Address Data Transfer Object - matches Supabase shipping_addresses table
@freezed
class ShippingAddressDto with _$ShippingAddressDto {
  const factory ShippingAddressDto({
    required int id,
    required String? userId, // UUID from Supabase auth
    required String recipientName, // text from Supabase
    required String addressLine1, // text from Supabase
    String? addressLine2, // text from Supabase (nullable)
    required String city, // text from Supabase
    String? postalCode, // text from Supabase (nullable)
    required String country, // text from Supabase
    String? phoneNumber, // text from Supabase (nullable)
  }) = _ShippingAddressDto;

  factory ShippingAddressDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressDtoFromJson(json);
}

/// Create Shipping Address Request DTO
@freezed
class CreateShippingAddressRequestDto with _$CreateShippingAddressRequestDto {
  const factory CreateShippingAddressRequestDto({
    required String recipientName,
    required String addressLine1,
    String? addressLine2,
    required String city,
    String? postalCode,
    required String country,
    String? phoneNumber,
  }) = _CreateShippingAddressRequestDto;

  factory CreateShippingAddressRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateShippingAddressRequestDtoFromJson(json);
}

/// Update Shipping Address Request DTO
@freezed
class UpdateShippingAddressRequestDto with _$UpdateShippingAddressRequestDto {
  const factory UpdateShippingAddressRequestDto({
    String? recipientName,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? postalCode,
    String? country,
    String? phoneNumber,
  }) = _UpdateShippingAddressRequestDto;

  factory UpdateShippingAddressRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateShippingAddressRequestDtoFromJson(json);
}

/// Address Validation Request DTO
@freezed
class AddressValidationRequestDto with _$AddressValidationRequestDto {
  const factory AddressValidationRequestDto({
    required String addressLine1,
    String? addressLine2,
    required String city,
    String? postalCode,
    required String country,
  }) = _AddressValidationRequestDto;

  factory AddressValidationRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddressValidationRequestDtoFromJson(json);
}

/// Address Validation Response DTO
@freezed
class AddressValidationResponseDto with _$AddressValidationResponseDto {
  const factory AddressValidationResponseDto({
    required bool isValid,
    required ShippingAddressDto? correctedAddress,
    required List<String> errors,
    required List<String> suggestions,
  }) = _AddressValidationResponseDto;

  factory AddressValidationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AddressValidationResponseDtoFromJson(json);
}

/// Shipping Address Analytics Response DTO
@freezed
class ShippingAddressAnalyticsDto with _$ShippingAddressAnalyticsDto {
  const factory ShippingAddressAnalyticsDto({
    required int totalAddresses,
    required int activeAddresses,
    required Map<String, int> addressesByCountry,
    required Map<String, int> addressesByCity,
    required double averageAddressesPerUser,
    required Map<String, int> monthlyGrowth,
  }) = _ShippingAddressAnalyticsDto;

  factory ShippingAddressAnalyticsDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressAnalyticsDtoFromJson(json);
}
