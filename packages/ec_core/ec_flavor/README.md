# ec_flavor Package - Developer Guide

This guide explains how to reuse, customize, and maintain the `ec_flavor` package for your Flutter applications, following the [Flutter official flavors documentation](https://docs.flutter.dev/deployment/flavors).

## 📦 Package Overview

The `ec_flavor` package provides a robust environment management system for Flutter applications with multiple build flavors (development, staging, production). It automatically detects the current environment and loads appropriate configurations, working seamlessly with Flutter's built-in flavor system.

## 🏗️ Package Structure

```text
ec_flavor/
├── lib/
│   ├── ec_flavor.dart              # Main package export
│   └── src/
│       ├── ec_flavor.dart          # EcFlavor enum
│       ├── flavor_config.dart      # Environment configuration
│       ├── flavor_environment.dart # Environment model
│       ├── flavor_manager.dart     # Flavor management logic
│       └── flavor_utils.dart       # Utility functions
├── env.dev                         # Development environment template
├── env.staging                     # Staging environment template
├── env.prod                        # Production environment template
├── env_template                    # All environments reference
├── setup_env.sh                    # Environment setup script
└── .gitignore                      # Git ignore rules
```

## 🚀 Quick Start - Reusing the Package

### 1. Add to Your Project

```yaml
# pubspec.yaml
dependencies:
  ec_flavor:
    path: ../path/to/ec_flavor
  flutter_dotenv: ^5.2.1
```

### 2. Initialize in Your App

```dart
import 'package:ec_flavor/ec_flavor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavor manager
  FlavorManager.initialize(EcFlavor.dev);

  runApp(const MyApp());
}
```

### 3. Use Environment Configuration

```dart
// Get current flavor
final flavor = FlavorManager.currentFlavor;

// Get environment configuration
final config = FlavorManager.currentConfig;

// Check feature flags
if (FlavorManager.isFeatureEnabled('logging')) {
  // Enable logging
}
```

## 🔧 Flutter Flavors Setup

This package works with Flutter's built-in flavor system. Follow the official Flutter documentation to set up flavors for your platform:

### Android Flavors

Follow the [Flutter Android Flavors Guide](https://docs.flutter.dev/deployment/flavors):

#### 1. Configure build.gradle.kts

```kotlin
// android/app/build.gradle.kts
android {
    // ... existing configuration

    flavorDimensions += "default"
    productFlavors {
        create("dev") {
            dimension = "default"
            applicationIdSuffix = ".dev"
        }
        create("staging") {
            dimension = "default"
            applicationIdSuffix = ".staging"
        }
        create("production") {
            dimension = "default"
            applicationIdSuffix = ".production"
        }
    }
}
```

#### 2. Create Flavor-Specific Resources

Create distinct app names and icons for each flavor:

```kotlin
// android/app/build.gradle.kts
android {
    flavorDimensions += "default"
    productFlavors {
        create("dev") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            resValue(
                type = "string",
                name = "app_name",
                value = "My App Dev"
            )
        }
        create("staging") {
            dimension = "default"
            applicationIdSuffix = ".staging"
            resValue(
                type = "string",
                name = "app_name",
                value = "My App Staging"
            )
        }
        create("production") {
            dimension = "default"
            applicationIdSuffix = ".production"
            resValue(
                type = "string",
                name = "app_name",
                value = "My App"
            )
        }
    }
}
```

#### 3. Update AndroidManifest.xml

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="@string/app_name"
        android:icon="@mipmap/ic_launcher"
        ... />
</manifest>
```

### iOS Flavors

Follow the [Flutter iOS Flavors Guide](https://docs.flutter.dev/deployment/flavors-ios):

#### 1. Create Build Configurations

In Xcode, create build configurations for each flavor:

- `Debug-Dev`
- `Debug-Staging`
- `Debug-Production`
- `Release-Dev`
- `Release-Staging`
- `Release-Production`

#### 2. Configure Info.plist

Create flavor-specific `Info.plist` files or use build settings to customize:

- App display name
- Bundle identifier
- App icons
- Other iOS-specific configurations

#### 3. Set Up Xcode Schemes

Create separate schemes for each flavor to easily switch between configurations.

## 🎯 Launch Flavors

After setting up flavors, launch your app with specific flavors:

### Flutter CLI Commands

```bash
# Run with specific flavor
flutter run --flavor dev
flutter run --flavor staging
flutter run --flavor production

# Build with specific flavor
flutter build apk --flavor dev
flutter build apk --flavor staging
flutter build apk --flavor production

# iOS builds
flutter build ios --flavor dev
flutter build ios --flavor staging
flutter build ios --flavor production
```

### VS Code Launch Configurations

Configure `.vscode/launch.json` for easy debugging:

```json
{
  "name": "Dev Flavor",
  "request": "launch",
  "type": "dart",
  "program": "lib/main_dev.dart",
  "args": ["--flavor", "dev"]
},
{
  "name": "Staging Flavor",
  "request": "launch",
  "type": "dart",
  "program": "lib/main_stag.dart",
  "args": ["--flavor", "staging"]
},
{
  "name": "Production Flavor",
  "request": "launch",
  "type": "dart",
  "program": "lib/main_prod.dart",
  "args": ["--flavor", "production"]
}
```

## 🔧 Customization Guide

### Adding New Environment Variables

#### 1. Update FlavorEnvironment Model

```dart
// lib/src/flavor_environment.dart
class FlavorEnvironment {
  const FlavorEnvironment({
    required this.apiBaseUrl,
    required this.appName,
    required this.appVersion,
    required this.enableLogging,
    required this.enableAnalytics,
    required this.enableCrashlytics,
    required this.timeoutSeconds,
    required this.maxRetries,
    // Add your new variables here
    required this.databaseUrl,
    required this.apiKey,
  });

  final String apiBaseUrl;
  final String appName;
  final String appVersion;
  final bool enableLogging;
  final bool enableAnalytics;
  final bool enableCrashlytics;
  final int timeoutSeconds;
  final int maxRetries;
  // Add your new variables here
  final String databaseUrl;
  final String apiKey;
}
```

#### 2. Update Environment Files

```bash
# env.dev
API_BASE_URL=https://api-dev.example.com
APP_NAME=My App Dev
APP_VERSION=1.0.0-dev
ENABLE_LOGGING=true
ENABLE_ANALYTICS=false
ENABLE_CRASHLYTICS=false
TIMEOUT_SECONDS=60
MAX_RETRIES=5
# Add your new variables
DATABASE_URL=postgresql://dev:password@localhost:5432/dev_db
API_KEY=dev_api_key_123
```

#### 3. Update FlavorConfig

```dart
// lib/src/flavor_config.dart
static FlavorEnvironment get dev => FlavorEnvironment(
  apiBaseUrl: dotenv.env['API_BASE_URL'] ?? 'https://api-dev.example.com',
  appName: dotenv.env['APP_NAME'] ?? 'My App Dev',
  appVersion: dotenv.env['APP_VERSION'] ?? '1.0.0-dev',
  enableLogging: _parseBool(dotenv.env['ENABLE_LOGGING'] ?? 'true'),
  enableAnalytics: _parseBool(dotenv.env['ENABLE_ANALYTICS'] ?? 'false'),
  enableCrashlytics: _parseBool(dotenv.env['ENABLE_CRASHLYTICS'] ?? 'false'),
  timeoutSeconds: int.tryParse(dotenv.env['TIMEOUT_SECONDS'] ?? '60') ?? 60,
  maxRetries: int.tryParse(dotenv.env['MAX_RETRIES'] ?? '5') ?? 5,
  // Add your new variables
  databaseUrl: dotenv.env['DATABASE_URL'] ?? 'postgresql://localhost:5432/dev_db',
  apiKey: dotenv.env['API_KEY'] ?? 'dev_key',
);
```

### Adding New Flavors

#### 1. Extend EcFlavor Enum

```dart
// lib/src/ec_flavor.dart
enum EcFlavor {
  dev('dev', 'Development'),
  staging('staging', 'Staging'),
  production('production', 'Production'),
  // Add your new flavor
  testing('testing', 'Testing');

  const EcFlavor(this.value, this.displayName);
  final String value;
  final String displayName;
}
```

#### 2. Create Environment File

```bash
# env.testing
API_BASE_URL=https://api-test.example.com
APP_NAME=My App Testing
APP_VERSION=1.0.0-test
ENABLE_LOGGING=true
ENABLE_ANALYTICS=true
ENABLE_CRASHLYTICS=false
TIMEOUT_SECONDS=30
MAX_RETRIES=3
DATABASE_URL=postgresql://test:password@localhost:5432/test_db
API_KEY=test_api_key_456
```

#### 3. Update FlavorConfig

```dart
// lib/src/flavor_config.dart
static FlavorEnvironment get testing => FlavorEnvironment(
  // ... your configuration
);
```

#### 4. Update Platform-Specific Configurations

**Android (build.gradle.kts):**

```kotlin
create("testing") {
    dimension = "default"
    applicationIdSuffix = ".testing"
    resValue(
        type = "string",
        name = "app_name",
        value = "My App Testing"
    )
}
```

**iOS (Xcode):**

- Create `Debug-Testing` and `Release-Testing` build configurations
- Add testing scheme
- Configure testing-specific Info.plist values

#### 5. Update Setup Script

```bash
# setup_env.sh
case $ENV in
  dev|development)
    SOURCE_FILE="env.dev"
    ;;
  staging)
    SOURCE_FILE="env.staging"
    ;;
  prod|production)
    SOURCE_FILE="env.prod"
    ;;
  # Add your new flavor
  testing)
    SOURCE_FILE="env.testing"
    ;;
  *)
    echo "Unknown environment: $ENV"
    echo "Available environments: dev, staging, prod, testing"
    exit 1
    ;;
