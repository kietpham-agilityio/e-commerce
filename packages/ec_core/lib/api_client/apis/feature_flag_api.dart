import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dtos/feature_flag_dto.dart';
import 'dtos/base_response.dart';

part 'feature_flag_api.g.dart';

/// Feature Flag API service interface using Retrofit
@RestApi()
abstract class FeatureFlagApi {
  factory FeatureFlagApi(Dio dio, {String? baseUrl}) = _FeatureFlagApi;

  // ============================================================================
  // FEATURE FLAG ENDPOINTS
  // ============================================================================

  /// Get current feature flags for user
  @GET('/feature-flags')
  Future<BaseResponseDto<FeatureFlagDto>> getFeatureFlags();

  /// Update feature flags for user
  @POST('/feature-flags')
  Future<BaseResponseDto<FeatureFlagDto>> updateFeatureFlags(
    @Body() UpdateFeatureFlagRequestDto request,
  );

  /// Log feature flag change event
  @POST('/feature-flags/log')
  Future<SuccessResponseDto> logFeatureFlagChange(
    @Body() FeatureFlagLogRequestDto request,
  );
}
