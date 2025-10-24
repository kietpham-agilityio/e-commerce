import 'dart:developer';

import 'package:e_commerce_app/domain/entities/category_entity.dart';
import 'package:e_commerce_app/domain/repositories/shop_repository.dart';
import 'package:ec_core/api_client/apis/dtos/product_dto.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/api_client/helpers/api_cache_helper.dart';

class ShopRepositoryImpl extends ShopRepository {
  ShopRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<EcCategoryEntity>> fetchShopCategories() async {
    // First check if we already have cached data
    try {
      final cachedData =
          await ApiCacheHelper.getCachedListResponse<CategoryDto>(
            'shop_categories',
            CategoryDto.fromJson,
            method: 'GET',
          );

      if (cachedData != null && cachedData.isNotEmpty) {
        log('✅ Using cached shop categories: ${cachedData.length} categories');
        // Convert cached CategoryDto to domain entities
        return cachedData
            .map((categoryDto) => categoryDto.toEcCategoryEntity())
            .toList();
      } else {
        log('⚠️ Cache returned: ${cachedData == null ? "null" : "empty list"}');
      }
    } catch (e) {
      log('❌ Error reading cache: $e');
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
