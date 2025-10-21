import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'dtos/base_response.dart';
import 'dtos/feature_flag_dto.dart';

part 'feature_flag_api.g.dart';

/// Feature Flag API service interface using Retrofit
@RestApi()
abstract class FeatureFlagApi {
  factory FeatureFlagApi(Dio dio, {String? baseUrl}) = _FeatureFlagApi;

  // ============================================================================
  // FEATURE FLAG ENDPOINTS
  // ============================================================================

  /// Get current user's feature flags
  @GET('/rest/v1/feature_flags')
  Future<List<FeatureFlagDto>> getFeatureFlags({
    @Query('user_id') String? userId,
    @Query('select') String select = '*',
    @Query('limit') int limit = 1,
  });

  /// Update user's feature flags
  @PATCH('/rest/v1/feature_flags')
  Future<List<FeatureFlagDto>> updateFeatureFlags({
    @Body() required UpdateFeatureFlagRequestDto request,
    @Query('user_id') required String userId,
    @Header('Prefer') String prefer = 'return=representation',
  });

  /// Create user's feature flags
  @POST('/rest/v1/feature_flags')
  Future<List<FeatureFlagDto>> createFeatureFlags({
    @Body() required FeatureFlagDto request,
    @Header('Prefer') String prefer = 'return=representation',
  });
}
