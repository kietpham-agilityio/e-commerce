# Dependency Injection Guide for E-Commerce App

## Overview

This guide covers the dependency injection (DI) architecture used in the e-commerce application. The app uses **GetIt** as the service locator pattern, providing a clean and efficient way to manage dependencies across different build flavors and environments.

## Architecture

### Service Locator Pattern

The app follows the **Service Locator** pattern using **GetIt**, which provides:

- **Lazy Loading**: Services are created only when first accessed
- **Singleton Management**: Automatic lifecycle management
- **Type Safety**: Compile-time type checking
- **Easy Testing**: Simple service mocking and replacement

### Service Categories

```
EcLocator (Main Service Locator)
├── EcFlavor Integration (Flavor detection & management)
├── Core Services (App config, state, navigation)
├── Feature Services (Feature flags, configuration, theming)
├── API Services (HTTP client, auth, network)
└── Business Services (User, product, order, cart, payment)
```

## Core Components

### 1. EcLocator

The main service locator that manages all application services and integrates with EcFlavor.

**Key Features:**
- Centralized service registration and retrieval
- Integration with EcFlavor for automatic flavor management
- Environment-specific service setup
- Error handling and validation

**Usage:**
```dart
// Initialize all services
await EcLocator.initialize();

// Get any registered service
final userService = EcLocator.get<UserService>();
final apiService = EcLocator.get<ApiService>();
```

### 2. EcFlavor Integration

Direct integration with the EcFlavor package for environment-specific configurations.

**Features:**
- Automatic flavor detection
- Environment variable loading
- Flavor-specific service registration
- Feature flag management

## Service Registration

### Automatic Registration

Services are automatically registered during `EcLocator.initialize()`:

```dart
static Future<void> initialize() async {
  // Initialize flavor management first using EcFlavor
  await _initializeFlavor();
  
  // Register core application services
  _registerCoreServices();
  
  // Register feature services
  _registerFeatureServices();
  
  // Register API services
  _registerApiServices();
  
  // Register business logic services
  _registerBusinessServices();
}
```

### Service Categories

#### Core Services
```dart
static void _registerCoreServices() {
  _getIt.registerLazySingleton<AppConfigService>(() => AppConfigService());
  _getIt.registerLazySingleton<AppStateService>(() => AppStateService());
  _getIt.registerLazySingleton<NavigationService>(() => NavigationService());
}
```

#### Feature Services
```dart
static void _registerFeatureServices() {
  _getIt.registerLazySingleton<FeatureFlagService>(() => FeatureFlagService());
  _getIt.registerLazySingleton<ConfigurationService>(() => ConfigurationService());
  _getIt.registerLazySingleton<ThemeService>(() => ThemeService());
}
```

#### API Services
```dart
static void _registerApiServices() {
  _getIt.registerLazySingleton<HttpClientService>(() => HttpClientService());
  _getIt.registerLazySingleton<AuthService>(() => AuthService());
  _getIt.registerLazySingleton<NetworkService>(() => NetworkService());
}
```

#### Business Services
```dart
static void _registerBusinessServices() {
  _getIt.registerLazySingleton<UserService>(() => UserService());
  _getIt.registerLazySingleton<ProductService>(() => ProductService());
  _getIt.registerLazySingleton<OrderService>(() => OrderService());
  _getIt.registerLazySingleton<CartService>(() => CartService());
  _getIt.registerLazySingleton<PaymentService>(() => PaymentService());
}
```

## Flavor-Specific Services

### Automatic Flavor Detection

The system automatically detects the current build flavor using EcFlavor's built-in detection:

```dart
static Future<void> _initializeFlavor() async {
  try {
    // Use EcFlavor's automatic detection and initialization
    final detectedFlavor = await FlavorManager.initializeWithAutoDetection();
    
    // Register flavor-specific services
    _registerFlavorServices(detectedFlavor);
  } catch (e) {
    rethrow;
  }
}
```

### Environment Configuration

Flavor-specific environment variables are loaded automatically by EcFlavor:

```dart
// EcFlavor handles environment loading automatically
// No manual configuration needed in EcLocator
```

### Flavor-Specific Service Registration

Services are registered based on flavor configuration:

```dart
static void _registerFlavorServices(EcFlavor flavor) {
  // Register flavor-specific API service
  _registerApiService(flavor);
  
  // Register other flavor-specific services
  _registerOtherServices(flavor);
}

static void _registerOtherServices(EcFlavor flavor) {
  final config = FlavorConfig.getConfig(flavor);
  
  // Register logging service based on flavor configuration
  if (config.enableLogging) {
    _getIt.registerLazySingleton<LoggingService>(() => LoggingService());
  }
  
  // Register analytics service based on flavor configuration
  if (config.enableAnalytics) {
    _getIt.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
  }
  
  // Register crashlytics service based on flavor configuration
  if (config.enableCrashlytics) {
    _getIt.registerLazySingleton<CrashlyticsService>(() => CrashlyticsService());
  }
}
```

## Usage Patterns

### Basic Service Access

```dart
class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get services from the locator
    final productService = EcLocator.get<ProductService>();
    final cartService = EcLocator.get<CartService>();
    
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: productService.getProducts(),
        builder: (context, snapshot) {
          // Use services
        },
      ),
    );
  }
}
```

