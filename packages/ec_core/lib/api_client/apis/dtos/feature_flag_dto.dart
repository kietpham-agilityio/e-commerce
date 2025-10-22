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

  final bool? enableShopPage;
  final bool? enableItemsPage;
  final bool? enableProductDetailsPage;
  final bool? enableBagPage;
  final bool? enableFavoritesPage;
  final bool? enableProfilePage;
  final bool? enableCommentsPage;
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

  final bool? enableShopPage;
  final bool? enableItemsPage;
  final bool? enableProductDetailsPage;
  final bool? enableBagPage;
  final bool? enableFavoritesPage;
  final bool? enableProfilePage;
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