esac
```

## 🛠️ Maintenance Tasks

### Regular Maintenance

#### 1. Update Dependencies

```bash
# Check for updates
flutter pub outdated

# Update dependencies
flutter pub upgrade

# Update specific packages
flutter pub upgrade flutter_dotenv
```

#### 2. Environment File Validation

Create a validation script to ensure all environment files have required variables:

```bash
#!/bin/bash
# validate_env.sh

REQUIRED_VARS=("API_BASE_URL" "APP_NAME" "APP_VERSION" "ENABLE_LOGGING")

for env_file in env.*; do
  echo "Validating $env_file..."
  for var in "${REQUIRED_VARS[@]}"; do
    if ! grep -q "^$var=" "$env_file"; then
      echo "❌ Missing $var in $env_file"
      exit 1
    fi
  done
  echo "✅ $env_file is valid"
done
```

#### 3. Security Audits

```bash
# Check for sensitive data in environment files
grep -r "password\|secret\|key" env.* | grep -v "API_KEY"

# Check for hardcoded URLs
grep -r "http://" env.*
```

### Testing Your Changes

#### 1. Unit Tests

```dart
// test/flavor_config_test.dart
void main() {
  group('FlavorConfig Tests', () {
    test('dev environment loads correctly', () {
      // Test your configuration
      final config = FlavorConfig.dev;
      expect(config.appName, isNotEmpty);
      expect(config.apiBaseUrl, isNotEmpty);
    });
  });
}
```

#### 2. Integration Tests

```dart
// test/flavor_manager_test.dart
void main() {
  group('FlavorManager Integration Tests', () {
    test('initializes with correct flavor', () {
      FlavorManager.initialize(EcFlavor.dev);
      expect(FlavorManager.currentFlavor, EcFlavor.dev);
    });
  });
}
```

#### 3. Platform-Specific Testing

Test each flavor on both platforms:

```bash
# Android testing
flutter test --flavor dev
flutter test --flavor staging
flutter test --flavor production

