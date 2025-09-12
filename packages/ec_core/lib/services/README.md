# Services Module

This module contains all service implementations for the E-Commerce application, organized by functionality and purpose.

## Structure

```text
services/
├── core/                    # Core service interfaces and base classes
│   ├── base_service.dart    # Base service class for DI
│   └── core.dart           # Core services exports
├── examples/               # Example service implementations
│   ├── user_service.dart   # User management service
│   ├── product_service.dart # Product management service
│   ├── auth_service.dart   # Authentication service
│   ├── analytics_service.dart # Analytics tracking service
│   └── examples.dart       # Example services exports
└── services.dart          # Main services module exports
```

## Core Services

### BaseService

The `BaseService` class provides a common interface for all services in the application:

```dart
abstract class BaseService {
  /// Initialize the service
  Future<void> initialize() async {}

  /// Dispose the service
  Future<void> dispose() async {}
}
```

All services should extend this class to ensure proper lifecycle management through the DI system.

## Example Services

The `examples/` folder contains example implementations demonstrating how to:

- Integrate with the DI system
- Use API clients for HTTP requests
- Implement logging with Talker
- Handle errors properly
- Manage service lifecycle

### UserService

Example service for user management operations:

```dart
class UserService extends BaseService {
  late final ApiClient _apiClient;
  late final Talker _logger;

  @override
  Future<void> initialize() async {
    _apiClient = DI.apiClient;
    _logger = DI.logger;
    _logger.info('UserService initialized');
  }

  Future<List<User>> getUsers() async {
    // Implementation
  }
}
```

### ProductService

Example service for product management with pagination support.

### AuthService

Example service for authentication operations including login/logout.

### AnalyticsService

Example service for tracking user events and analytics.

## Usage

### Import Services

```dart
import 'package:ec_core/services/services.dart';

// Or import specific services
import 'package:ec_core/services/core/base_service.dart';
import 'package:ec_core/services/examples/user_service.dart';
```

### Register Services with DI

```dart
// Register a service
DI.registerService<UserService>(UserService());

// Register a factory
DI.registerFactory<UserService>(() => UserService());

// Register a lazy singleton
DI.registerLazySingleton<UserService>(() => UserService());
```

### Use Services

```dart
// Get service from DI
final userService = DI.get<UserService>();

// Or use the service directly
final userService = UserService();
await userService.initialize();
```

## Best Practices

1. **Extend BaseService**: All services should extend `BaseService` for proper lifecycle management.

2. **Use DI**: Register services with the DI container rather than creating instances manually.

3. **Initialize Dependencies**: Use `DI.apiClient` and `DI.logger` for common dependencies.

4. **Handle Errors**: Always wrap API calls in try-catch blocks and log errors appropriately.

5. **Log Operations**: Use the logger to track service operations and debug issues.

6. **Clean Up**: Implement proper disposal in the `dispose()` method to free resources.

## Creating New Services

1. Create a new service file in the appropriate folder
2. Extend `BaseService`
3. Implement `initialize()` and `dispose()` methods
4. Add the service to the appropriate export file
5. Register the service with the DI container

Example:

```dart
// services/my_service.dart
import '../core/base_service.dart';
import 'package:ec_core/ec_core.dart';

class MyService extends BaseService {
  late final ApiClient _apiClient;
  late final Talker _logger;

  @override
  Future<void> initialize() async {
    _apiClient = DI.apiClient;
    _logger = DI.logger;
    _logger.info('MyService initialized');
  }

  @override
  Future<void> dispose() async {
    _logger.info('MyService disposed');
  }

  // Your service methods here
}
```
