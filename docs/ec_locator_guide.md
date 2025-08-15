# E-Commerce Service Locator Guide

## Overview

The `EcLocator` is the main service locator for the entire e-commerce application. It serves as a centralized hub that integrates with `EcFlavor` for flavor management and provides access to all application services through a unified interface.

## Architecture

```
EcLocator (Main service locator)
├── EcFlavor Integration (Flavor detection & management)
├── Core Services (App config, state, navigation)
├── Feature Services (Feature flags, configuration, theming)
├── API Services (HTTP client, auth, network)
└── Business Services (User, product, order, cart, payment)
```

## Key Features

- **Centralized Service Management**: Single point of access for all application services
- **EcFlavor Integration**: Leverages EcFlavor package for environment-specific configurations
- **Dependency Injection**: Uses GetIt for efficient service registration and retrieval
- **Lazy Loading**: Services are created only when first accessed
- **Error Handling**: Comprehensive error handling with meaningful error messages
- **Testing Support**: Easy service reset for unit testing

## Initialization

### Basic Initialization

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize all services (including flavor management)
  await EcLocator.initialize();
  
  runApp(MyApp());
}
```

### Initialization Process

The `EcLocator.initialize()` method performs the following steps:

1. **Flavor Management**: Uses EcFlavor's automatic detection and initialization
2. **Service Registration**: Registers all application services
3. **Flavor Services**: Registers flavor-specific services based on configuration

## Service Registration

### Core Services

```dart
// Automatically registered during initialization
final appConfig = EcLocator.get<AppConfigService>();
final appState = EcLocator.get<AppStateService>();
final navigation = EcLocator.get<NavigationService>();
```

### Feature Services

```dart
// Feature flag management
final featureFlags = EcLocator.get<FeatureFlagService>();
final isEnabled = featureFlags.isFeatureEnabled('dark_mode');

// Configuration management
final config = EcLocator.get<ConfigurationService>();
final apiUrl = config.getString('api_url');

// Theme management
final theme = EcLocator.get<ThemeService>();
final currentTheme = theme.currentTheme;
```

### API Services

```dart
// HTTP client
final httpClient = EcLocator.get<HttpClientService>();
final response = await httpClient.get('/api/products');

// Authentication
final auth = EcLocator.get<AuthService>();
final isLoggedIn = auth.isAuthenticated;

// Network connectivity
final network = EcLocator.get<NetworkService>();
final isConnected = network.isConnected;
```

### Business Services

```dart
// User management
final userService = EcLocator.get<UserService>();
final currentUser = await userService.getCurrentUser();

// Product management
final productService = EcLocator.get<ProductService>();
final products = await productService.getProducts();

// Order management
final orderService = EcLocator.get<OrderService>();
final orders = await orderService.getOrders();

// Shopping cart
final cartService = EcLocator.get<CartService>();
final cartItems = cartService.items;

// Payment processing
final paymentService = EcLocator.get<PaymentService>();
final success = await paymentService.processPayment(paymentData);
```

## Flavor Management

### Automatic Flavor Detection

The system automatically detects the current build flavor using EcFlavor's built-in detection:

```dart
// EcLocator automatically uses EcFlavor for flavor management
await EcLocator.initialize();

// Get current flavor
final flavor = EcLocator.getCurrentFlavor();

// Get flavor configuration
final config = EcLocator.getCurrentConfig();

// Check feature availability
final isFeatureEnabled = EcLocator.isFeatureEnabled('analytics');
```

### Flavor-Specific Services

The locator automatically registers flavor-specific services based on the current configuration:

- **Development**: Full logging, debugging, and development tools
- **Staging**: Limited logging, analytics enabled, crashlytics enabled
- **Production**: Minimal logging, analytics enabled, crashlytics enabled

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

## Extension Methods

The `EcLocatorExtension` provides convenient access methods:

```dart
// Get service directly
final userService = this.getService<UserService>();

// Check service availability
if (this.hasService<PaymentService>()) {
  final payment = this.getService<PaymentService>();
}

// Access flavor information
final config = this.currentFlavorConfig;
final flavor = this.currentFlavor;
final isEnabled = this.isFeatureEnabled('feature_name');
```

## Testing

### Service Reset

```dart
// Reset all services (useful for testing)
EcLocator.reset();

// Re-initialize for next test
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

## Best Practices

### 1. Initialization Order
- Always call `EcLocator.initialize()` before accessing any services
- Initialize in `main()` or app startup
- Handle initialization errors gracefully

### 2. Service Access
- Use `EcLocator.get<T>()` for service retrieval
- Check service availability with `EcLocator.isRegistered<T>()`
- Handle missing services gracefully

### 3. Flavor Management
- EcFlavor handles all flavor detection automatically
- Use feature flags for flavor-specific features
- Test with different flavors during development

### 4. Error Handling
- Always wrap service access in try-catch blocks
- Provide meaningful error messages to users
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

For issues with the service locator:
1. Check this documentation
2. Review the service registration methods
3. Verify EcFlavor configuration
4. Check error logs for specific issues
5. Contact the development team for complex problems
