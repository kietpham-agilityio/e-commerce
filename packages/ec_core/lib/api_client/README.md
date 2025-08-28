# Refactored API Client System

A clean, organized, and easy-to-use API client system for Flutter applications, built on top of Dio with proper error handling using the existing `Failure` and `ApiClientError` classes.

## 🏗️ **Architecture Overview**

```
api_client/
├── core/                    # Core API client components
│   ├── api_client.dart     # Main API client class
│   ├── api_config.dart     # Abstract configuration class
│   ├── app_api_config.dart # Concrete implementation example
│   ├── env_config.dart     # Environment configuration helper
│   ├── base_api_service.dart # Base service class
│   └── api_client_factory.dart # Factory for creating clients
├── services/               # Specific API services
│   └── product_api_service.dart # Example product service
├── examples/               # Usage examples
│   ├── usage_example.dart # Comprehensive examples
│   └── app_integration_example.dart # App integration examples
├── apis/                   # Existing error handling (kept)
│   ├── api_client_error.dart
│   ├── failure.dart
│   └── api_internal_error_code.dart
└── api_client.dart         # Barrel export file
```

## 🚀 **Key Features**

✅ **Clean Architecture** - Well-organized folder structure  
✅ **Easy Configuration** - Multiple ways to create API clients  
✅ **Configurable URLs** - Base URLs configurable in main app  
✅ **Error Handling** - Integrates with existing `Failure` class  
✅ **Type Safety** - Generic methods with proper typing  
✅ **Factory Pattern** - Easy client creation with different configs  
✅ **Service Layer** - Extendable base service class  
✅ **Environment Support** - Dev/staging/prod configuration  
✅ **Flavor Support** - Admin/user app variant support  
✅ **Authentication** - Built-in auth header management  
✅ **File Operations** - Upload/download with progress tracking  
✅ **Interceptors** - Easy to add custom interceptors  

## ⚙️ **Configuration Setup**

### **Base URL Configuration**

The API client system is designed to be configurable from your main app. You have several options:

#### **Option 1: Use the provided EnvConfig class**

```dart
// Simply update the URLs in the EnvConfig class
class EnvConfig {
  static const String userDevUrl = 'https://api-dev.myapp.com';
  static const String userStagingUrl = 'https://api-staging.myapp.com';
  static const String userProdUrl = 'https://api.myapp.com';
  
  static const String adminDevUrl = 'https://admin-api-dev.myapp.com';
  static const String adminStagingUrl = 'https://admin-api-staging.myapp.com';
  static const String adminProdUrl = 'https://admin-api.myapp.com';
}
```

#### **Option 2: Create your own configuration class**

```dart
// lib/config/api_config.dart
import 'package:ec_core/ec_core.dart';

class MyAppApiConfig extends ApiConfig {
  // Development URLs
  static const String _devBaseUrl = 'https://api-dev.myapp.com';
  static const String _adminDevBaseUrl = 'https://admin-api-dev.myapp.com';
  
  // Staging URLs
  static const String _stagingBaseUrl = 'https://api-staging.myapp.com';
  static const String _adminStagingBaseUrl = 'https://admin-api-staging.myapp.com';
  
  // Production URLs
  static const String _prodBaseUrl = 'https://api.myapp.com';
  static const String _adminProdBaseUrl = 'https://admin-api.myapp.com';
  
  @override
  static String getBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
        return _devBaseUrl;
      case 'staging':
        return _stagingBaseUrl;
      case 'prod':
        return _prodBaseUrl;
      default:
        return _devBaseUrl;
    }
  }
  
  @override
  static String getAdminBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
        return _adminDevBaseUrl;
      case 'staging':
        return _adminStagingBaseUrl;
      case 'prod':
        return _adminProdBaseUrl;
      default:
        return _adminDevBaseUrl;
    }
  }
}
```

#### **Option 3: Use environment variables**

```dart
// Build command:
// flutter build --dart-define=API_DEV_URL=https://dev-api.myapp.com
// flutter build --dart-define=API_STAGING_URL=https://staging-api.myapp.com
// flutter build --dart-define=API_PROD_URL=https://prod-api.myapp.com

class EnvironmentApiConfig extends ApiConfig {
  static const String _devBaseUrl = String.fromEnvironment(
    'API_DEV_URL',
    defaultValue: 'https://api-dev.example.com',
  );
  
  static const String _stagingBaseUrl = String.fromEnvironment(
    'API_STAGING_URL',
    defaultValue: 'https://api-staging.example.com',
  );
  
  static const String _prodBaseUrl = String.fromEnvironment(
    'API_PROD_URL',
    defaultValue: 'https://api.example.com',
  );
  
  @override
  static String getBaseUrl(String environment) {
    switch (environment.toLowerCase()) {
      case 'dev':
        return _devBaseUrl;
      case 'staging':
        return _stagingBaseUrl;
      case 'prod':
        return _prodBaseUrl;
      default:
        return _devBaseUrl;
    }
  }
  
  // Similar for admin URLs...
}
```

