import 'package:e_commerce_app/domain/repositories/feature_flag_repository.dart';
import 'package:ec_core/api_client/apis/dtos/feature_flag_dto.dart';
import 'package:ec_core/ec_core.dart';

class FeatureFlagRepositoryImpl extends FeatureFlagRepository {
  FeatureFlagRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<EcFeatureFlag> getFeatureFlags() async {
    try {
      final response = await _apiClient.featureFlagApi.getFeatureFlags();
      // RPC returns a list, take the first item
      if (response.isNotEmpty) {
        return _mapDtoToEntity(response.first);
      } else {
        // Return default flags if no data
        return EcFeatureFlag.withEnvironment();
      }
    } catch (e) {
      throw Failure('Failed to fetch feature flags: ${e.toString()}');
    }
  }

  @override
  Future<EcFeatureFlag> updateFeatureFlags(EcFeatureFlag flags) async {
    try {
      final request = UpdateFeatureFlagRequestDto(
        enableShopPage: flags.enableShopPage,
        enableItemsPage: flags.enableItemsPage,
        enableProductDetailsPage: flags.enableProductDetailsPage,
        enableBagPage: flags.enableBagPage,
        enableFavoritesPage: flags.enableFavoritesPage,
        enableProfilePage: flags.enableProfilePage,
        enableCommentsPage: flags.enableCommentsPage,
      );

      final response = await _apiClient.featureFlagApi.updateFeatureFlags(
        request,
      );
      // RPC returns a list, take the first item
      if (response.isNotEmpty) {
        return _mapDtoToEntity(response.first);
      } else {
        // Return the original flags if no response
        return flags;
      }
    } catch (e) {
      throw Failure('Failed to update feature flags: ${e.toString()}');
    }
  }

  /// Map DTO to domain entity
  EcFeatureFlag _mapDtoToEntity(FeatureFlagDto dto) {
    return EcFeatureFlag(
      enableShopPage: dto.enableShopPage,
      enableItemsPage: dto.enableItemsPage,
      enableProductDetailsPage: dto.enableProductDetailsPage,
      enableBagPage: dto.enableBagPage,
      enableFavoritesPage: dto.enableFavoritesPage,
      enableProfilePage: dto.enableProfilePage,
      enableCommentsPage: dto.enableCommentsPage,
    );
  }
}
