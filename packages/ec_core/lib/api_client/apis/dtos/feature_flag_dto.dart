import 'package:json_annotation/json_annotation.dart';

part 'feature_flag_dto.g.dart';

/// Feature flag data transfer object
@JsonSerializable()
class FeatureFlagDto {
  const FeatureFlagDto({
    required this.enableShopPage,
    required this.enableItemsPage,
    required this.enableProductDetailsPage,
    required this.enableBagPage,
    required this.enableFavoritesPage,
    required this.enableProfilePage,
    required this.enableCommentsPage,
    required this.updatedAt,
  });

  factory FeatureFlagDto.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureFlagDtoToJson(this);

  @JsonKey(name: 'enable_shop_page')
  final bool? enableShopPage;

  @JsonKey(name: 'enable_items_page')
  final bool? enableItemsPage;

  @JsonKey(name: 'enable_product_details_page')
  final bool? enableProductDetailsPage;

  @JsonKey(name: 'enable_bag_page')
  final bool? enableBagPage;

  @JsonKey(name: 'enable_favorites_page')
  final bool? enableFavoritesPage;

  @JsonKey(name: 'enable_profile_page')
  final bool? enableProfilePage;

  @JsonKey(name: 'enable_comments_page')
  final bool? enableCommentsPage;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
}

/// Request DTO for updating feature flags
@JsonSerializable()
class UpdateFeatureFlagRequestDto {
  const UpdateFeatureFlagRequestDto({
    required this.enableShopPage,
    required this.enableItemsPage,
    required this.enableProductDetailsPage,
    required this.enableBagPage,
    required this.enableFavoritesPage,
    required this.enableProfilePage,
    required this.enableCommentsPage,
  });

  factory UpdateFeatureFlagRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateFeatureFlagRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateFeatureFlagRequestDtoToJson(this);

  @JsonKey(name: 'p_enable_shop_page')
  final bool? enableShopPage;

  @JsonKey(name: 'p_enable_items_page')
  final bool? enableItemsPage;

  @JsonKey(name: 'p_enable_product_details_page')
  final bool? enableProductDetailsPage;

  @JsonKey(name: 'p_enable_bag_page')
  final bool? enableBagPage;

  @JsonKey(name: 'p_enable_favorites_page')
  final bool? enableFavoritesPage;

  @JsonKey(name: 'p_enable_profile_page')
  final bool? enableProfilePage;

  @JsonKey(name: 'p_enable_comments_page')
  final bool? enableCommentsPage;
}

/// Request DTO for logging feature flag changes
@JsonSerializable()
class FeatureFlagLogRequestDto {
  const FeatureFlagLogRequestDto({
    required this.flagName,
    required this.oldValue,
    required this.newValue,
    required this.timestamp,
    this.userId,
    this.sessionId,
  });

  factory FeatureFlagLogRequestDto.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagLogRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureFlagLogRequestDtoToJson(this);

  final String flagName;
  final bool? oldValue;
  final bool? newValue;
  final DateTime timestamp;
  final String? userId;
  final String? sessionId;
}
