import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponseDto {
  const BaseResponseDto({
    this.status,
    this.isSuccess = false,
    this.message,
    this.statusCode = 0,
  });

  factory BaseResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseDtoFromJson(json);

  final String? status;
  final bool isSuccess;
  final String? message;
  final int statusCode;

  Map<String, dynamic> toJson() => _$BaseResponseDtoToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class BaseListResponseDto<T> {
  const BaseListResponseDto({
    this.data = const [],
    this.status,
    this.isSuccess = false,
    this.totalCount = 0,
    this.message,
  });

  factory BaseListResponseDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseListResponseDtoFromJson(json, fromJsonT);

  final List<T> data;
  final String? status;
  final bool isSuccess;
  final int totalCount;
  final String? message;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      _$BaseListResponseDtoToJson(this, toJsonT);
}

@JsonSerializable()
class BaseListStringResponseDto {
  const BaseListStringResponseDto({
    this.data = const [],
    this.status,
    this.isSuccess = false,
    this.totalCount = 0,
    this.message,
  });

  factory BaseListStringResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BaseListStringResponseDtoFromJson(json);

  final List<String> data;
  final String? status;
  final bool isSuccess;
  final int totalCount;
  final String? message;

  Map<String, dynamic> toJson() => _$BaseListStringResponseDtoToJson(this);
}
