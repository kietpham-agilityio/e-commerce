import 'env.dart';

/// Simple feature flag class for E-Commerce application
class EcFeatureFlag {
  EcFeatureFlag({
    this.enableDebugMode,
    this.enableApiLogging,
    this.enableMockBackend,
    this.enableDatabaseInspector,
    this.enableAdminDebugPanel,
    this.enableUserImpersonation,
    this.enableAnalytics,
    this.enableCrashReporting,
    this.enablePerformanceMonitoring,
    this.enableApiCache,
    this.enableDarkMode,
    this.enableAnimations,
    this.enableDebugOverlay,
    this.enableNewCheckoutFlow,
    this.enableSocialLogin,
    this.enablePushNotifications,
    this.enableHomePage,
    this.enableShopPage,
    this.enableItemsPage,
    this.enableProductDetailsPage,
    this.enableBagPage,
    this.enableFavoritesPage,
    this.enableLoginPage,
    this.enableProfilePage,
    this.enableCommentsPage,
  });

  factory EcFeatureFlag.withEnvironment() {
    return EcFeatureFlag(
      enableDebugMode: EcEnv.enableDebugMode,
      enableApiLogging: EcEnv.enableApiLogging,
      enableMockBackend: EcEnv.enableMockBackend,
      enableDatabaseInspector: EcEnv.enableDatabaseInspector,
      enableAdminDebugPanel: EcEnv.enableAdminDebugPanel,
      enableUserImpersonation: EcEnv.enableUserImpersonation,
      enableAnalytics: EcEnv.enableAnalytics,
      enableCrashReporting: EcEnv.enableCrashReporting,
      enablePerformanceMonitoring: EcEnv.enablePerformanceMonitoring,
      enableApiCache: EcEnv.enableApiCache,
      enableDarkMode: EcEnv.enableDarkMode,
      enableAnimations: EcEnv.enableAnimations,
      enableDebugOverlay: EcEnv.enableDebugOverlay,
      enableNewCheckoutFlow: EcEnv.enableNewCheckoutFlow,
      enableSocialLogin: EcEnv.enableSocialLogin,
      enablePushNotifications: EcEnv.enablePushNotifications,
      enableHomePage: false,
      enableShopPage: false,
      enableItemsPage: false,
      enableProductDetailsPage: false,
      enableBagPage: false,
      enableFavoritesPage: false,
      enableLoginPage: false,
      enableProfilePage: false,
      enableCommentsPage: false,
    );
  }

  // Debug and Development Features
  bool? enableDebugMode;
  bool? enableApiLogging;
  bool? enableMockBackend;
  bool? enableDatabaseInspector;

  // Admin-specific features
  bool? enableAdminDebugPanel;
  bool? enableUserImpersonation;

  // Analytics and Monitoring
  bool? enableAnalytics;
  bool? enableCrashReporting;
  bool? enablePerformanceMonitoring;

  // API Configuration
  bool? enableApiCache;

  // UI Features
  bool? enableDarkMode;
  bool? enableAnimations;
  bool? enableDebugOverlay;

  // Feature Toggles
  bool? enableNewCheckoutFlow;
  bool? enableSocialLogin;
  bool? enablePushNotifications;

  // Page Scenarios for Demo
  bool? enableHomePage;
  bool? enableShopPage;
  bool? enableItemsPage;
  bool? enableProductDetailsPage;
  bool? enableBagPage;
  bool? enableFavoritesPage;
  bool? enableLoginPage;
  bool? enableProfilePage;
  bool? enableCommentsPage;

