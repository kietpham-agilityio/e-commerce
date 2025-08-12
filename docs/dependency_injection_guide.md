# Dependency Injection with EcLocator

This document explains how to use the dependency injection system with the `EcLocator` in the e-commerce application.

## Overview

The application uses the `get_it` package for dependency injection, combined with `EcLocator` for centralized service management and `ec_flavor` for environment-specific configuration. This allows for:

- **Unified service management**: All services accessible through a single interface
- **Flavor-aware service registration**: Services are registered based on the current build flavor
- **Environment-specific configuration**: Different configurations for dev, staging, and production
- **Loose coupling**: Services can be easily mocked and tested
- **Centralized service management**: All services are managed in one place

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Main App      │───▶│    EcLocator     │───▶│   ec_flavor     │
│                 │    │                  │    │   Package       │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                │
                                ▼
                       ┌──────────────────┐
                       │ FlavorService    │
                       │ Locator          │
                       └──────────────────┘
                                │
                                ▼
                       ┌──────────────────┐
                       │   get_it         │
                       │   Container      │
                       └──────────────────┘
                                │
                                ▼
                       ┌──────────────────┐
                       │   Services       │
                       │   (API, Logging, │
                       │    Analytics,    │
                       │    Business)     │
                       └──────────────────┘
```

## Setup

### 1. Dependencies

The following dependencies are already added to `pubspec.yaml`:

```yaml
dependencies:
  get_it: ^7.6.7
  flutter_dotenv: ^5.2.1
  ec_flavor:
    path: ../packages/ec_core/ec_flavor
```

### 2. Service Initialization

In your main function, initialize the dependency injection:

```dart
import 'core/services/ec_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize all application services
    await EcLocator.initialize();
    runApp(const MyApp());
  } catch (e) {
    // Exit app if initialization fails
    rethrow;
  }
}
```

## Usage

### 1. Getting Services

Use the `EcLocator` to get registered services:

```dart
// Get a service by type
final apiService = EcLocator.get<ApiService>();
final userService = EcLocator.get<UserService>();

// Check if a service is registered
if (EcLocator.isRegistered<ApiService>()) {
  // Service is available
}
```

### 2. Flavor-Specific Access

Access flavor-specific configuration and features:

```dart
// Get current flavor configuration
final config = EcLocator.getCurrentConfig();
final appName = config.appName;
final apiUrl = config.apiBaseUrl;

// Check if a feature is enabled
final isLoggingEnabled = EcLocator.isFeatureEnabled('logging');
final isAnalyticsEnabled = EcLocator.isFeatureEnabled('analytics');

// Get current flavor
final flavor = EcLocator.getCurrentFlavor();
final flavorName = flavor.displayName;
```

### 3. Service Registration

Services are automatically registered during `EcLocator.initialize()`:

- **Flavor Services**: Via `FlavorServiceLocator.initialize()`
- **Core Services**: AppConfigService, AppStateService, NavigationService
- **Feature Services**: FeatureFlagService, ConfigurationService, ThemeService
- **API Services**: HttpClientService, AuthService, NetworkService
- **Business Services**: UserService, ProductService, OrderService, CartService, PaymentService

## Service Examples

### 1. API Service

```dart
class MyRepository {
  final ApiService _apiService;
  
  MyRepository({ApiService? apiService}) 
    : _apiService = apiService ?? EcLocator.get<ApiService>();
  
  Future<Map<String, dynamic>> fetchData() async {
    return await _apiService.get('/data');
  }
}
```

### 2. Business Service

```dart
class ProductRepository {
  final ProductService _productService;
  
  ProductRepository({ProductService? productService})
    : _productService = productService ?? EcLocator.get<ProductService>();
  
  Future<List<Map<String, dynamic>>> getProducts() async {
    return await _productService.getProducts();
  }
}
```

### 3. Widget Usage

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get services through dependency injection
    final apiService = EcLocator.get<ApiService>();
    final config = EcLocator.getCurrentConfig();
    
    return Card(
      child: Column(
        children: [
          Text('Environment: ${config.appName}'),
          Text('API URL: ${config.apiBaseUrl}'),
          ElevatedButton(
            onPressed: () => _testApi(apiService),
            child: Text('Test API'),
          ),
        ],
      ),
    );
  }
  
  void _testApi(ApiService apiService) async {
    try {
      final response = await apiService.get('/test');
      // Handle response
    } catch (e) {
      // Handle error
    }
  }
}
```

## Flavor Detection

The system automatically detects the current flavor using multiple methods:

1. **Build Arguments**: Check for `FLAVOR` environment variable
2. **Flavor Files**: Check for existence of flavor-specific files
3. **Default Fallback**: Default to development if no flavor is detected

### Environment Variables

Set the `FLAVOR` environment variable when building:

