import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dtos/review_dto.dart';
import 'dtos/base_response.dart';

part 'review_api.g.dart';

/// Review API service interface using Retrofit
@RestApi()
abstract class ReviewApi {
  factory ReviewApi(Dio dio, {String? baseUrl}) = _ReviewApi;

  // ============================================================================
  // REVIEW ENDPOINTS
  // ============================================================================

  /// Get product reviews
  @GET('/reviews/product/{productId}')
  Future<BaseResponseDto<List<ReviewDto>>> getProductReviews(
    @Path('productId') int productId,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('rating') int? rating,
  );

  /// Get user reviews
  @GET('/reviews/user')
  Future<BaseResponseDto<List<ReviewDto>>> getUserReviews(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  /// Create product review
  @POST('/reviews')
  Future<BaseResponseDto<ReviewDto>> createReview(
    @Body() CreateReviewRequestDto request,
  );

  /// Update review
  @PUT('/reviews/{reviewId}')
  Future<BaseResponseDto<ReviewDto>> updateReview(
    @Path('reviewId') int reviewId,
    @Body() UpdateReviewRequestDto request,
  );

  /// Delete review
  @DELETE('/reviews/{reviewId}')
  Future<SuccessResponseDto> deleteReview(@Path('reviewId') int reviewId);

  /// Get review analytics for a product
  @GET('/reviews/analytics/product/{productId}')
  Future<BaseResponseDto<ReviewAnalyticsDto>> getProductReviewAnalytics(
    @Path('productId') int productId,
  );

  // ============================================================================
  // ADMIN REVIEW MANAGEMENT ENDPOINTS
  // ============================================================================

  /// Get all reviews (Admin only)
  @GET('/admin/reviews')
  Future<BaseResponseDto<List<ReviewDto>>> getAllReviews(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('rating') int? rating,
    @Query('productId') int? productId,
    @Query('userId') String? userId,
  );

  /// Get review analytics (Admin only)
  @GET('/admin/reviews/analytics')
  Future<BaseResponseDto<ReviewAnalyticsDto>> getReviewAnalytics(
    @Query('dateFrom') String? dateFrom,
    @Query('dateTo') String? dateTo,
    @Query('productId') int? productId,
  );

  /// Moderate review (Admin only)
  @PUT('/admin/reviews/{reviewId}/moderate')
  Future<BaseResponseDto<ReviewDto>> moderateReview(
    @Path('reviewId') int reviewId,
    @Body() Map<String, dynamic> moderationData,
  );
}
