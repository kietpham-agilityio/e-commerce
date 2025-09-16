import '../ec_flavor.dart';
import 'feature_flag.dart';

/// Configuration for feature flags across different environments and flavors
class FeatureFlagConfigurations {
  /// Get default feature flags for development environment
  static List<FeatureFlag> getDevelopmentFlags(EcFlavor flavor) {
    const environment = FeatureFlagEnvironment.development;
    final flavorType =
        flavor.isAdmin ? FeatureFlagFlavor.admin : FeatureFlagFlavor.user;
    final now = DateTime.now();

    return [
      // Debug and development features
      FeatureFlag(
        key: 'debug_mode',
        name: 'Debug Mode',
        description:
            'Enable debug mode with additional logging and debugging features',
        type: FeatureFlagType.boolean,
        defaultValue: true,
        currentValue: true,
        isEnabled: true,
        isOverridable: true,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'debug', 'priority': 'high'},
      ),

      FeatureFlag(
        key: 'api_logging',
        name: 'API Logging',
        description: 'Enable detailed API request/response logging',
        type: FeatureFlagType.boolean,
        defaultValue: true,
        currentValue: true,
        isEnabled: true,
        isOverridable: true,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'logging', 'priority': 'medium'},
      ),

      FeatureFlag(
        key: 'mock_backend',
        name: 'Mock Backend',
        description: 'Use mock backend for development and testing',
        type: FeatureFlagType.boolean,
        defaultValue: true,
        currentValue: true,
        isEnabled: true,
        isOverridable: true,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'backend', 'priority': 'high'},
      ),

      FeatureFlag(
        key: 'database_inspector',
        name: 'Database Inspector',
        description: 'Enable database inspector for development',
        type: FeatureFlagType.boolean,
        defaultValue: true,
        currentValue: true,
        isEnabled: true,
        isOverridable: true,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'debug', 'priority': 'medium'},
      ),

      // Admin-specific features for development
      if (flavor.isAdmin) ...[
        FeatureFlag(
          key: 'admin_debug_panel',
          name: 'Admin Debug Panel',
          description: 'Show admin debug panel with system information',
          type: FeatureFlagType.boolean,
          defaultValue: true,
          currentValue: true,
          isEnabled: true,
          isOverridable: true,
          environment: environment,
          flavor: flavorType,
          createdAt: now,
          updatedAt: now,
          metadata: {'category': 'admin', 'priority': 'high'},
        ),

        FeatureFlag(
          key: 'user_impersonation',
          name: 'User Impersonation',
          description: 'Allow admin to impersonate other users',
          type: FeatureFlagType.boolean,
          defaultValue: true,
          currentValue: true,
          isEnabled: true,
          isOverridable: true,
          environment: environment,
          flavor: flavorType,
          createdAt: now,
          updatedAt: now,
          metadata: {'category': 'admin', 'priority': 'medium'},
        ),
      ],
    ];
  }

  /// Get default feature flags for staging environment
  static List<FeatureFlag> getStagingFlags(EcFlavor flavor) {
    const environment = FeatureFlagEnvironment.staging;
    final flavorType =
        flavor.isAdmin ? FeatureFlagFlavor.admin : FeatureFlagFlavor.user;
    final now = DateTime.now();

    return [
      // Staging-specific features
      FeatureFlag(
        key: 'debug_mode',
        name: 'Debug Mode',
        description:
            'Enable debug mode with additional logging and debugging features',
        type: FeatureFlagType.boolean,
        defaultValue: false,
        currentValue: false,
        isEnabled: false,
        isOverridable: true,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'debug', 'priority': 'high'},
      ),

      FeatureFlag(
        key: 'api_logging',
        name: 'API Logging',
        description: 'Enable detailed API request/response logging',
        type: FeatureFlagType.boolean,
        defaultValue: true,
        currentValue: true,
        isEnabled: true,
        isOverridable: true,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'logging', 'priority': 'medium'},
      ),

      FeatureFlag(
        key: 'mock_backend',
        name: 'Mock Backend',
        description: 'Use mock backend for development and testing',
        type: FeatureFlagType.boolean,
        defaultValue: false,
        currentValue: false,
        isEnabled: false,
        isOverridable: true,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'backend', 'priority': 'high'},
      ),

      FeatureFlag(
        key: 'database_inspector',
        name: 'Database Inspector',
        description: 'Enable database inspector for development',
        type: FeatureFlagType.boolean,
        defaultValue: false,
        currentValue: false,
        isEnabled: false,
        isOverridable: true,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'debug', 'priority': 'medium'},
      ),

      // Admin-specific features for staging
      if (flavor.isAdmin) ...[
        FeatureFlag(
          key: 'admin_debug_panel',
          name: 'Admin Debug Panel',
          description: 'Show admin debug panel with system information',
          type: FeatureFlagType.boolean,
          defaultValue: true,
          currentValue: true,
          isEnabled: true,
          isOverridable: true,
          environment: environment,
          flavor: flavorType,
          createdAt: now,
          updatedAt: now,
          metadata: {'category': 'admin', 'priority': 'high'},
        ),

        FeatureFlag(
          key: 'user_impersonation',
          name: 'User Impersonation',
          description: 'Allow admin to impersonate other users',
          type: FeatureFlagType.boolean,
          defaultValue: false,
          currentValue: false,
          isEnabled: false,
          isOverridable: true,
          environment: environment,
          flavor: flavorType,
          createdAt: now,
          updatedAt: now,
          metadata: {'category': 'admin', 'priority': 'medium'},
        ),
      ],
    ];
  }

  /// Get default feature flags for production environment
  static List<FeatureFlag> getProductionFlags(EcFlavor flavor) {
    const environment = FeatureFlagEnvironment.production;
    final flavorType =
        flavor.isAdmin ? FeatureFlagFlavor.admin : FeatureFlagFlavor.user;
    final now = DateTime.now();

    return [
      // Production features
      FeatureFlag(
        key: 'debug_mode',
        name: 'Debug Mode',
        description:
            'Enable debug mode with additional logging and debugging features',
        type: FeatureFlagType.boolean,
        defaultValue: false,
        currentValue: false,
        isEnabled: false,
        isOverridable: false,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'debug', 'priority': 'high'},
      ),

      FeatureFlag(
        key: 'api_logging',
        name: 'API Logging',
        description: 'Enable detailed API request/response logging',
        type: FeatureFlagType.boolean,
        defaultValue: false,
        currentValue: false,
        isEnabled: false,
        isOverridable: false,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'logging', 'priority': 'medium'},
      ),

      FeatureFlag(
        key: 'mock_backend',
        name: 'Mock Backend',
        description: 'Use mock backend for development and testing',
        type: FeatureFlagType.boolean,
        defaultValue: false,
        currentValue: false,
        isEnabled: false,
        isOverridable: false,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'backend', 'priority': 'high'},
      ),

      FeatureFlag(
        key: 'database_inspector',
        name: 'Database Inspector',
        description: 'Enable database inspector for development',
        type: FeatureFlagType.boolean,
        defaultValue: false,
        currentValue: false,
        isEnabled: false,
        isOverridable: false,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'debug', 'priority': 'medium'},
      ),

      // Admin-specific features for production
      if (flavor.isAdmin) ...[
        FeatureFlag(
          key: 'admin_debug_panel',
          name: 'Admin Debug Panel',
          description: 'Show admin debug panel with system information',
          type: FeatureFlagType.boolean,
          defaultValue: false,
          currentValue: false,
          isEnabled: false,
          isOverridable: true,
          environment: environment,
          flavor: flavorType,
          createdAt: now,
          updatedAt: now,
          metadata: {'category': 'admin', 'priority': 'high'},
        ),

        FeatureFlag(
          key: 'user_impersonation',
          name: 'User Impersonation',
          description: 'Allow admin to impersonate other users',
          type: FeatureFlagType.boolean,
          defaultValue: false,
          currentValue: false,
          isEnabled: false,
          isOverridable: true,
          environment: environment,
          flavor: flavorType,
          createdAt: now,
          updatedAt: now,
          metadata: {'category': 'admin', 'priority': 'medium'},
        ),
      ],

      // Common production features
      FeatureFlag(
        key: 'analytics_enabled',
        name: 'Analytics Enabled',
        description: 'Enable analytics tracking',
        type: FeatureFlagType.boolean,
        defaultValue: true,
        currentValue: true,
        isEnabled: true,
        isOverridable: false,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'analytics', 'priority': 'high'},
      ),

      FeatureFlag(
        key: 'crash_reporting',
        name: 'Crash Reporting',
        description: 'Enable crash reporting and error tracking',
        type: FeatureFlagType.boolean,
        defaultValue: true,
        currentValue: true,
        isEnabled: true,
        isOverridable: false,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'monitoring', 'priority': 'high'},
      ),

      FeatureFlag(
        key: 'performance_monitoring',
        name: 'Performance Monitoring',
        description: 'Enable performance monitoring and metrics collection',
        type: FeatureFlagType.boolean,
        defaultValue: true,
        currentValue: true,
        isEnabled: true,
        isOverridable: false,
        environment: environment,
        flavor: flavorType,
        createdAt: now,
        updatedAt: now,
        metadata: {'category': 'monitoring', 'priority': 'medium'},
      ),
    ];
  }

  /// Get feature flags for specific environment and flavor
  static List<FeatureFlag> getFlagsForEnvironmentAndFlavor({
    required FeatureFlagEnvironment environment,
    required FeatureFlagFlavor flavor,
  }) {
    // Create a dummy flavor for the configuration methods
    final ecFlavor =
        flavor == FeatureFlagFlavor.admin ? EcFlavor.admin : EcFlavor.user;

    switch (environment) {
      case FeatureFlagEnvironment.development:
        return getDevelopmentFlags(ecFlavor);
      case FeatureFlagEnvironment.staging:
        return getStagingFlags(ecFlavor);
      case FeatureFlagEnvironment.production:
        return getProductionFlags(ecFlavor);
    }
  }

  /// Get all feature flags for current environment and flavor
  static List<FeatureFlag> getCurrentFlags() {
    final flavor = EcFlavor.current;
    final environment =
        flavor.isDevelopment
            ? FeatureFlagEnvironment.development
            : flavor.isStaging
            ? FeatureFlagEnvironment.staging
            : FeatureFlagEnvironment.production;

    final flavorType =
        flavor.isAdmin ? FeatureFlagFlavor.admin : FeatureFlagFlavor.user;

    return getFlagsForEnvironmentAndFlavor(
      environment: environment,
      flavor: flavorType,
    );
  }
}

