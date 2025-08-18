#!/bin/bash

# E-Commerce App Build Script
# Usage: ./build.sh [dev|staging|production] [android|ios] [debug|release]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Check if arguments are provided
if [ $# -lt 2 ]; then
    print_error "Usage: $0 [dev|staging|production] [android|ios] [debug|release]"
    echo ""
    echo "Examples:"
    echo "  $0 dev android debug     # Build Android debug for development"
    echo "  $0 staging ios release   # Build iOS release for staging"
    echo "  $0 production android release # Build Android release for production"
    echo ""
    echo "Environment configurations:"
    echo "  dev:        Orange theme, admin role, logging enabled, analytics disabled"
    echo "  staging:    Blue theme, user role, logging enabled, analytics enabled"
    echo "  production: Green theme, user role, logging disabled, analytics enabled"
    echo ""
    echo "Environment files used:"
    echo "  - env.base: Common configuration"
    echo "  - env.dev: Development overrides"
    echo "  - env.staging: Staging overrides"
    echo "  - env.production: Production overrides"
    exit 1
fi

ENVIRONMENT=$1
PLATFORM=$2
BUILD_TYPE=${3:-debug}

# Validate environment
case $ENVIRONMENT in
    dev|development)
        ENV_NAME="Development"
        ENV_FILE="env.dev"
        ;;
    staging)
        ENV_NAME="Staging"
        ENV_FILE="env.staging"
        ;;
    prod|production)
        ENV_NAME="Production"
        ENV_FILE="env.production"
        ;;
    *)
        print_error "Invalid environment: $ENVIRONMENT"
        echo "Valid options: dev, staging, prod"
        exit 1
        ;;
esac

# Validate platform
case $PLATFORM in
    android|Android)
        PLATFORM_NAME="Android"
        ;;
    ios|iOS)
        PLATFORM_NAME="iOS"
        ;;
    *)
        print_error "Invalid platform: $PLATFORM"
        echo "Valid options: android, ios"
        exit 1
        ;;
esac

# Validate build type
case $BUILD_TYPE in
    debug|Debug)
        BUILD_TYPE_NAME="Debug"
        ;;
    release|Release)
        BUILD_TYPE_NAME="Release"
        ;;
    *)
        print_error "Invalid build type: $BUILD_TYPE"
        echo "Valid options: debug, release"
        exit 1
        ;;
esac

print_header "Building $ENV_NAME for $PLATFORM_NAME ($BUILD_TYPE_NAME)"

# Check if environment files exist
if [ ! -f "env.base" ]; then
    print_error "Base environment file not found: env.base"
    exit 1
fi

if [ ! -f "$ENV_FILE" ]; then
    print_error "Environment file not found: $ENV_FILE"
    exit 1
fi

print_status "Environment: $ENV_NAME"
print_status "Platform: $PLATFORM_NAME"
print_status "Build Type: $BUILD_TYPE_NAME"
print_status "Environment File: $ENV_FILE"

# Set environment variable for Flutter to use
export FLUTTER_ENV=$ENVIRONMENT

print_status "Set FLUTTER_ENV=$ENVIRONMENT"

# Build commands
if [ "$PLATFORM" = "android" ]; then
    print_status "Building Android APK for $ENVIRONMENT..."
    
    if [ "$BUILD_TYPE" = "debug" ]; then
        flutter build apk --debug
    else
        flutter build apk --release
    fi
    
    print_status "Android build completed!"
    print_status "APK location: build/app/outputs/flutter-apk/"
    
elif [ "$PLATFORM" = "ios" ]; then
    print_status "Building iOS for $ENVIRONMENT..."
    
    if [ "$BUILD_TYPE" = "debug" ]; then
        flutter build ios --debug
    else
        flutter build ios --release
    fi
    
    print_status "iOS build completed!"
    print_status "Build location: build/ios/"
fi

print_header "Build Summary"
print_status "Environment: $ENV_NAME"
print_status "Platform: $PLATFORM_NAME"
print_status "Build Type: $BUILD_TYPE_NAME"
print_status "Status: ✅ Success"

echo ""
print_status "Environment Configuration:"
print_status "  - Base config: env.base"
print_status "  - Environment config: $ENV_FILE"
print_status "  - FLUTTER_ENV: $ENVIRONMENT"

echo ""
print_status "Next steps:"
if [ "$PLATFORM" = "android" ]; then
    echo "  - Install APK: adb install build/app/outputs/flutter-apk/app-${BUILD_TYPE}.apk"
    echo "  - Run on device: flutter run"
elif [ "$PLATFORM" = "ios" ]; then
    echo "  - Open Xcode project: open ios/Runner.xcworkspace"
    echo "  - Build and run from Xcode"
    echo "  - Run on device: flutter run"
fi

echo ""
print_status "Environment files used:"
echo "  - env.base: Common configuration"
echo "  - $ENV_FILE: $ENV_NAME-specific overrides"

echo ""
print_status "Build completed successfully! 🎉"