#### **Option 4: Use configuration file**

```dart
// assets/config/api_config.json
{
  "user_dev_url": "https://api-dev.myapp.com",
  "user_staging_url": "https://api-staging.myapp.com",
  "user_prod_url": "https://api.myapp.com",
  "admin_dev_url": "https://admin-api-dev.myapp.com",
  "admin_staging_url": "https://admin-api-staging.myapp.com",
  "admin_prod_url": "https://admin-api.myapp.com"
}

// Load configuration
class FileApiConfig extends ApiConfig {
  static Map<String, String>? _config;
  
  static Future<void> loadConfig() async {
    final configFile = await rootBundle.loadString('assets/config/api_config.json');
    _config = json.decode(configFile);
  }
  
  @override
  static String getBaseUrl(String environment) {
    if (_config == null) {
      throw StateError('Config not loaded. Call loadConfig() first.');
    }
    
    final key = 'user_${environment.toLowerCase()}_url';
    return _config![key] ?? 'https://api-dev.example.com';
  }
  
  // Similar for admin URLs...
}
```

## 📖 **Quick Start**

### 1. **Configure Base URLs**

First, choose one of the configuration options above and set up your base URLs.

### 2. **Create API Client**

```dart
import 'package:ec_core/ec_core.dart';

// Method 1: Using factory with environment
final apiClient = ApiClientFactory.createWithEnvironment(
  environment: 'dev',
  additionalHeaders: {'X-API-Key': 'your-key'},
);

// Method 2: Using factory with EcFlavor (admin/user variant)
final apiClient = ApiClientFactory.createWithFlavor(
  flavor: EcFlavor.user, // or EcFlavor.admin
  additionalHeaders: {'X-API-Key': 'your-key'},
);

// Method 3: Create for current flavor (automatically detects admin/user)
final apiClient = ApiClientFactory.createForCurrentFlavor(
  additionalHeaders: {'X-API-Key': 'your-key'},
);

// Method 4: Quick methods for specific flavors
final adminClient = ApiClientFactory.createAdmin(environment: 'dev');
final userClient = ApiClientFactory.createUser(environment: 'staging');

// Method 5: With authentication
final authClient = ApiClientFactory.createWithAuth(
  token: 'your-jwt-token',
  environment: 'dev',
);

// Method 6: With authentication and specific flavor
final authFlavorClient = ApiClientFactory.createWithAuthAndFlavor(
  token: 'your-jwt-token',
  flavor: EcFlavor.admin,
);
```

### 3. **Use API Client Directly**

```dart
// GET request
final userData = await apiClient.get<Map<String, dynamic>>('/users/1');

// POST request
final createdUser = await apiClient.post<Map<String, dynamic>>(
  '/users',
  data: {'name': 'John', 'email': 'john@example.com'},
);

// PUT request
final updatedUser = await apiClient.put<Map<String, dynamic>>(
  '/users/1',
  data: {'name': 'John Updated'},
);

// DELETE request
await apiClient.delete<dynamic>('/users/1');

// File upload
final formData = FormData.fromMap({
  'file': await MultipartFile.fromFile('/path/to/file.jpg'),
});
final uploadResult = await apiClient.uploadFile<dynamic>('/upload', formData: formData);
```

### 4. **Create API Service**

```dart
class UserApiService extends BaseApiService {
  UserApiService(ApiClient apiClient) : super(apiClient);

  Future<List<User>> getUsers() async {
    return safeApiCall(() async {
      final response = await apiClient.get<dynamic>('/users');
      return handleListResponse(response, User.fromJson);
    });
  }

  Future<User> createUser(User user) async {
    return safeApiCall(() async {
      final response = await apiClient.post<dynamic>(
        '/users',
        data: user.toJson(),
      );
      return handleResponse(response, User.fromJson);
    });
  }
}
```

### 5. **Handle Authentication**

```dart
// Add auth token
apiClient.setAuthorizationHeader('Bearer $token');

// Remove auth token
apiClient.removeAuthorizationHeader();

// Or use service methods
userService.addAuthHeader(token);
userService.removeAuthHeader();
```

### 6. **Error Handling**

