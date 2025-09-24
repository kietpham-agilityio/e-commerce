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

/// Product Review Request DTO
@freezed
class ProductReviewRequestDto with _$ProductReviewRequestDto {
  const factory ProductReviewRequestDto({
    required int rating,
    required String comment,
    String? title,
  }) = _ProductReviewRequestDto;

  factory ProductReviewRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewRequestDtoFromJson(json);
}

/// Create Product Request DTO (Admin)
@freezed
class CreateProductRequestDto with _$CreateProductRequestDto {
  const factory CreateProductRequestDto({
    required String name,
    required String description,
    required String categoryId,
    required String brandId,
    required double price,
    required int stock,
    required String sku,
    List<String>? images,
    List<ProductVariantDto>? variants,
    ProductShippingDto? shipping,
    ProductSeoDto? seo,
    Map<String, String>? attributes,
  }) = _CreateProductRequestDto;

  factory CreateProductRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateProductRequestDtoFromJson(json);
}

/// Update Product Request DTO (Admin)
@freezed
class UpdateProductRequestDto with _$UpdateProductRequestDto {
  const factory UpdateProductRequestDto({
    String? name,
    String? description,
    String? categoryId,
    String? brandId,
    double? price,
    int? stock,
    String? sku,
    List<String>? images,
    List<ProductVariantDto>? variants,
    ProductShippingDto? shipping,
    ProductSeoDto? seo,
    Map<String, String>? attributes,
    bool? isActive,
  }) = _UpdateProductRequestDto;

  factory UpdateProductRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductRequestDtoFromJson(json);
}

/// Update Product Stock Request DTO (Admin)
@freezed
class UpdateProductStockRequestDto with _$UpdateProductStockRequestDto {
  const factory UpdateProductStockRequestDto({
    required int stock,
    String? reason,
  }) = _UpdateProductStockRequestDto;

  factory UpdateProductStockRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductStockRequestDtoFromJson(json);
}

/// Bulk Update Products Request DTO (Admin)
@freezed
class BulkUpdateProductsRequestDto with _$BulkUpdateProductsRequestDto {
  const factory BulkUpdateProductsRequestDto({
    required List<String> productIds,
    required Map<String, dynamic> updates,
  }) = _BulkUpdateProductsRequestDto;

  factory BulkUpdateProductsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$BulkUpdateProductsRequestDtoFromJson(json);
}

/// Create Category Request DTO (Admin)
@freezed
class CreateCategoryRequestDto with _$CreateCategoryRequestDto {
  const factory CreateCategoryRequestDto({
    required String name,
    required String description,
    String? parentId,
    String? image,
    bool? isActive,
  }) = _CreateCategoryRequestDto;

  factory CreateCategoryRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateCategoryRequestDtoFromJson(json);
}

/// Update Category Request DTO (Admin)
@freezed
class UpdateCategoryRequestDto with _$UpdateCategoryRequestDto {
  const factory UpdateCategoryRequestDto({
    String? name,
    String? description,
    String? parentId,
    String? image,
    bool? isActive,
  }) = _UpdateCategoryRequestDto;

  factory UpdateCategoryRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateCategoryRequestDtoFromJson(json);
}

/// Create Brand Request DTO (Admin)
@freezed
class CreateBrandRequestDto with _$CreateBrandRequestDto {
  const factory CreateBrandRequestDto({
    required String name,
    required String description,
    String? logo,
    String? website,
    bool? isActive,
  }) = _CreateBrandRequestDto;

  factory CreateBrandRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateBrandRequestDtoFromJson(json);
}

/// Update Brand Request DTO (Admin)
@freezed
class UpdateBrandRequestDto with _$UpdateBrandRequestDto {
  const factory UpdateBrandRequestDto({
    String? name,
    String? description,
    String? logo,
    String? website,
    bool? isActive,
  }) = _UpdateBrandRequestDto;

  factory UpdateBrandRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateBrandRequestDtoFromJson(json);
}

/// Product Review DTO
@freezed
class ProductReviewDto with _$ProductReviewDto {
  const factory ProductReviewDto({
    required String id,
    required String productId,
    required String userId,
    required String userName,
    required int rating,
    required String comment,
    String? title,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ProductReviewDto;

  factory ProductReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewDtoFromJson(json);
}
