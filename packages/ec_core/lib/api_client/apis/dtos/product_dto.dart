import 'package:freezed_annotation/freezed_annotation.dart';
import '../../enums/supabase_enums.dart';

part 'product_dto.freezed.dart';
part 'product_dto.g.dart';

/// Product Data Transfer Object - matches Supabase products table
@freezed
class ProductDto with _$ProductDto {
  const factory ProductDto({
    required int id,
    required String name,
    String? description,
    required int? categoryId, // References categories.id
    String? brand, // text from Supabase
    required double price, // numeric from Supabase
    required ProductStatus status, // product_status enum from Supabase
    DateTime? createdAt, // timestamptz from Supabase
    // Additional fields for UI display (computed from joins)
    List<ProductImageDto>? images,
    List<ProductVariantDto>? variants,
    double? averageRating,
    int? reviewCount,
  }) = _ProductDto;

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);
}

/// Product Variant Data Transfer Object - matches Supabase product_variants table
@freezed
class ProductVariantDto with _$ProductVariantDto {
  const factory ProductVariantDto({
    required int id,
    required int? productId, // References products.id
    SizeOption? size, // size_option enum from Supabase
    ColorOption? color, // color_option enum from Supabase
    String? sku, // text from Supabase
    int? stockQty, // integer from Supabase
    double? priceOverride, // numeric from Supabase
    // Additional fields for UI display
    String? variantName,
    bool? isAvailable,
  }) = _ProductVariantDto;

  factory ProductVariantDto.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantDtoFromJson(json);
}

/// Product Image Data Transfer Object - matches Supabase product_images table
@freezed
class ProductImageDto with _$ProductImageDto {
  const factory ProductImageDto({
    required int id,
    required int? productId, // References products.id
    required String imageUrl, // text from Supabase
    bool? isPrimary, // boolean from Supabase (defaults to false)
  }) = _ProductImageDto;

  factory ProductImageDto.fromJson(Map<String, dynamic> json) =>
      _$ProductImageDtoFromJson(json);
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

/// Category Data Transfer Object - matches Supabase categories table
@freezed
class CategoryDto with _$CategoryDto {
  const factory CategoryDto({
    required int id,
    required String name,
    String? description,
    int? parentId, // References categories.id (self-reference)
    // Additional fields for UI display (computed from joins)
    List<CategoryDto>? children,
    int? productCount,
    String? image,
  }) = _CategoryDto;

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);
}

/// Brand Data Transfer Object - simplified for Supabase (brand is just text field in products)
@freezed
class BrandDto with _$BrandDto {
  const factory BrandDto({
    required String name,
    int? productCount,
    String? logo,
    String? website,
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
    String? description,
    required int? categoryId,
    String? brand,
    required double price,
    required ProductStatus status,
    List<ProductImageDto>? images,
    List<ProductVariantDto>? variants,
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
    int? categoryId,
    String? brand,
    double? price,
    ProductStatus? status,
    List<ProductImageDto>? images,
    List<ProductVariantDto>? variants,
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
    String? description,
    int? parentId,
    String? image,
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
    int? parentId,
    String? image,
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

/// Product Review DTO - matches Supabase reviews table
@freezed
class ProductReviewDto with _$ProductReviewDto {
  const factory ProductReviewDto({
    required int id,
    required String? userId, // UUID from Supabase auth
    required int? productId, // References products.id
    required int? rating, // integer from Supabase
    String? comment, // text from Supabase
    DateTime? createdAt, // timestamptz from Supabase
    // Additional fields for UI display (computed from joins)
    String? userName,
    String? productName,
  }) = _ProductReviewDto;

  factory ProductReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewDtoFromJson(json);
}

/// Product Review Request DTO
@freezed
class ProductReviewRequestDto with _$ProductReviewRequestDto {
  const factory ProductReviewRequestDto({
    required int rating,
    String? comment,
  }) = _ProductReviewRequestDto;

  factory ProductReviewRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewRequestDtoFromJson(json);
}
