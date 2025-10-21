import 'package:e_commerce_app/domain/repositories/feature_flag_repository.dart';
import 'package:ec_core/api_client/apis/dtos/feature_flag_mapper.dart';
import 'package:ec_core/api_client/apis/failure.dart';
import 'package:ec_core/api_client/core/api_client.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_core/services/ec_local_store/boxes/user_session_box.dart';

/// Implementation of FeatureFlagRepository
class FeatureFlagRepositoryImpl implements FeatureFlagRepository {
  FeatureFlagRepositoryImpl({
    required ApiClient apiClient,
    required UserSessionBox userSessionBox,
  }) : _apiClient = apiClient,
       _userSessionBox = userSessionBox;

  final ApiClient _apiClient;
  final UserSessionBox _userSessionBox;

  @override
  Future<EcFeatureFlag> fetchFeatureFlags() async {
    try {
      // Get current user ID from session
      final userId = _userSessionBox.getUserId();

      if (userId == null || userId.isEmpty) {
        // If no user logged in, return default flags
        return EcFeatureFlag.withEnvironment();
      }

      final response = await _apiClient.featureFlagApi.getFeatureFlags(
        userId: 'eq.$userId',
        select: '*',
        limit: 1,
      );

      if (response.isEmpty) {
        // No flags found for user, return default
        return EcFeatureFlag.withEnvironment();
      }

      return response.first.toEntity();
    } catch (e) {
      // On error, return default flags instead of throwing
      // This ensures the app continues to work even if the API is down
      return EcFeatureFlag.withEnvironment();
    }
  }

  @override
  Future<void> saveFeatureFlags(EcFeatureFlag flags) async {
    try {
      // Get current user ID from session
      final userId = _userSessionBox.getUserId();

      if (userId == null || userId.isEmpty) {
        // If no user logged in, skip saving to server
        return;
      }

      // Try to update first
      try {
        await _apiClient.featureFlagApi.updateFeatureFlags(
          request: flags.toUpdateDto(),
          userId: 'eq.$userId',
        );
      } catch (updateError) {
        // If update fails (possibly because record doesn't exist), try to create
        try {
          await _apiClient.featureFlagApi.createFeatureFlags(
            request: flags.toDto(userId: userId),
          );
        } catch (createError) {
          throw Failure('Failed to save feature flags');
        }
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure('Failed to save feature flags: ${e.toString()}');
    }
  }
}
