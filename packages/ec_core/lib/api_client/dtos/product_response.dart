import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponseDto {
  const ProductResponseDto({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.price = 0.0,
    this.originalPrice = 0.0,
    this.image = '',
    this.images = const [],
    this.stock = 0,
    this.category = '',
    this.brand = '',
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isActive = false,
    this.isFeatured = false,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseDtoFromJson(json);

  final int id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final String image;
  final List<String> images;
  final int stock;
  final String category;
  final String brand;
  final double rating;
  final int reviewCount;
  final bool isActive;
  final bool isFeatured;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() => _$ProductResponseDtoToJson(this);
}

@JsonSerializable()
class ProductListResponseDto {
  const ProductListResponseDto({
    @JsonKey(name: 'data') this.data = const [],
    this.status,
    this.isSuccess = false,
    this.totalCount = 0,
    this.message,
  });

  factory ProductListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseDtoFromJson(json);

  @JsonKey(name: 'data')
  final List<ProductResponseDto?> data;
  final String? status;
  final bool isSuccess;
  final int totalCount;
  final String? message;

  Map<String, dynamic> toJson() => _$ProductListResponseDtoToJson(this);
}

@JsonSerializable()
class ProductCreateRequestDto {
  const ProductCreateRequestDto({
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.image,
    this.images = const [],
    this.stock = 0,
    required this.category,
    required this.brand,
    this.isActive = true,
    this.isFeatured = false,
  });

  factory ProductCreateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ProductCreateRequestDtoFromJson(json);

  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String image;
  final List<String> images;
  final int stock;
  final String category;
  final String brand;
  final bool isActive;
  final bool isFeatured;

  Map<String, dynamic> toJson() => _$ProductCreateRequestDtoToJson(this);
}

@JsonSerializable()
class ProductUpdateRequestDto {
  const ProductUpdateRequestDto({
    this.name,
    this.description,
    this.price,
    this.originalPrice,
    this.image,
    this.images,
    this.stock,
    this.category,
    this.brand,
    this.isActive,
    this.isFeatured,
  });

  factory ProductUpdateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ProductUpdateRequestDtoFromJson(json);

  final String? name;
  final String? description;
  final double? price;
  final double? originalPrice;
  final String? image;
  final List<String>? images;
  final int? stock;
  final String? category;
  final String? brand;
  final bool? isActive;
  final bool? isFeatured;

  Map<String, dynamic> toJson() => _$ProductUpdateRequestDtoToJson(this);
}
