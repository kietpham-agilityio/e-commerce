import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_details_request_body.freezed.dart';
part 'product_details_request_body.g.dart';

@freezed
class ProductDetailsRequestBodyDto with _$ProductDetailsRequestBodyDto {
  factory ProductDetailsRequestBodyDto({
    @JsonKey(name: 'product_id') required String id,
  }) = _ProductDetailsRequestBodyDto;

  factory ProductDetailsRequestBodyDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsRequestBodyDtoFromJson(json);
}
