import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

@freezed
abstract class BaseResponseDto with _$BaseResponseDto {
  factory BaseResponseDto({
    required List<String> data,
    @Default(0) int totalCount,
    @Default(true) bool isSuccess,
  }) = _BaseResponseDto;

  factory BaseResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseDtoFromJson(json);
}
