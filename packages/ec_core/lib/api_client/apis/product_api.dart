import 'package:dio/dio.dart';
import 'package:ec_core/api_client/apis/dtos/product_details_dto.dart';
import 'package:ec_core/api_client/apis/dtos/product_details_request_body.dart';
import 'package:retrofit/retrofit.dart';

import 'dtos/base_response.dart';
import 'dtos/product_dto.dart';

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
    // @Query('page') int page,
    // @Query('limit') int limit,
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
    @Path('productId') int productId,
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

  @POST('/rest/v1/rpc/get_product_with_related')
  Future<BaseResponseDto<ProductDetailsDto>> getProductDetails({
    @Body() required ProductDetailsRequestBodyDto body,
  });

  /// Get related products
  @GET('/products/{productId}/related')
  Future<BaseResponseDto<List<ProductDto>>> getRelatedProducts(
    @Path('productId') int productId,
    @Query('limit') int? limit,
  );

  /// Get product reviews
  @GET('/products/{productId}/reviews')
  Future<PaginatedResponseDto<ProductReviewDto>> getProductReviews(
    @Path('productId') int productId,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('rating') int? rating,
  );

  /// Add product review
  @POST('/products/{productId}/reviews')
  Future<BaseResponseDto<ProductReviewDto>> addProductReview(
    @Path('productId') int productId,
    @Body() ProductReviewRequestDto request,
  );

  // ============================================================================
  // CATEGORY ENDPOINTS
  // ============================================================================

  /// Get all categories
  @GET('/rest/v1/categories')
  Future<List<CategoryDto>> getCategories({
    @Query('parentId') String? parentId,
    @Query('includeChildren') bool? includeChildren,
  });

  /// Get category by ID
  @GET('/categories/{categoryId}')
  Future<BaseResponseDto<CategoryDto>> getCategoryById(
    @Path('categoryId') int categoryId,
  );

  /// Get category products
  @GET('/categories/{categoryId}/products')
  Future<PaginatedResponseDto<ProductDto>> getCategoryProducts(
    @Path('categoryId') int categoryId,
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

  /// Get brand by name
  @GET('/brands/{brandName}')
  Future<BaseResponseDto<BrandDto>> getBrandByName(
    @Path('brandName') String brandName,
  );

  /// Get brand products
  @GET('/brands/{brandName}/products')
  Future<PaginatedResponseDto<ProductDto>> getBrandProducts(
    @Path('brandName') String brandName,
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
    @Body() CreateProductRequestDto request,
  );

  /// Update product (Admin only)
  @PUT('/admin/products/{productId}')
  Future<BaseResponseDto<ProductDto>> updateProduct(
    @Path('productId') int productId,
    @Body() UpdateProductRequestDto request,
  );

  /// Delete product (Admin only)
  @DELETE('/admin/products/{productId}')
  Future<SuccessResponseDto> deleteProduct(@Path('productId') int productId);

  /// Update product stock (Admin only)
  @PUT('/admin/products/{productId}/stock')
  Future<BaseResponseDto<ProductDto>> updateProductStock(
    @Path('productId') int productId,
    @Body() UpdateProductStockRequestDto request,
  );

  /// Bulk update products (Admin only)
  @PUT('/admin/products/bulk')
  Future<BaseResponseDto<List<ProductDto>>> bulkUpdateProducts(
    @Body() BulkUpdateProductsRequestDto request,
  );

  // ============================================================================
  // ADMIN CATEGORY MANAGEMENT ENDPOINTS
  // ============================================================================

  /// Create new category (Admin only)
  @POST('/admin/categories')
  Future<BaseResponseDto<CategoryDto>> createCategory(
    @Body() CreateCategoryRequestDto request,
  );

  /// Update category (Admin only)
  @PUT('/admin/categories/{categoryId}')
  Future<BaseResponseDto<CategoryDto>> updateCategory(
    @Path('categoryId') int categoryId,
    @Body() UpdateCategoryRequestDto request,
  );

  /// Delete category (Admin only)
  @DELETE('/admin/categories/{categoryId}')
  Future<SuccessResponseDto> deleteCategory(@Path('categoryId') int categoryId);

  // ============================================================================
  // ADMIN BRAND MANAGEMENT ENDPOINTS
  // ============================================================================

  /// Create new brand (Admin only)
  @POST('/admin/brands')
  Future<BaseResponseDto<BrandDto>> createBrand(
    @Body() CreateBrandRequestDto request,
  );

  /// Update brand (Admin only)
  @PUT('/admin/brands/{brandName}')
  Future<BaseResponseDto<BrandDto>> updateBrand(
    @Path('brandName') String brandName,
    @Body() UpdateBrandRequestDto request,
  );

  /// Delete brand (Admin only)
  @DELETE('/admin/brands/{brandName}')
  Future<SuccessResponseDto> deleteBrand(@Path('brandName') String brandName);
}
