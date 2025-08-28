import 'package:dio/dio.dart';

import '../apis/failure.dart';
import '../core/base_api_service.dart';
import '../core/api_client.dart';

/// Example Product API Service
/// Demonstrates how to use the refactored API client system
class ProductApiService extends BaseApiService {
  ProductApiService(super.apiClient);

  /// Get all products with pagination
  Future<List<Map<String, dynamic>>> getProducts({
    int page = 1,
    int limit = 10,
    String? category,
    String? search,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};

    if (category != null && category.isNotEmpty) {
      queryParams['category'] = category;
    }

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    return safeApiCall(() async {
      final response = await apiClient.get<dynamic>(
        '/products',
        queryParameters: queryParams,
      );
      return handleListResponse(
        response,
        (json) => json as Map<String, dynamic>,
      );
    });
  }

  /// Get products with pagination support
  Future<PaginatedResponse<Map<String, dynamic>>> getProductsPaginated({
    int page = 1,
    int limit = 10,
    String? category,
    String? search,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};

    if (category != null && category.isNotEmpty) {
      queryParams['category'] = category;
    }

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    return safeApiCall(() async {
      final response = await apiClient.get<dynamic>(
        '/products',
        queryParameters: queryParams,
      );
      return handlePaginatedResponse(
        response,
        (json) => json as Map<String, dynamic>,
      );
    });
  }

  /// Get a single product by ID
  Future<Map<String, dynamic>> getProduct(String id) async {
    return safeApiCall(() async {
      final response = await apiClient.get<dynamic>('/products/$id');
      return handleResponse(response, (json) => json as Map<String, dynamic>);
    });
  }

  /// Create a new product
  Future<Map<String, dynamic>> createProduct(
    Map<String, dynamic> productData,
  ) async {
    return safeApiCall(() async {
      final response = await apiClient.post<dynamic>(
        '/products',
        data: productData,
      );
      return handleResponse(response, (json) => json as Map<String, dynamic>);
    });
  }

  /// Update an existing product
  Future<Map<String, dynamic>> updateProduct(
    String id,
    Map<String, dynamic> productData,
  ) async {
    return safeApiCall(() async {
      final response = await apiClient.put<dynamic>(
        '/products/$id',
        data: productData,
      );
      return handleResponse(response, (json) => json as Map<String, dynamic>);
    });
  }

  /// Delete a product
  Future<bool> deleteProduct(String id) async {
    return safeApiCall(() async {
      await apiClient.delete<dynamic>('/products/$id');
      return true;
    });
  }

  /// Search products with advanced filters
  Future<List<Map<String, dynamic>>> searchProducts({
    required String query,
    List<String>? categories,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = <String, dynamic>{'q': query};

    if (categories != null && categories.isNotEmpty) {
      queryParams['categories'] = categories.join(',');
    }

    if (minPrice != null) {
      queryParams['minPrice'] = minPrice;
    }

    if (maxPrice != null) {
      queryParams['maxPrice'] = maxPrice;
    }

    if (sortBy != null) {
      queryParams['sortBy'] = sortBy;
    }

    if (sortOrder != null) {
      queryParams['sortOrder'] = sortOrder;
    }

    return safeApiCall(() async {
      final response = await apiClient.get<dynamic>(
        '/products/search',
        queryParameters: queryParams,
      );
      return handleListResponse(
        response,
        (json) => json as Map<String, dynamic>,
      );
    });
  }

  /// Upload product image
  Future<Map<String, dynamic>> uploadProductImage(
    String productId,
    String imagePath,
  ) async {
    return safeApiCall(() async {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath),
        'productId': productId,
      });

      final response = await apiClient.uploadFile<dynamic>(
        '/products/$productId/images',
        formData: formData,
      );
      return handleResponse(response, (json) => json as Map<String, dynamic>);
    });
  }

  /// Get product categories
  Future<List<String>> getProductCategories() async {
    return safeApiCall(() async {
      final response = await apiClient.get<dynamic>('/products/categories');
      return handleListResponse(response, (json) => json.toString());
    });
  }

  /// Get products by category
  Future<List<Map<String, dynamic>>> getProductsByCategory(
    String category, {
    int page = 1,
    int limit = 10,
  }) async {
    return safeApiCall(() async {
      final response = await apiClient.get<dynamic>(
        '/products/category/$category',
        queryParameters: {'page': page, 'limit': limit},
      );
      return handleListResponse(
        response,
        (json) => json as Map<String, dynamic>,
      );
    });
  }

  /// Get featured products
  Future<List<Map<String, dynamic>>> getFeaturedProducts({
    int limit = 5,
  }) async {
    return safeApiCall(() async {
      final response = await apiClient.get<dynamic>(
        '/products/featured',
        queryParameters: {'limit': limit},
      );
      return handleListResponse(
        response,
        (json) => json as Map<String, dynamic>,
      );
    });
  }

  /// Get trending products
  Future<List<Map<String, dynamic>>> getTrendingProducts({
    int limit = 10,
  }) async {
    return safeApiCall(() async {
      final response = await apiClient.get<dynamic>(
        '/products/trending',
        queryParameters: {'limit': limit},
      );
      return handleListResponse(
        response,
        (json) => json as Map<String, dynamic>,
      );
    });
  }
}