```dart
try {
  final users = await userService.getUsers();
  // Handle success
} on Failure catch (failure) {
  print('API Error: ${failure.message}');
  if (failure.noConnectionData != null) {
    print('Error details: ${failure.noConnectionData}');
  }
} catch (e) {
  print('Unexpected error: $e');
}
```

## ⚙️ **Configuration Options**

### **Environment Configuration**

```dart
// Environment-based URLs
final devClient = ApiClientFactory.createWithEnvironment(environment: 'dev');
final stagingClient = ApiClientFactory.createWithEnvironment(environment: 'staging');
final prodClient = ApiClientFactory.createWithEnvironment(environment: 'prod');

// Custom timeouts
final client = ApiClientFactory.createWithEnvironment(
  environment: 'dev',
  connectTimeout: Duration(seconds: 60),
  receiveTimeout: Duration(seconds: 60),
  sendTimeout: Duration(seconds: 60),
);
```

### **Flavor Configuration (Admin/User Variants)**

```dart
// Create client for specific flavor
final adminClient = ApiClientFactory.createAdmin(environment: 'dev');
final userClient = ApiClientFactory.createUser(environment: 'staging');

// Create client for current flavor (automatically detected)
final currentFlavorClient = ApiClientFactory.createForCurrentFlavor();

// Check current flavor
if (ApiConfig.isCurrentFlavorAdmin) {
  print('Running admin version');
} else if (ApiConfig.isCurrentFlavorUser) {
  print('Running user version');
}

// Get current flavor info
final currentFlavor = EcFlavor.current;
print('Flavor: ${currentFlavor.name}');
print('Environment: ${currentFlavor.environment}');
print('Base URL: ${currentFlavor.apiBaseUrl}');
```

### **Custom Headers**

```dart
// Add headers
apiClient.addHeader('X-Custom-Header', 'value');

// Update multiple headers
apiClient.updateHeaders({
  'X-User-ID': '12345',
  'X-Session-ID': 'session-123',
});

// Remove specific header
apiClient.removeHeader('X-Custom-Header');

// Clear all headers
apiClient.clearHeaders();
```

### **Custom Interceptors**

```dart
// Add custom interceptor
apiClient.appendInterceptors([
  InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['X-Request-Time'] = DateTime.now().toIso8601String();
      handler.next(options);
    },
  ),
]);
```

## 🔧 **Advanced Usage**

### **Pagination Support**

```dart
final paginatedProducts = await productService.getProductsPaginated(
  page: 1,
  limit: 20,
  category: 'electronics',
);

print('Total: ${paginatedProducts.pagination.total}');
print('Current page: ${paginatedProducts.pagination.page}');
print('Has next: ${paginatedProducts.pagination.hasNext}');
print('Next page: ${paginatedProducts.pagination.nextPage}');
```

### **Progress Tracking**

```dart
// Upload with progress
final result = await apiClient.uploadFile<dynamic>(
  '/upload',
  formData: formData,
  onSendProgress: (sent, total) {
    final progress = (sent / total * 100).toStringAsFixed(0);
    print('Upload progress: $progress%');
  },
);

// Download with progress
final result = await apiClient.downloadFile(
  url,
  savePath,
  onReceiveProgress: (received, total) {
    final progress = (received / total * 100).toStringAsFixed(0);
    print('Download progress: $progress%');
  },
);
```

### **Safe API Calls**

```dart
// Wrapper for safe API calls
Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    return await apiCall();
  } on Failure {
    rethrow;
  } catch (e) {
    throw Failure('Unexpected error: $e');
  }
}

// Usage
final users = await safeApiCall(() async {
  final response = await apiClient.get<dynamic>('/users');
  return handleListResponse(response, User.fromJson);
});
```

## 🏭 **Factory Methods**

The `ApiClientFactory` provides multiple ways to create API clients:

- `createWithEnvironment()` - Environment-based configuration
- `createWithFlavor()` - EcFlavor-based configuration (admin/user)
- `createForCurrentFlavor()` - Current flavor (automatically detected)
- `createWithCustomUrl()` - Custom base URL
- `createDefault()` - Default configuration
- `createDev()` - Development environment
- `createStaging()` - Staging environment
- `createProd()` - Production environment
- `createAdmin()` - Admin flavor
- `createUser()` - User flavor
- `createWithAuth()` - With authentication token
- `createWithAuthAndFlavor()` - With authentication and specific flavor
- `createWithInterceptors()` - With custom interceptors
- `createWithInterceptorsAndFlavor()` - With interceptors and specific flavor

## 📱 **Flutter Integration**

### **In Widgets**

