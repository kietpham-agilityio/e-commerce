import 'package:ec_core/api_client/apis/dtos/product_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entities.freezed.dart';
part 'product_entities.g.dart';

@freezed
class EcProduct with _$EcProduct {
  factory EcProduct({
    required int id,
    @Default('') String name,
    @Default('') String? description,
    @Default('') String brand,
    @Default(0.0) double price,
    @Default(0) int discount,
    @Default(0) int quantity,
    @Default(<String>[]) List<String> imageUrl,
    String? label,
  }) = _EcProduct;

  factory EcProduct.fromJson(Map<String, dynamic> json) =>
      _$EcProductFromJson(json);
}

extension ProductDtoMapper on ProductDto {
  EcProduct toEcProduct() {
    return EcProduct(
      id: id,
      name: name,
      description: description ?? '',
      brand: brand ?? '',
      price: price,
      discount: discount ?? 0,
      quantity: quantity,
      imageUrl: images ?? <String>[],
      label: label,
    );
  }
}
