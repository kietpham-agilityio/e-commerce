import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dtos/feature_flag_dto.dart';

part 'feature_flag_api.g.dart';

/// Feature Flag API service interface using Retrofit
@RestApi()
abstract class FeatureFlagApi {
  factory FeatureFlagApi(Dio dio, {String? baseUrl}) = _FeatureFlagApi;

  // ============================================================================
  // FEATURE FLAG ENDPOINTS
  // ============================================================================

  /// Get current feature flags for user using RPC with GET
  @GET('/rest/v1/rpc/get_user_feature_flags')
  Future<List<FeatureFlagDto>> getFeatureFlags();

  /// Update feature flags for user using RPC
  @POST('/rest/v1/rpc/update_user_feature_flags')
  Future<List<FeatureFlagDto>> updateFeatureFlags(
    @Body() UpdateFeatureFlagRequestDto request,
  );
}
