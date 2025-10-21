import 'package:ec_core/feature_flags/feature_flag.dart';
import 'feature_flag_dto.dart';

/// Extension to convert FeatureFlagDto to EcFeatureFlag
extension FeatureFlagDtoMapper on FeatureFlagDto {
  EcFeatureFlag toEntity() {
    return EcFeatureFlag(
      enableShopPage: enableShopPage,
      enableItemsPage: enableItemsPage,
      enableProductDetailsPage: enableProductDetailsPage,
      enableBagPage: enableBagPage,
      enableFavoritesPage: enableFavoritesPage,
      enableProfilePage: enableProfilePage,
      enableCommentsPage: enableCommentsPage,
    );
  }
}

/// Extension to convert EcFeatureFlag to FeatureFlagDto
extension EcFeatureFlagMapper on EcFeatureFlag {
  FeatureFlagDto toDto({String? userId}) {
    return FeatureFlagDto(
      userId: userId,
      enableShopPage: enableShopPage,
      enableItemsPage: enableItemsPage,
      enableProductDetailsPage: enableProductDetailsPage,
      enableBagPage: enableBagPage,
      enableFavoritesPage: enableFavoritesPage,
      enableProfilePage: enableProfilePage,
      enableCommentsPage: enableCommentsPage,
    );
  }

  UpdateFeatureFlagRequestDto toUpdateDto() {
    return UpdateFeatureFlagRequestDto(
      enableShopPage: enableShopPage,
      enableItemsPage: enableItemsPage,
      enableProductDetailsPage: enableProductDetailsPage,
      enableBagPage: enableBagPage,
      enableFavoritesPage: enableFavoritesPage,
      enableProfilePage: enableProfilePage,
      enableCommentsPage: enableCommentsPage,
    );
  }
}
