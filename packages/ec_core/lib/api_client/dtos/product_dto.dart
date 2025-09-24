import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_dto.freezed.dart';
part 'product_dto.g.dart';

/// Product Data Transfer Object
@freezed
class ProductDto with _$ProductDto {
  const factory ProductDto({
    required String id,
    required String name,
    required String description,
    required double price,
    required String currency,
    required String categoryId,
    required String brandId,
    required int stockQuantity,
    required bool isActive,
    required double rating,
    required int reviewCount,
    List<String>? images,
    List<ProductVariantDto>? variants,
    List<ProductAttributeDto>? attributes,
    ProductShippingDto? shipping,
    ProductSeoDto? seo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProductDto;

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);
}

/// Product Variant Data Transfer Object
@freezed
class ProductVariantDto with _$ProductVariantDto {
  const factory ProductVariantDto({
    required String id,
    required String productId,
    required String name,
    required String sku,
    required double price,
    required int stockQuantity,
    required bool isActive,
    Map<String, String>? attributes, // e.g., {"color": "red", "size": "M"}
    List<String>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProductVariantDto;

  factory ProductVariantDto.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantDtoFromJson(json);
}

/// Product Attribute Data Transfer Object
@freezed
class ProductAttributeDto with _$ProductAttributeDto {
  const factory ProductAttributeDto({
    required String name,
    required String value,
    String? unit,
  }) = _ProductAttributeDto;

  factory ProductAttributeDto.fromJson(Map<String, dynamic> json) =>
      _$ProductAttributeDtoFromJson(json);
}

/// Product Shipping Data Transfer Object
@freezed
class ProductShippingDto with _$ProductShippingDto {
  const factory ProductShippingDto({
    required double weight,
    required String weightUnit,
    required double length,
    required double width,
    required double height,
    required String dimensionUnit,
    required bool isFreeShipping,
    double? shippingCost,
    int? estimatedDays,
  }) = _ProductShippingDto;

  factory ProductShippingDto.fromJson(Map<String, dynamic> json) =>
      _$ProductShippingDtoFromJson(json);
}

/// Product SEO Data Transfer Object
@freezed
class ProductSeoDto with _$ProductSeoDto {
  const factory ProductSeoDto({
    String? metaTitle,
    String? metaDescription,
    String? metaKeywords,
    String? slug,
  }) = _ProductSeoDto;

  factory ProductSeoDto.fromJson(Map<String, dynamic> json) =>
      _$ProductSeoDtoFromJson(json);
}

/// Category Data Transfer Object
@freezed
class CategoryDto with _$CategoryDto {
  const factory CategoryDto({
    required String id,
    required String name,
    required String description,
    String? parentId,
    String? image,
    required int sortOrder,
    required bool isActive,
    List<CategoryDto>? children,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CategoryDto;

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);
}

/// Brand Data Transfer Object
@freezed
class BrandDto with _$BrandDto {
  const factory BrandDto({
    required String id,
    required String name,
    required String description,
    String? logo,
    String? website,
    required bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BrandDto;

  factory BrandDto.fromJson(Map<String, dynamic> json) =>
      _$BrandDtoFromJson(json);
}

/// Product Search Request DTO
@freezed
class ProductSearchRequestDto with _$ProductSearchRequestDto {
  const factory ProductSearchRequestDto({
    String? query,
    String? categoryId,
    String? brandId,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    List<String>? attributes,
    String? sortBy,
    String? sortOrder,
    int? page,
    int? limit,
  }) = _ProductSearchRequestDto;

  factory ProductSearchRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchRequestDtoFromJson(json);
}

/// Product Search Response DTO
@freezed
class ProductSearchResponseDto with _$ProductSearchResponseDto {
  const factory ProductSearchResponseDto({
    required List<ProductDto> products,
    required int totalCount,
    required int currentPage,
    required int totalPages,
    required int limit,
  }) = _ProductSearchResponseDto;

  factory ProductSearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchResponseDtoFromJson(json);
}