### Service Availability Check

```dart
// Check if a service is registered before using it
if (EcLocator.isRegistered<AnalyticsService>()) {
  final analytics = EcLocator.get<AnalyticsService>();
  analytics.track('screen_view', {'screen': 'product_list'});
}
```

### Flavor Information Access

```dart
// Get current flavor configuration
final config = EcLocator.getCurrentConfig();
final apiUrl = config.apiBaseUrl;
final appName = config.appName;

// Check if a feature is enabled for current flavor
if (EcLocator.isFeatureEnabled('analytics')) {
  // Enable analytics features
}

// Get current flavor
final flavor = EcLocator.getCurrentFlavor();
print('Current flavor: ${flavor.displayName}');
```

## Extension Methods

The `EcLocatorExtension` provides convenient access methods:

```dart
extension EcLocatorExtension on Object {
  T getService<T extends Object>() => EcLocator.get<T>();
  
  bool hasService<T extends Object>() => EcLocator.isRegistered<T>();
  
  FlavorEnvironment get currentFlavorConfig => EcLocator.getCurrentConfig();
  
  bool isFeatureEnabled(String feature) => EcLocator.isFeatureEnabled(feature);
  
  EcFlavor get currentFlavor => EcLocator.getCurrentFlavor();
}
```

**Usage:**
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use extension methods for cleaner code
    final userService = this.getService<UserService>();
    final hasPayment = this.hasService<PaymentService>();
    final config = this.currentFlavorConfig;
    
    return Container();
  }
}
```

## Testing

### Service Reset

```dart
// Reset all services for testing
EcLocator.reset();

// Re-initialize with test configuration
await EcLocator.initialize();
```

### Mock Services

```dart
// Register mock services for testing
GetIt.instance.registerLazySingleton<ApiService>(() => MockApiService());

// Run tests
// ...

// Reset to original services
EcLocator.reset();
await EcLocator.initialize();
```

### Test Setup

```dart
class MockApiService extends Mock implements ApiService {
  @override
  Future<List<Product>> getProducts() async {
    return [Product(id: '1', name: 'Test Product')];
  }
}

void main() {
  setUp(() {
    EcLocator.reset();
  });

  tearDown(() {
    EcLocator.reset();
  });

  test('should get products from service', () async {
    // Register mock service
    GetIt.instance.registerLazySingleton<ApiService>(() => MockApiService());
    
    // Initialize locator
    await EcLocator.initialize();
    
    // Test service access
    final productService = EcLocator.get<ProductService>();
    // ... test implementation
  });
}
```

## Error Handling

### Service Not Found

```dart
try {
  final service = EcLocator.get<NonExistentService>();
} catch (e) {
  if (e is StateError) {
    print('Service not registered: ${e.message}');
  }
}
```

### Not Initialized

```dart
try {
  final service = EcLocator.get<AppConfigService>();
} catch (e) {
  if (e is StateError && e.message.contains('not initialized')) {
    print('Call EcLocator.initialize() first');
  }
}
```

### Flavor Not Available

```dart
try {
  final config = EcLocator.getCurrentConfig();
} catch (e) {
  if (e is StateError && e.message.contains('Flavor not initialized')) {
    print('Flavor system not ready');
  }
}
```

## Best Practices

### 1. Service Registration
- Register services in appropriate categories
- Use lazy loading for expensive services
- Provide meaningful service names and interfaces

### 2. Service Access
- Always check if services are available before use
- Handle missing services gracefully
- Use extension methods for cleaner code

### 3. Flavor Management
- EcFlavor handles detection automatically
- Test with different flavors during development
- Use feature flags for flavor-specific features

### 4. Error Handling
- Wrap service access in try-catch blocks
- Provide meaningful error messages
- Log errors for debugging

### 5. Testing
- Reset services between tests
- Mock external dependencies
- Test with different flavor configurations

## Migration from Direct Service Usage

### Before (Direct service creation)

```dart
// Old way - direct service creation
final apiService = ApiService(
  baseUrl: 'https://api.example.com',
  timeout: Duration(seconds: 30),
);

// Old way - manual flavor detection
final flavor = Platform.environment['FLAVOR'] ?? 'dev';
final config = FlavorConfig.getConfig(flavor);
```

### After (Using EcLocator)

```dart
// New way - centralized service access
await EcLocator.initialize();

final apiService = EcLocator.get<ApiService>();
final config = EcLocator.getCurrentConfig();
```

## Troubleshooting

### Common Issues

1. **Service Not Found**
   - Ensure the service is registered in the appropriate registration method
   - Check that the service class exists and is properly imported

2. **Initialization Errors**
   - Verify that all required dependencies are available
   - Check EcFlavor configuration files
   - Ensure proper error handling in initialization

3. **Flavor Detection Issues**
   - EcFlavor handles detection automatically
   - Verify environment variables are set correctly
   - Check flavor-specific files exist

4. **Performance Issues**
   - Services are lazy-loaded by default
   - Use `reset()` sparingly in production
   - Monitor service creation and disposal

## Support

For issues with dependency injection:
1. Check this documentation
2. Review the service registration methods
3. Verify EcFlavor configuration
4. Check error logs for specific issues
5. Contact the development team for complex problems
