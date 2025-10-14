import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_entities.dart';

part 'home_entities.freezed.dart';
// part 'home_entities.g.dart';

@freezed
class EcHomeEntities with _$EcHomeEntities {
  factory EcHomeEntities({
    @Default(<EcProduct>[]) List<EcProduct> newProducts,
    @Default(<EcProduct>[]) List<EcProduct> discountProducts,
  }) = _EcHomeEntities;

  // factory EcHomeEntities.fromJson(Map<String, dynamic> json) =>
  //     _$EcHomeEntitiesFromJson(json);

  factory EcHomeEntities.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return EcHomeEntities(
      newProducts:
          (data['new_products'] as List<dynamic>?)
              ?.map((e) => EcProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      discountProducts:
          (data['discount_products'] as List<dynamic>?)
              ?.map((e) => EcProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
