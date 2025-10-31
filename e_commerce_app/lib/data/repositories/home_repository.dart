import 'package:e_commerce_app/domain/entities/home_entities.dart';
import 'package:e_commerce_app/domain/entities/product_entities.dart';
import 'package:e_commerce_app/domain/repositories/home_repository.dart';
import 'package:ec_core/api_client/apis/dtos/product_dto.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/api_client/helpers/api_cache_helper.dart';
import 'package:ec_core/di/services/logger_di.dart';
import 'package:ec_core/services/ec_local_store/boxes/user_session_box.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl({
    required ApiClient apiClient,
    required UserSessionBox userSessionBox,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<EcHomeEntities> fetchHomeData() async {
    try {
      // Start fetching shop categories in the background
      _fetchShopCategoriesInBackground();

      // Use the injected API client which is already configured with
      // Supabase URL and authentication headers via DI
      final response = await _apiClient.homeApi.getHome();

      final discountProducts =
          response.data.discountProducts
              .asMap()
              .entries
              .map((entry) => entry.value.toEcProduct())
              .toList();

      final newProducts =
          response.data.newProducts
              .asMap()
              .entries
              .map((entry) => entry.value.toEcProduct())
              .toList();

      return EcHomeEntities(
        discountProducts: discountProducts,
        newProducts: newProducts,
      );
    } catch (e) {
      throw Failure('Failed to fetch home data');
    }
  }

  /// Fetches shop categories in the background using FetchBackgroundUtils
  void _fetchShopCategoriesInBackground() async {
    // First check if we already have cached data
    try {
      final cachedData =
          await ApiCacheHelper.getCachedListResponse<CategoryDto>(
            'shop_categories',
            CategoryDto.fromJson,
            method: 'GET',
          );

      if (cachedData != null && cachedData.isNotEmpty) {
        return; // Don't fetch again if we have cached data
      }
    } catch (e) {
      // Silently ignore cache errors and proceed to fetch from API
    }

    // Only fetch if no cached data exists
    FetchBackgroundUtils.fetchBackground(
          apiCall: () => _apiClient.productApi.getCategories(),
          errorContext: 'fetching shop categories',
          checkConnectivity: true,
          timeout: const Duration(seconds: 30),
        )
        .then((categories) {
          // Handle successful fetch - cache the results
          LoggerDI.success(
            'Shop categories fetched successfully in background: ${categories.length} categories',
          );

          // Cache the categories for future use (cache for 1 hour)
          ApiCacheHelper.cacheResponse(
            'shop_categories',
            categories.map((category) => category.toJson()).toList(),
            expiration: const Duration(hours: 1),
            method: 'GET',
          );
        })
        .catchError((error) {
          // Handle error - log it but don't affect the main flow
          LoggerDI.error(
            'Failed to fetch shop categories in background: $error',
          );

          // Try to get cached categories as fallback
          _getCachedShopCategories();
        });
  }

  /// Get cached shop categories as fallback
  Future<void> _getCachedShopCategories() async {
    try {
      final cachedData =
          await ApiCacheHelper.getCachedListResponse<CategoryDto>(
            'shop_categories',
            CategoryDto.fromJson,
            method: 'GET',
          );

      if (cachedData != null) {
        LoggerDI.info(
          'Using cached shop categories: ${cachedData.length} categories',
        );
      }
    } catch (e) {
      LoggerDI.error('Failed to get cached shop categories: $e');
    }
  }
}