```bash
# Development
export FLAVOR=dev && flutter build apk --flavor dev

# Staging
export FLAVOR=staging && flutter build apk --flavor staging

# Production
export FLAVOR=prod && flutter build apk --flavor prod
```

## Testing

### 1. Service Mocking

Services can be easily mocked for testing:

```dart
class MockApiService extends Mock implements ApiService {}

void main() {
  test('should fetch data successfully', () async {
    // Arrange
    final mockApiService = MockApiService();
    final repository = MyRepository(apiService: mockApiService);
    
    when(mockApiService.get('/data')).thenAnswer(
      (_) async => {'success': true, 'data': 'test data'}
    );
    
    // Act
    final result = await repository.fetchData();
    
    // Assert
    expect(result['success'], true);
    expect(result['data'], 'test data');
  });
}
```

### 2. Service Reset

Reset services between tests:

```dart
void main() {
  tearDown(() {
    EcLocator.reset();
  });
  
  // Your tests...
}
```

## Configuration

### 1. Environment Files

The system automatically loads the appropriate environment file:

- **Development**: `../packages/ec_core/ec_flavor/env.dev`
- **Staging**: `../packages/ec_core/ec_flavor/env.staging`
- **Production**: `../packages/ec_core/ec_flavor/env.prod`

### 2. Feature Flags

Check if features are enabled for the current flavor:

```dart
// Check individual features
final isLoggingEnabled = EcLocator.isFeatureEnabled('logging');
final isAnalyticsEnabled = EcLocator.isFeatureEnabled('analytics');
final isCrashlyticsEnabled = EcLocator.isFeatureEnabled('crashlytics');

// Get current configuration
final config = EcLocator.getCurrentConfig();
final timeout = config.timeoutSeconds;
final maxRetries = config.maxRetries;
```

## Best Practices

### 1. Service Registration

- Services are automatically registered during initialization
- Use lazy singletons for expensive services
- Use singletons for services that should be shared across the app

### 2. Error Handling

- Handle service initialization errors gracefully
- Provide fallback values for required services
- Use proper error handling in service implementations

### 3. Testing

- Mock services in unit tests
- Reset services between tests
- Test different flavor configurations

### 4. Performance

- Services are registered lazily when first accessed
- Avoid circular dependencies
- Keep service registration simple and focused

## Troubleshooting

### Common Issues

1. **Service Not Registered**: Check if the service is registered in the appropriate category
2. **Environment File Not Found**: Verify the environment file path and permissions
3. **Flavor Not Detected**: Check build arguments and environment variables

### Debug Information

Check service registration status:

```dart
// Check if a service is registered
final hasApiService = EcLocator.isRegistered<ApiService>();
print('API Service registered: $hasApiService');

// Check if EcLocator is initialized
final isInitialized = EcLocator.isInitialized;
print('EcLocator initialized: $isInitialized');
```

## Migration Guide

### From Direct Service Usage

**Before (Direct Usage):**
```dart
class MyService {
  void doSomething() {
    final response = ApiService.get('/endpoint');
  }
}
```

**After (Dependency Injection):**
```dart
class MyService {
  final ApiService _apiService;
  
  MyService({ApiService? apiService})
    : _apiService = apiService ?? EcLocator.get<ApiService>();
  
  void doSomething() {
    final response = _apiService.get('/endpoint');
  }
}
```

### From FlavorServiceLocator Usage

**Before (FlavorServiceLocator):**
```dart
import 'core/services/flavor_service_locator.dart';

// Initialize
await FlavorServiceLocator.initialize();

// Access services
final config = FlavorServiceLocator.getCurrentConfig();
final apiService = FlavorServiceLocator.get<ApiService>();
```

**After (EcLocator):**
```dart
import 'core/services/ec_locator.dart';

// Initialize (includes FlavorServiceLocator automatically)
await EcLocator.initialize();

// Access services (same interface)
final config = EcLocator.getCurrentConfig();
final apiService = EcLocator.get<ApiService>();

// Plus access to additional services
final userService = EcLocator.get<UserService>();
final themeService = EcLocator.get<ThemeService>();
```

## Service Categories

### Core Services
- **AppConfigService**: Application configuration and metadata
- **AppStateService**: Global application state management
- **NavigationService**: App routing and navigation

### Feature Services
- **FeatureFlagService**: Feature toggle management
- **ConfigurationService**: App settings and preferences
- **ThemeService**: UI theming and appearance

### API Services
- **HttpClientService**: HTTP request handling
- **AuthService**: Authentication and authorization
- **NetworkService**: Network connectivity monitoring

### Business Services
- **UserService**: User management and profiles
- **ProductService**: Product catalog and management
- **OrderService**: Order processing and management
- **CartService**: Shopping cart functionality
- **PaymentService**: Payment processing

This dependency injection system provides a clean, testable, and maintainable architecture for the e-commerce application while leveraging the power of the `EcLocator` for centralized service management and `ec_flavor` for environment-specific configuration.
