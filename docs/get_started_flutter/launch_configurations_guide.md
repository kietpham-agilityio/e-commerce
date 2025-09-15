# Launch Configurations Guide

## Overview

The `.vscode/launch.json` file contains debug/run configurations for the Flutter project in VS Code. This file allows running the application with different environments and build modes.

## File Structure

### Version
```json
"version": "0.2.0"
```
Standard VS Code launch configuration version.

### Configurations

The file contains 9 configurations divided into 3 main groups:

## 1. Development Environment (DEV)

### Run DEV (Debug)
- **Purpose**: Development with debugging symbols and hot reload
- **Flavor**: `dev`
- **Environment file**: `.env.dev`
- **Flutter Mode**: Debug (default)
- **Usage**: Code development and debugging

### Run DEV (Profile)
- **Purpose**: Performance testing in development environment
- **Flavor**: `dev`
- **Environment file**: `.env.dev`
- **Flutter Mode**: `profile`
- **Usage**: Application performance testing

### Run DEV (Release)
- **Purpose**: Test production-like build in development
- **Flavor**: `dev`
- **Environment file**: `.env.dev`
- **Flutter Mode**: `release`
- **Usage**: Test application in optimized mode

## 2. Staging Environment (STAGING)

### Run STAGING (Debug)
- **Purpose**: Debug in staging environment
- **Flavor**: `stag`
- **Environment file**: `.env.stag`
- **Flutter Mode**: Debug (default)
- **Usage**: Test and debug with staging data

### Run STAGING (Profile)
- **Purpose**: Performance testing in staging
- **Flavor**: `stag`
- **Environment file**: `.env.stag`
- **Flutter Mode**: `profile`
- **Usage**: Performance testing with staging config

### Run STAGING (Release)
- **Purpose**: Test production-like build in staging
- **Flavor**: `stag`
- **Environment file**: `.env.stag`
- **Flutter Mode**: `release`
- **Usage**: Final testing before production deployment

## 3. Production Environment (PROD)

### Run PROD (Debug)
- **Purpose**: Debug production issues (use with caution!)
- **Flavor**: `prod`
- **Environment file**: `.env.prod`
- **Flutter Mode**: Debug (default)
- **Usage**: Debug production issues (only when necessary)

### Run PROD (Profile)
- **Purpose**: Performance testing with production config
- **Flavor**: `prod`
- **Environment file**: `.env.prod`
- **Flutter Mode**: `profile`
- **Usage**: Production performance testing

### Run PROD (Release)
- **Purpose**: Complete production build
- **Flavor**: `prod`
- **Environment file**: `.env.prod`
- **Flutter Mode**: `release`
- **Usage**: Final production build

## How to Use

### 1. Run from VS Code
1. Open VS Code
2. Press `F5` or go to `Run and Debug` panel
3. Select appropriate configuration from dropdown
4. Press play button to run

### 2. Run from Command Palette
1. Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (Mac)
2. Type "Debug: Select and Start Debugging"
3. Choose desired configuration

### 3. Run from Terminal
```bash
# Development
flutter run --flavor dev --dart-define-from-file .env.dev

# Staging
flutter run --flavor stag --dart-define-from-file .env.stag

# Production
flutter run --flavor prod --dart-define-from-file .env.prod
```

## Flutter Modes

### Debug Mode
- **Features**: Debugging symbols, hot reload, debugging tools
- **Performance**: Slowest
- **Usage**: Development and debugging

### Profile Mode
- **Features**: Optimized but still debuggable
- **Performance**: Medium
- **Usage**: Performance testing

### Release Mode
- **Features**: Fully optimized, no debugging
- **Performance**: Fastest
- **Usage**: Production builds

## Environment Files

Each environment uses its own `.env` file:
- `.env.dev` - Development environment variables
- `.env.stag` - Staging environment variables  
- `.env.prod` - Production environment variables

## Important Notes

### ⚠️ Production Configurations
- **Be careful** when using PROD configurations
- They connect to production services
- Only use when absolutely necessary

### 🔧 Development Workflow
1. **Development**: Use DEV configurations
2. **Testing**: Use STAGING configurations
3. **Production**: Use PROD configurations (with caution)

### 📱 Flutter Flavors
Flavors allow:
- Different configurations for each environment
- Different app icons and names
- Separate environment variables

## Troubleshooting

### Common Issues

1. **.env file doesn't exist**
   - Check if `.env.dev`, `.env.stag`, `.env.prod` files exist
   - Create files if they don't exist

2. **Flavor not recognized**
   - Check flavor configuration in `android/app/build.gradle`
   - Check flavor configuration in `ios/Runner.xcodeproj`

3. **Debug not working**
   - Ensure Flutter extension is installed
   - Check if device/emulator is connected

### Debug Tips
- Use breakpoints in VS Code
- Check Debug Console for logs
- Use Flutter Inspector for UI debugging

## References

- [VS Code Debugging](https://code.visualstudio.com/docs/editor/debugging)
- [Flutter Debugging](https://docs.flutter.dev/development/tools/devtools/debugger)
- [Flutter Flavors](https://docs.flutter.dev/deployment/flavors)
