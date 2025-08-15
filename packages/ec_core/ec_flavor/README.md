# EcFlavor - Flavor Management Package

A comprehensive flavor management package for Flutter applications that provides automatic flavor detection, environment configuration, and flavor-specific service management.

## Features

- **Automatic Flavor Detection**: Multiple detection methods for reliable flavor identification
- **Environment Configuration**: Automatic loading of flavor-specific environment files
- **Flavor Management**: Centralized flavor state management with validation
- **Service Integration**: Easy integration with dependency injection systems
- **Debug Support**: Comprehensive debugging information and logging

## Quick Start

### Basic Usage

```dart
import 'package:ec_flavor/ec_flavor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Auto-detect and initialize flavor
  final flavor = await FlavorManager.initializeWithAutoDetection();
  
  print('Current flavor: ${flavor.displayName}');
  print('API URL: ${FlavorManager.apiBaseUrl}');
  
  runApp(MyApp());
}
```

### Manual Initialization

```dart
// Initialize with specific flavor
FlavorManager.initialize(EcFlavor.staging);

// Initialize with environment loading
await FlavorManager.initializeWithEnvironment(EcFlavor.production);
```

## Architecture

### Core Components

```
EcFlavor Package
├── EcFlavor (Enum)
├── FlavorManager (State Management)
├── FlavorDetector (Detection & Environment)
├── FlavorConfig (Configuration)
└── FlavorEnvironment (Environment Data)
```

### Flavor Detection Methods

The package uses multiple detection methods in order of reliability:

1. **Build Arguments**: Check for `FLAVOR` environment variable
2. **Environment Variables**: Check for flavor-specific environment variables
3. **File Detection**: Check for existence of flavor-specific files
4. **Default Fallback**: Default to development if no flavor is detected

## API Reference

### EcFlavor Enum

```dart
enum EcFlavor {
  dev('dev', 'Development'),
  staging('staging', 'Staging'),
  production('production', 'Production');
  
  const EcFlavor(this.value, this.displayName);
  
  final String value;
  final String displayName;
}
```

**Properties:**
- `value`: String identifier for the flavor
- `displayName`: Human-readable name
- `isDev`, `isStaging`, `isProduction`: Boolean checks

**Methods:**
- `fromString(String value)`: Convert string to flavor enum
- `toString()`: Convert flavor to string

### FlavorManager

**Initialization Methods:**
```dart
// Basic initialization
static void initialize(EcFlavor flavor)

// Auto-detection initialization (recommended)
static Future<EcFlavor> initializeWithAutoDetection()

// Environment-aware initialization
static Future<void> initializeWithEnvironment(EcFlavor flavor)
```

**Access Methods:**
```dart
// Current flavor
static EcFlavor get currentFlavor

// Current configuration
static FlavorEnvironment get currentConfig

// Boolean checks
static bool get isDev
static bool get isStaging
static bool get isProduction

// Configuration access
static String get apiBaseUrl
static String get appName
static String get appVersion

// Feature flags
static bool isFeatureEnabled(String feature)

// Debug information
static Map<String, dynamic> get debugInfo
static Map<String, dynamic> get detectionInfo

// State check
static bool get isInitialized
```

**Utility Methods:**
```dart
// Get config for specific flavor
static FlavorEnvironment getConfig(EcFlavor flavor)

// Get all configurations
static Map<EcFlavor, FlavorEnvironment> getAllConfigs()

// Reset for testing
static void reset()
```

### FlavorDetector

**Detection Methods:**
```dart
// Auto-detect current flavor
static EcFlavor detectFlavor()

// Load environment for specific flavor
static Future<void> loadEnvironmentConfig(EcFlavor flavor)

// Auto-detect and load environment
static Future<EcFlavor> autoDetectAndLoad()

// Get detection debug info
static Map<String, dynamic> getDetectionInfo()
```

**Environment Methods:**
```dart
// Get environment file path
static String getEnvironmentFilePath(EcFlavor flavor)
```

## Configuration

### Environment Files

The package automatically looks for environment files in the following locations:

- **Development**: `../packages/ec_core/ec_flavor/env.dev`
- **Staging**: `../packages/ec_core/ec_flavor/env.staging`
- **Production**: `../packages/ec_core/ec_flavor/env.prod`

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

## Integration Examples

### With EcLocator

```dart
import 'package:ec_flavor/ec_flavor.dart';
import 'package:ec_design/ec_design.dart';

class EcLocator {
  static Future<void> initialize() async {
    // Use EcFlavor's automatic detection
    final detectedFlavor = await FlavorManager.initializeWithAutoDetection();
    
    // Register flavor-specific services
    _registerFlavorServices(detectedFlavor);
    
    // Register other services...
  }
}
```

