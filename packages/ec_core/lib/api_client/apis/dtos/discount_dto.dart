import 'package:freezed_annotation/freezed_annotation.dart';
import '../../enums/supabase_enums.dart';

part 'discount_dto.freezed.dart';
part 'discount_dto.g.dart';

/// Discount Data Transfer Object - matches Supabase discounts table
@freezed
class DiscountDto with _$DiscountDto {
  const factory DiscountDto({
    required int id,
    required String code,
    String? description,
    double? discountPercent, // numeric from Supabase
    double? discountAmount, // numeric from Supabase
    DateTime? validFrom, // timestamptz from Supabase
    DateTime? validTo, // timestamptz from Supabase
    int? usageLimit, // integer from Supabase
    DateTime? createdAt, // timestamptz from Supabase
  }) = _DiscountDto;

  factory DiscountDto.fromJson(Map<String, dynamic> json) =>
      _$DiscountDtoFromJson(json);
}

/// Create Discount Request DTO (Admin)
@freezed
class CreateDiscountRequestDto with _$CreateDiscountRequestDto {
  const factory CreateDiscountRequestDto({
    required String code,
    String? description,
    double? discountPercent,
    double? discountAmount,
    DateTime? validFrom,
    DateTime? validTo,
    int? usageLimit,
  }) = _CreateDiscountRequestDto;

  factory CreateDiscountRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateDiscountRequestDtoFromJson(json);
}

/// Update Discount Request DTO (Admin)
@freezed
class UpdateDiscountRequestDto with _$UpdateDiscountRequestDto {
  const factory UpdateDiscountRequestDto({
    String? code,
    String? description,
    double? discountPercent,
    double? discountAmount,
    DateTime? validFrom,
    DateTime? validTo,
    int? usageLimit,
  }) = _UpdateDiscountRequestDto;

  factory UpdateDiscountRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateDiscountRequestDtoFromJson(json);
}

/// Validate Discount Request DTO
@freezed
class ValidateDiscountRequestDto with _$ValidateDiscountRequestDto {
  const factory ValidateDiscountRequestDto({
    required String code,
    double? orderAmount,
    String? userId,
  }) = _ValidateDiscountRequestDto;

  factory ValidateDiscountRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ValidateDiscountRequestDtoFromJson(json);
}

/// Discount Validation Response DTO
@freezed
class DiscountValidationDto with _$DiscountValidationDto {
  const factory DiscountValidationDto({
    required bool isValid,
    required DiscountDto discount,
    required double discountAmount,
    String? errorMessage,
  }) = _DiscountValidationDto;

  factory DiscountValidationDto.fromJson(Map<String, dynamic> json) =>
      _$DiscountValidationDtoFromJson(json);
}
