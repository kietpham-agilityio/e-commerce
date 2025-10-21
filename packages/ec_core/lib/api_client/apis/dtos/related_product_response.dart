import 'package:ec_core/api_client/apis/dtos/product_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'related_product_response.freezed.dart';
part 'related_product_response.g.dart';

@freezed
class RelatedProductResponseDto with _$RelatedProductResponseDto {
  factory RelatedProductResponseDto({
    @JsonKey(name: 'related_products')
    @Default(<ProductDto>[])
    List<ProductDto> relatedProduct,
  }) = _RelatedProductResponseDto;

  factory RelatedProductResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RelatedProductResponseDtoFromJson(json);
}
