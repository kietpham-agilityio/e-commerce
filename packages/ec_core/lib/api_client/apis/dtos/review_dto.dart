import 'package:freezed_annotation/freezed_annotation.dart';
import '../../enums/supabase_enums.dart';

part 'review_dto.freezed.dart';
part 'review_dto.g.dart';

/// Review Data Transfer Object - matches Supabase reviews table
@freezed
class ReviewDto with _$ReviewDto {
  const factory ReviewDto({
    required int id,
    required String? userId, // UUID from Supabase auth
    required int? productId, // References products.id
    required int? rating, // integer from Supabase
    String? comment, // text from Supabase
    DateTime? createdAt, // timestamptz from Supabase
    // Additional fields for UI display (computed from joins)
    String? userName,
    String? productName,
  }) = _ReviewDto;

  factory ReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewDtoFromJson(json);
}

/// Create Review Request DTO
@freezed
class CreateReviewRequestDto with _$CreateReviewRequestDto {
  const factory CreateReviewRequestDto({
    required int productId,
    required int rating,
    String? comment,
  }) = _CreateReviewRequestDto;

  factory CreateReviewRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewRequestDtoFromJson(json);
}

/// Update Review Request DTO
@freezed
class UpdateReviewRequestDto with _$UpdateReviewRequestDto {
  const factory UpdateReviewRequestDto({int? rating, String? comment}) =
      _UpdateReviewRequestDto;

  factory UpdateReviewRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateReviewRequestDtoFromJson(json);
}

/// Review Analytics DTO (Admin)
@freezed
class ReviewAnalyticsDto with _$ReviewAnalyticsDto {
  const factory ReviewAnalyticsDto({
    required double averageRating,
    required int totalReviews,
    required Map<int, int> ratingDistribution, // rating -> count
    required List<ReviewDto> recentReviews,
    DateTime? generatedAt,
  }) = _ReviewAnalyticsDto;

  factory ReviewAnalyticsDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewAnalyticsDtoFromJson(json);
}
