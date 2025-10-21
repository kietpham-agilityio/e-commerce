import 'package:freezed_annotation/freezed_annotation.dart';

part 'related_products_request_body.freezed.dart';
part 'related_products_request_body.g.dart';

@freezed
class RelatedProductsRequestBodyDto with _$RelatedProductsRequestBodyDto {
  factory RelatedProductsRequestBodyDto({
    @JsonKey(name: 'category_id_input') required String id,
  }) = _RelatedProductsRequestBodyDto;

  factory RelatedProductsRequestBodyDto.fromJson(Map<String, dynamic> json) =>
      _$RelatedProductsRequestBodyDtoFromJson(json);
}