# iOS testing (requires Xcode)
flutter test --flavor dev
flutter test --flavor staging
flutter test --flavor production
```

## 📋 Best Practices

### 1. Environment Variable Naming

- Use UPPER_SNAKE_CASE for environment variables
- Prefix with package/app name for uniqueness: `MY_APP_API_URL`
- Use descriptive names: `DATABASE_CONNECTION_TIMEOUT` not `DB_TO`

### 2. Default Values

- Always provide sensible defaults in `FlavorConfig`
- Use `??` operator for fallbacks
- Document default values in comments

### 3. Security

- Never commit `.env` files to version control
- Use `.gitignore` to exclude environment files
- Rotate API keys and secrets regularly
- Use environment-specific secrets

### 4. Platform Consistency

- Keep flavor names consistent between Android and iOS
- Use the same environment variable names across platforms
- Test all flavors on both platforms before release

### 5. Documentation

- Update this README when adding new features
- Document all environment variables
- Provide examples for common use cases
- Include troubleshooting guides

## 🔍 Troubleshooting

### Common Issues

#### 1. Environment File Not Found

```bash
# Check file exists
ls -la env.*

# Check file permissions
chmod 644 env.*

# Verify file path in FlavorConfig
```

#### 2. Variables Not Loading

```dart
// Debug environment loading
print('Environment variables: ${dotenv.env}');
print('API URL: ${dotenv.env['API_BASE_URL']}');
```

#### 3. Flavor Detection Issues

```dart
// Check current flavor
print('Current flavor: ${FlavorManager.currentFlavor}');
print('Flavor value: ${FlavorManager.currentFlavor.value}');
```

#### 4. Platform-Specific Issues

**Android:**

- Verify `build.gradle.kts` configuration
- Check flavor dimensions and product flavors
- Ensure `applicationIdSuffix` is unique

**iOS:**

- Verify Xcode build configurations
- Check scheme configurations
- Ensure Info.plist values are set correctly

### Debug Mode

Enable debug logging in your app:

```dart
if (FlavorManager.isFeatureEnabled('logging')) {
  print('Flavor: ${FlavorManager.currentFlavor.displayName}');
  print('Config: ${FlavorManager.currentConfig}');
}
```

## 📚 Additional Resources

- [Flutter Environment Variables](https://docs.flutter.dev/deployment/environment-variables)
- [Flutter Android Flavors Guide](https://docs.flutter.dev/deployment/flavors)
- [Flutter iOS Flavors Guide](https://docs.flutter.dev/deployment/flavors-ios)
- [flutter_dotenv Package](https://pub.dev/packages/flutter_dotenv)

## 🤝 Contributing

When contributing to this package:

1. **Follow the existing code style**
2. **Add tests for new features**
3. **Update documentation**
4. **Test with multiple environments**
5. **Validate environment files**
6. **Test on both Android and iOS**

## 📞 Support

For issues or questions:

1. Check this README first
2. Review the [Flutter official flavors documentation](https://docs.flutter.dev/deployment/flavors)
3. Review existing issues
4. Create a new issue with:
   - Flutter version
   - Package version
   - Platform (Android/iOS)
   - Error messages
   - Steps to reproduce
