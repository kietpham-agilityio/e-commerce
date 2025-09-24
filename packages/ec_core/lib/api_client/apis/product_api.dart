import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dtos/product_dto.dart';
import 'dtos/base_response.dart';

part 'product_api.g.dart';

/// Product API service interface using Retrofit
@RestApi()
abstract class ProductApi {
  factory ProductApi(Dio dio, {String? baseUrl}) = _ProductApi;

  // ============================================================================
  // PRODUCT ENDPOINTS
  // ============================================================================

  /// Get all products with pagination and filters
  @GET('/products')
  Future<PaginatedResponseDto<ProductDto>> getProducts(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('category') String? categoryId,
    @Query('brand') String? brandId,
    @Query('search') String? search,
    @Query('minPrice') double? minPrice,
    @Query('maxPrice') double? maxPrice,
    @Query('minRating') double? minRating,
    @Query('sortBy') String? sortBy,
    @Query('sortOrder') String? sortOrder,
    @Query('inStock') bool? inStock,
  );

  /// Get product by ID
  @GET('/products/{productId}')
  Future<BaseResponseDto<ProductDto>> getProductById(
    @Path('productId') String productId,
  );

  /// Search products
  @POST('/products/search')
  Future<PaginatedResponseDto<ProductDto>> searchProducts(
    @Body() ProductSearchRequestDto request,
  );

  /// Get featured products
  @GET('/products/featured')
  Future<BaseResponseDto<List<ProductDto>>> getFeaturedProducts(
    @Query('limit') int? limit,
  );

  /// Get related products
  @GET('/products/{productId}/related')
  Future<BaseResponseDto<List<ProductDto>>> getRelatedProducts(
    @Path('productId') String productId,
    @Query('limit') int? limit,
  );

  /// Get product reviews
  @GET('/products/{productId}/reviews')
  Future<PaginatedResponseDto<Map<String, dynamic>>> getProductReviews(
    @Path('productId') String productId,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('rating') int? rating,
  );

  /// Add product review
  @POST('/products/{productId}/reviews')
  Future<BaseResponseDto<Map<String, dynamic>>> addProductReview(
    @Path('productId') String productId,
    @Body() Map<String, dynamic> review,
  );

  // ============================================================================
  // CATEGORY ENDPOINTS
  // ============================================================================

  /// Get all categories
  @GET('/categories')
  Future<BaseResponseDto<List<CategoryDto>>> getCategories(
    @Query('parentId') String? parentId,
    @Query('includeChildren') bool? includeChildren,
  );

  /// Get category by ID
  @GET('/categories/{categoryId}')
  Future<BaseResponseDto<CategoryDto>> getCategoryById(
    @Path('categoryId') String categoryId,
  );

  /// Get category products
  @GET('/categories/{categoryId}/products')
  Future<PaginatedResponseDto<ProductDto>> getCategoryProducts(
    @Path('categoryId') String categoryId,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('sortBy') String? sortBy,
    @Query('sortOrder') String? sortOrder,
  );

  // ============================================================================
  // BRAND ENDPOINTS
  // ============================================================================

  /// Get all brands
  @GET('/brands')
  Future<BaseResponseDto<List<BrandDto>>> getBrands(
    @Query('active') bool? active,
  );

  /// Get brand by ID
  @GET('/brands/{brandId}')
  Future<BaseResponseDto<BrandDto>> getBrandById(
    @Path('brandId') String brandId,
  );

  /// Get brand products
  @GET('/brands/{brandId}/products')
  Future<PaginatedResponseDto<ProductDto>> getBrandProducts(
    @Path('brandId') String brandId,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('sortBy') String? sortBy,
    @Query('sortOrder') String? sortOrder,
  );

  // ============================================================================
  // ADMIN PRODUCT MANAGEMENT ENDPOINTS
  // ============================================================================

  /// Create new product (Admin only)
  @POST('/admin/products')
  Future<BaseResponseDto<ProductDto>> createProduct(
    @Body() Map<String, dynamic> product,
  );

  /// Update product (Admin only)
  @PUT('/admin/products/{productId}')
  Future<BaseResponseDto<ProductDto>> updateProduct(
    @Path('productId') String productId,
    @Body() Map<String, dynamic> updates,
  );

  /// Delete product (Admin only)
  @DELETE('/admin/products/{productId}')
  Future<SuccessResponseDto> deleteProduct(@Path('productId') String productId);

  /// Update product stock (Admin only)
  @PUT('/admin/products/{productId}/stock')
  Future<BaseResponseDto<ProductDto>> updateProductStock(
    @Path('productId') String productId,
    @Body() Map<String, dynamic> stockUpdate,
  );

  /// Bulk update products (Admin only)
  @PUT('/admin/products/bulk')
  Future<BaseResponseDto<List<ProductDto>>> bulkUpdateProducts(
    @Body() Map<String, dynamic> updates,
  );

  // ============================================================================
  // ADMIN CATEGORY MANAGEMENT ENDPOINTS
  // ============================================================================

  /// Create new category (Admin only)
  @POST('/admin/categories')
  Future<BaseResponseDto<CategoryDto>> createCategory(
    @Body() Map<String, dynamic> category,
  );

  /// Update category (Admin only)
  @PUT('/admin/categories/{categoryId}')
  Future<BaseResponseDto<CategoryDto>> updateCategory(
    @Path('categoryId') String categoryId,
    @Body() Map<String, dynamic> updates,
  );

  /// Delete category (Admin only)
  @DELETE('/admin/categories/{categoryId}')
  Future<SuccessResponseDto> deleteCategory(
    @Path('categoryId') String categoryId,
  );

  // ============================================================================
  // ADMIN BRAND MANAGEMENT ENDPOINTS
  // ============================================================================

  /// Create new brand (Admin only)
  @POST('/admin/brands')
  Future<BaseResponseDto<BrandDto>> createBrand(
    @Body() Map<String, dynamic> brand,
  );

  /// Update brand (Admin only)
  @PUT('/admin/brands/{brandId}')
  Future<BaseResponseDto<BrandDto>> updateBrand(
    @Path('brandId') String brandId,
    @Body() Map<String, dynamic> updates,
  );

  /// Delete brand (Admin only)
  @DELETE('/admin/brands/{brandId}')
  Future<SuccessResponseDto> deleteBrand(@Path('brandId') String brandId);
}
