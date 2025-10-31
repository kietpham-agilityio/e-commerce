import 'package:e_commerce_app/domain/entities/category_entity.dart';
import 'package:e_commerce_app/domain/repositories/shop_repository.dart';
import 'package:ec_core/api_client/apis/dtos/product_dto.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/api_client/helpers/api_cache_helper.dart';
import 'package:ec_core/di/services/logger_di.dart';

class ShopRepositoryImpl extends ShopRepository {
  ShopRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<EcCategoryEntity>> fetchShopCategories({
    bool isRefetched = false,
  }) async {
    if (!isRefetched) {
      // First check if we already have cached data
      try {
        final cachedData =
            await ApiCacheHelper.getCachedListResponse<CategoryDto>(
              'shop_categories',
              CategoryDto.fromJson,
              method: 'GET',
            );

        if (cachedData != null && cachedData.isNotEmpty) {
          LoggerDI.success(
            'Using cached shop categories: ${cachedData.length} categories',
          );
          // Convert cached CategoryDto to domain entities
          return cachedData
              .map((categoryDto) => categoryDto.toEcCategoryEntity())
              .toList();
        } else {
          LoggerDI.warning(
            'Cache returned: ${cachedData == null ? "null" : "empty list"}',
          );
        }
      } catch (e) {
        LoggerDI.error('Error reading cache: $e');
      }
    }

    // Only fetch from API if no cached data exists
    try {
      final response = await _apiClient.productApi.getCategories();

      final result =
          response
              .asMap()
              .entries
              .map((entry) => entry.value.toEcCategoryEntity())
              .toList();

      // Cache the results for future use (cache for 1 hour)
      ApiCacheHelper.cacheResponse(
        'shop_categories',
        response.map((category) => category.toJson()).toList(),
        expiration: const Duration(hours: 1),
        method: 'GET',
      );

      return result;
    } catch (e) {
      throw Failure('Failed to fetch categories');
    }
  }
}
