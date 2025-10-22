import 'package:e_commerce_app/domain/repositories/feature_flag_repository.dart';
import 'package:ec_core/api_client/apis/dtos/feature_flag_dto.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_core/services/ec_local_store/boxes/user_session_box.dart';

class FeatureFlagRepositoryImpl extends FeatureFlagRepository {
  FeatureFlagRepositoryImpl({
    required ApiClient apiClient,
    required UserSessionBox userSessionBox,
  }) : _apiClient = apiClient,
       _userSessionBox = userSessionBox;

  final ApiClient _apiClient;
  final UserSessionBox _userSessionBox;

  @override
  Future<EcFeatureFlag> getFeatureFlags() async {
    try {
      final response = await _apiClient.featureFlagApi.getFeatureFlags();
      return _mapDtoToEntity(response.data);
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
      return _mapDtoToEntity(response.data);
    } catch (e) {
      throw Failure('Failed to update feature flags: ${e.toString()}');
    }
  }

  @override
  Future<void> logFeatureFlagChange({
    required String flagName,
    required bool? oldValue,
    required bool? newValue,
    String? userId,
    String? sessionId,
  }) async {
    try {
      // Get user ID from current session if not provided
      String? actualUserId = userId;
      if (actualUserId == null) {
        final session = await _userSessionBox.getCurrentSession();
        actualUserId = session?.userID?.toString();
      }

      final request = FeatureFlagLogRequestDto(
        flagName: flagName,
        oldValue: oldValue,
        newValue: newValue,
        timestamp: DateTime.now(),
        userId: actualUserId,
        sessionId: sessionId,
      );

      await _apiClient.featureFlagApi.logFeatureFlagChange(request);
    } catch (e) {
      // Log error but don't throw - this shouldn't break the user experience
      print('Failed to log feature flag change: ${e.toString()}');
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