### With GetIt

```dart
import 'package:get_it/get_it.dart';
import 'package:ec_flavor/ec_flavor.dart';

void setupLocator() async {
  final getIt = GetIt.instance;
  
  // Initialize flavor first
  await FlavorManager.initializeWithAutoDetection();
  
  // Register services based on flavor
  if (FlavorManager.isFeatureEnabled('logging')) {
    getIt.registerLazySingleton<LoggingService>(() => LoggingService());
  }
  
  // Register other services...
}
```

### With Provider

```dart
import 'package:provider/provider.dart';
import 'package:ec_flavor/ec_flavor.dart';

class FlavorProvider extends ChangeNotifier {
  EcFlavor _flavor = EcFlavor.dev;
  FlavorEnvironment _config;
  
  FlavorProvider() {
    _initializeFlavor();
  }
  
  Future<void> _initializeFlavor() async {
    _flavor = await FlavorManager.initializeWithAutoDetection();
    _config = FlavorManager.currentConfig;
    notifyListeners();
  }
  
  EcFlavor get flavor => _flavor;
  FlavorEnvironment get config => _config;
}
```

## Testing

### Reset Between Tests

```dart
void main() {
  setUp(() {
    FlavorManager.reset();
  });
  
  tearDown(() {
    FlavorManager.reset();
  });
  
  test('should detect development flavor', () async {
    final flavor = await FlavorManager.initializeWithAutoDetection();
    expect(flavor, equals(EcFlavor.dev));
  });
}
```

### Mock Flavor Configuration

```dart
class MockFlavorEnvironment extends Mock implements FlavorEnvironment {
  @override
  String get apiBaseUrl => 'https://mock-api.example.com';
  
  @override
  bool get enableLogging => true;
}

void main() {
  test('should use mock configuration', () {
    // Register mock config
    // ... mock setup
    
    FlavorManager.initialize(EcFlavor.dev);
    expect(FlavorManager.apiBaseUrl, equals('https://mock-api.example.com'));
  });
}
```

## Debugging

### Get Debug Information

```dart
// Current flavor info
final flavorInfo = FlavorManager.debugInfo;
print('Flavor: ${flavorInfo['currentFlavor']}');
print('API URL: ${flavorInfo['apiBaseUrl']}');

// Detection info
final detectionInfo = FlavorManager.detectionInfo;
print('Detected: ${detectionInfo['detectedFlavor']}');
print('Has env var: ${detectionInfo['hasFlavorEnv']}');
```

### Debug Mode Logging

The package automatically logs debug information when running in debug mode:

```
FlavorManager initialized with: Development
API Base URL: https://dev-api.example.com
Logging enabled: true
```

## Best Practices

### 1. Initialization
- Use `initializeWithAutoDetection()` for most applications
- Initialize flavor before setting up other services
- Handle initialization errors gracefully

### 2. Configuration
- Keep environment files in the expected locations
- Use meaningful environment variable names
- Provide fallback values in FlavorConfig

### 3. Testing
- Reset FlavorManager between tests
- Mock FlavorEnvironment for consistent testing
- Test with different flavor configurations

### 4. Error Handling
- Check `FlavorManager.isInitialized` before use
- Wrap flavor access in try-catch blocks
- Provide meaningful error messages

## Troubleshooting

### Common Issues

1. **Flavor Not Detected**
   - Check environment variables are set correctly
   - Verify flavor-specific files exist
   - Use `getDetectionInfo()` for debugging

2. **Environment Not Loaded**
   - Check file paths are correct
   - Verify file permissions
   - Check for syntax errors in environment files

3. **Configuration Not Available**
   - Ensure FlavorManager is initialized
   - Check FlavorConfig provides defaults
   - Verify flavor enum values match configuration

### Debug Steps

1. **Check Detection Info**
   ```dart
   final info = FlavorManager.detectionInfo;
   print(info);
   ```

2. **Verify Initialization**
   ```dart
   if (FlavorManager.isInitialized) {
     print('Flavor: ${FlavorManager.currentFlavor.displayName}');
   } else {
     print('Flavor not initialized');
   }
   ```

3. **Check Configuration**
   ```dart
   try {
     final config = FlavorManager.currentConfig;
     print('Config loaded: ${config.appName}');
   } catch (e) {
     print('Config error: $e');
   }
   ```

## Support

For issues with the EcFlavor package:
1. Check this documentation
2. Review the detection methods
3. Verify environment configuration
4. Check debug information
5. Contact the development team for complex problems