  EcFeatureFlag copyWith({
    bool? enableDebugMode,
    bool? enableApiLogging,
    bool? enableMockBackend,
    bool? enableDatabaseInspector,
    bool? enableAdminDebugPanel,
    bool? enableUserImpersonation,
    bool? enableAnalytics,
    bool? enableCrashReporting,
    bool? enablePerformanceMonitoring,
    bool? enableApiCache,
    bool? enableDarkMode,
    bool? enableAnimations,
    bool? enableDebugOverlay,
    bool? enableNewCheckoutFlow,
    bool? enableSocialLogin,
    bool? enablePushNotifications,
    bool? enableHomePage,
    bool? enableShopPage,
    bool? enableItemsPage,
    bool? enableProductDetailsPage,
    bool? enableBagPage,
    bool? enableFavoritesPage,
    bool? enableLoginPage,
    bool? enableProfilePage,
    bool? enableCommentsPage,
  }) {
    return EcFeatureFlag(
      enableDebugMode: enableDebugMode ?? this.enableDebugMode,
      enableApiLogging: enableApiLogging ?? this.enableApiLogging,
      enableMockBackend: enableMockBackend ?? this.enableMockBackend,
      enableDatabaseInspector:
          enableDatabaseInspector ?? this.enableDatabaseInspector,
      enableAdminDebugPanel:
          enableAdminDebugPanel ?? this.enableAdminDebugPanel,
      enableUserImpersonation:
          enableUserImpersonation ?? this.enableUserImpersonation,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      enableCrashReporting: enableCrashReporting ?? this.enableCrashReporting,
      enablePerformanceMonitoring:
          enablePerformanceMonitoring ?? this.enablePerformanceMonitoring,
      enableApiCache: enableApiCache ?? this.enableApiCache,
      enableDarkMode: enableDarkMode ?? this.enableDarkMode,
      enableAnimations: enableAnimations ?? this.enableAnimations,
      enableDebugOverlay: enableDebugOverlay ?? this.enableDebugOverlay,
      enableNewCheckoutFlow:
          enableNewCheckoutFlow ?? this.enableNewCheckoutFlow,
      enableSocialLogin: enableSocialLogin ?? this.enableSocialLogin,
      enablePushNotifications:
          enablePushNotifications ?? this.enablePushNotifications,
      enableHomePage: enableHomePage ?? this.enableHomePage,
      enableShopPage: enableShopPage ?? this.enableShopPage,
      enableItemsPage: enableItemsPage ?? this.enableItemsPage,
      enableProductDetailsPage:
          enableProductDetailsPage ?? this.enableProductDetailsPage,
      enableBagPage: enableBagPage ?? this.enableBagPage,
      enableFavoritesPage: enableFavoritesPage ?? this.enableFavoritesPage,
      enableLoginPage: enableLoginPage ?? this.enableLoginPage,
      enableProfilePage: enableProfilePage ?? this.enableProfilePage,
      enableCommentsPage: enableCommentsPage ?? this.enableCommentsPage,
    );
  }

  void setDebugMode({bool enable = true}) {
    enableDebugMode = enable;
    enableApiLogging = enable;
    enableMockBackend = enable;
    enableDatabaseInspector = enable;
    enableDebugOverlay = enable;
  }

  void setProductionMode({bool enable = true}) {
    enableDebugMode = !enable;
    enableApiLogging = !enable;
    enableMockBackend = !enable;
    enableDatabaseInspector = !enable;
    enableDebugOverlay = !enable;
    enableAnalytics = enable;
    enableCrashReporting = enable;
    enablePerformanceMonitoring = enable;
  }

  // Override the toString method to display the properties
  @override
  String toString() {
    return '''
    Feature Flags:
      - Enable Debug Mode: $enableDebugMode
      - Enable API Logging: $enableApiLogging
      - Enable Mock Backend: $enableMockBackend
      - Enable Database Inspector: $enableDatabaseInspector
      - Enable Admin Debug Panel: $enableAdminDebugPanel
      - Enable User Impersonation: $enableUserImpersonation
      - Enable Analytics: $enableAnalytics
      - Enable Crash Reporting: $enableCrashReporting
      - Enable Performance Monitoring: $enablePerformanceMonitoring
      - Enable API Cache: $enableApiCache
      - Enable Dark Mode: $enableDarkMode
      - Enable Animations: $enableAnimations
      - Enable Debug Overlay: $enableDebugOverlay
      - Enable New Checkout Flow: $enableNewCheckoutFlow
      - Enable Social Login: $enableSocialLogin
      - Enable Push Notifications: $enablePushNotifications
      - Enable Home Page: $enableHomePage
      - Enable Shop Page: $enableShopPage
      - Enable Items Page: $enableItemsPage
      - Enable Product Details Page: $enableProductDetailsPage
      - Enable Bag Page: $enableBagPage
      - Enable Favorites Page: $enableFavoritesPage
      - Enable Login Page: $enableLoginPage
      - Enable Profile Page: $enableProfilePage
      - Enable Comments Page: $enableCommentsPage
    ''';
  }
}
