import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_dto.dart';

part 'home_dto.freezed.dart';
part 'home_dto.g.dart';

@freezed
class HomeDto with _$HomeDto {
  factory HomeDto({
    @Default(<ProductDto>[])
    @ValueKey('new_products')
    List<ProductDto> newProducts,
    @Default(<ProductDto>[])
    @ValueKey('discount_products')
    List<ProductDto> discountProducts,
  }) = _HomeDto;

  factory HomeDto.fromJson(Map<String, dynamic> json) =>
      _$HomeDtoFromJson(json);
}
