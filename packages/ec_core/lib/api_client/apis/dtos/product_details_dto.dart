import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_dto.dart';

part 'product_details_dto.freezed.dart';
part 'product_details_dto.g.dart';

@freezed
class ProductDetailsDto with _$ProductDetailsDto {
  factory ProductDetailsDto({
    required ProductDto product,
    @JsonKey(name: 'related_products')
    @Default(<ProductDto>[])
    List<ProductDto> relatedProduct,
  }) = _ProductDetailsDto;

  factory ProductDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsDtoFromJson(json);
}
