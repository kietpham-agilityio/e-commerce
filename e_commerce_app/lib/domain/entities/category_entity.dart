import 'package:ec_core/api_client/apis/dtos/product_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';
part 'category_entity.g.dart';

@freezed
class EcCategoryEntity with _$EcCategoryEntity {
  factory EcCategoryEntity({
    required int id,
    required String name,
    String? description,
    int? parentId,
  }) = _EcCategoryEntity;

  factory EcCategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$EcCategoryEntityFromJson(json);
}

extension CategoryDtoMapper on CategoryDto {
  EcCategoryEntity toEcCategoryEntity() {
    return EcCategoryEntity(
      id: id,
      name: name,
      description: description,
      parentId: parentId,
    );
  }
}
