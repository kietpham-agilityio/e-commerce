import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_flag_dto.freezed.dart';
part 'feature_flag_dto.g.dart';

/// Feature Flag DTO for API communication
@freezed
class FeatureFlagDto with _$FeatureFlagDto {
  const factory FeatureFlagDto({
    String? id,
    String? userId,
    bool? enableShopPage,
    bool? enableItemsPage,
    bool? enableProductDetailsPage,
    bool? enableBagPage,
    bool? enableFavoritesPage,
    bool? enableProfilePage,
    bool? enableCommentsPage,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) = _FeatureFlagDto;

  factory FeatureFlagDto.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagDtoFromJson(json);
}

/// Request DTO for updating feature flags
@freezed
class UpdateFeatureFlagRequestDto with _$UpdateFeatureFlagRequestDto {
  const factory UpdateFeatureFlagRequestDto({
    bool? enableShopPage,
    bool? enableItemsPage,
    bool? enableProductDetailsPage,
    bool? enableBagPage,
    bool? enableFavoritesPage,
    bool? enableProfilePage,
    bool? enableCommentsPage,
  }) = _UpdateFeatureFlagRequestDto;

  factory UpdateFeatureFlagRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateFeatureFlagRequestDtoFromJson(json);
}