```dart
class ProductListWidget extends StatefulWidget {
  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  late final ApiClient _apiClient;
  late final ProductApiService _productService;

  @override
  void initState() {
    super.initState();
    // Automatically detect current flavor (admin/user)
    _apiClient = ApiClientFactory.createForCurrentFlavor();
    _productService = ProductApiService(_apiClient);
  }

  Future<void> loadProducts() async {
    try {
      final products = await _productService.getProducts(page: 1, limit: 20);
      setState(() {
        // Update UI with products
      });
    } on Failure catch (failure) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${failure.message}')),
      );
    }
  }

  @override
  void dispose() {
    _apiClient.dispose();
    super.dispose();
  }
}
```

### **Dependency Injection**

```dart
// Using GetIt or similar DI container
final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<ApiClient>(() {
    // Automatically detect current flavor
    return ApiClientFactory.createForCurrentFlavor();
  });

  getIt.registerLazySingleton<ProductApiService>(() {
    return ProductApiService(getIt<ApiClient>());
  });
}
```

## 🔒 **Security Features**

- **Authentication**: Built-in auth header management
- **HTTPS**: Supports secure connections
- **Header Management**: Easy to add/remove security headers
- **Token Refresh**: Can be implemented with interceptors
- **Flavor Isolation**: Admin and user variants use different API endpoints

## 📊 **Performance Features**

- **Connection Pooling**: Dio handles connection reuse
- **Request Cancellation**: Support for canceling long-running requests
- **Progress Tracking**: Real-time upload/download progress
- **Timeout Management**: Configurable timeouts for different environments

## 🧪 **Testing Support**

```dart
// Mock API client for testing
class MockApiClient extends ApiClient {
  MockApiClient() : super(BaseOptions(baseUrl: 'https://test.api.com'));

  @override
  Future<T> get<T>(String uri, {Map<String, dynamic>? queryParameters, ...}) async {
    // Return mock data
    return mockData as T;
  }
}

// Test with mock
final mockClient = MockApiClient();
final productService = ProductApiService(mockClient);
```

## 📚 **Best Practices**

1. **Always dispose**: Call `apiClient.dispose()` when done
2. **Use services**: Extend `BaseApiService` for specific endpoints
3. **Handle errors**: Always catch `Failure` exceptions
4. **Type safety**: Use generic types for better type safety
5. **Environment config**: Use environment-based configuration
6. **Flavor awareness**: Use `createForCurrentFlavor()` for automatic detection
7. **Progress tracking**: Use progress callbacks for better UX
8. **Interceptors**: Use interceptors for cross-cutting concerns
9. **Configuration**: Keep base URLs configurable and separate from code

## 🔄 **Migration from Old System**

The refactored system maintains compatibility with existing code:

```dart
// Old way (still works)
final apiClient = ApiClient(BaseOptions(baseUrl: 'https://api.example.com'));

// New way (recommended)
final apiClient = ApiClientFactory.createWithEnvironment(environment: 'dev');

// Flavor-aware way (best practice)
final apiClient = ApiClientFactory.createForCurrentFlavor();
```

## 📖 **Examples**

See `examples/usage_example.dart` for comprehensive examples of:
- Different client creation methods
- EcFlavor usage (admin/user variants)
- API service usage
- Error handling
- Authentication
- File operations
- Custom interceptors
- Widget integration
- Flavor-aware client creation

See `examples/app_integration_example.dart` for:
- How to configure base URLs in your main app
- Different configuration strategies
- Environment variable usage
- Configuration file loading
- Dependency injection patterns

## 🆘 **Support**

The refactored system integrates seamlessly with your existing:
- `Failure` class for error handling
- `ApiClientError` for detailed error information
- `ApiInternalErrorCode` for error codes
- `EcFlavor` for admin/user app variants
- Existing API services and DTOs

## 🌟 **EcFlavor Integration**

The system properly integrates with your `EcFlavor` system:

- **Admin Variant**: Uses admin-specific API endpoints
- **User Variant**: Uses user-specific API endpoints
- **Environment Support**: Each flavor supports dev/staging/prod environments
- **Automatic Detection**: `createForCurrentFlavor()` automatically detects the current flavor
- **Flavor-Specific URLs**: Different base URLs for admin and user variants

## 🔧 **Configuration Best Practices**

1. **Keep URLs configurable**: Don't hardcode URLs in your code
2. **Use environment variables**: For CI/CD and deployment flexibility
3. **Separate concerns**: Keep configuration separate from business logic
4. **Version control**: Don't commit production URLs to version control
5. **Testing**: Use different URLs for testing environments
6. **Documentation**: Document your configuration structure
7. **Validation**: Validate URLs at startup
8. **Fallbacks**: Provide sensible defaults for missing configuration
