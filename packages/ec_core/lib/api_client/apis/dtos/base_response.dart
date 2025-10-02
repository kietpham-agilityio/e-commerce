import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

/// Generic Base Response DTO for API responses
@Freezed(genericArgumentFactories: true)
class BaseResponseDto<T> with _$BaseResponseDto<T> {
  const factory BaseResponseDto({
    required T data,
    @Default(true) bool success,
    String? message,
    String? error,
    Map<String, dynamic>? metadata,
  }) = _BaseResponseDto<T>;

  factory BaseResponseDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BaseResponseDtoFromJson(json, fromJsonT);
}

/// Paginated Response DTO for list endpoints
@Freezed(genericArgumentFactories: true)
class PaginatedResponseDto<T> with _$PaginatedResponseDto<T> {
  const factory PaginatedResponseDto({
    required List<T> data,
    @Default(true) bool success,
    String? message,
    String? error,
    required int totalCount,
    required int currentPage,
    required int totalPages,
    required int limit,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) = _PaginatedResponseDto<T>;

  factory PaginatedResponseDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedResponseDtoFromJson(json, fromJsonT);
}

/// Simple Success Response DTO
@freezed
class SuccessResponseDto with _$SuccessResponseDto {
  const factory SuccessResponseDto({
    @Default(true) bool success,
    String? message,
    Map<String, dynamic>? data,
  }) = _SuccessResponseDto;

  factory SuccessResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SuccessResponseDtoFromJson(json);
}

/// Error Response DTO
@freezed
class ErrorResponseDto with _$ErrorResponseDto {
  const factory ErrorResponseDto({
    @Default(false) bool success,
    required String message,
    String? error,
    String? code,
    Map<String, dynamic>? details,
  }) = _ErrorResponseDto;

  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseDtoFromJson(json);
}
