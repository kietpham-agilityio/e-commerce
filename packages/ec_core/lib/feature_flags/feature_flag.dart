/// Simple feature flag class for E-Commerce application
class EcFeatureFlag {
  EcFeatureFlag({
    this.enableShopPage,
    this.enableItemsPage,
    this.enableProductDetailsPage,
    this.enableBagPage,
    this.enableFavoritesPage,
    this.enableProfilePage,
    this.enableCommentsPage,
  });

  factory EcFeatureFlag.withEnvironment() {
    return EcFeatureFlag(
      enableShopPage: true,
      enableItemsPage: true,
      enableProductDetailsPage: true,
      enableBagPage: true,
      enableFavoritesPage: true,
      enableProfilePage: true,
      enableCommentsPage: true,
    );
  }

  // Page Scenarios for Demo
  bool? enableShopPage;
  bool? enableItemsPage;
  bool? enableProductDetailsPage;
  bool? enableBagPage;
  bool? enableFavoritesPage;
  bool? enableLoginPage;
  bool? enableProfilePage;
  bool? enableCommentsPage;

  EcFeatureFlag copyWith({
    bool? enableShopPage,
    bool? enableItemsPage,
    bool? enableProductDetailsPage,
    bool? enableBagPage,
    bool? enableFavoritesPage,
    bool? enableProfilePage,
    bool? enableCommentsPage,
  }) {
    return EcFeatureFlag(
      enableShopPage: enableShopPage ?? this.enableShopPage,
      enableItemsPage: enableItemsPage ?? this.enableItemsPage,
      enableProductDetailsPage:
          enableProductDetailsPage ?? this.enableProductDetailsPage,
      enableBagPage: enableBagPage ?? this.enableBagPage,
      enableFavoritesPage: enableFavoritesPage ?? this.enableFavoritesPage,
      enableProfilePage: enableProfilePage ?? this.enableProfilePage,
      enableCommentsPage: enableCommentsPage ?? this.enableCommentsPage,
    );
  }
}
