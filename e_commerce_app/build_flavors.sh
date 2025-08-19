#!/bin/bash

# Build script for E-Commerce app flavors
# Usage: ./build_flavors.sh [admin|user] [android|ios]

FLAVOR=${1:-user}
PLATFORM=${2:-android}

echo "Building $FLAVOR flavor for $PLATFORM..."

if [ "$PLATFORM" = "android" ]; then
    echo "Building Android $FLAVOR flavor..."
    
    if [ "$FLAVOR" = "admin" ]; then
        flutter build apk --flavor admin --target lib/main.dart
        echo "Admin APK built successfully!"
    elif [ "$FLAVOR" = "user" ]; then
        flutter build apk --flavor user --target lib/main.dart
        echo "User APK built successfully!"
    else
        echo "Invalid flavor. Use 'admin' or 'user'"
        exit 1
    fi
    
elif [ "$PLATFORM" = "ios" ]; then
    echo "Building iOS $FLAVOR flavor..."
    
    if [ "$FLAVOR" = "admin" ]; then
        flutter build ios --flavor admin --target lib/main.dart
        echo "Admin iOS build completed!"
    elif [ "$FLAVOR" = "user" ]; then
        flutter build ios --flavor user --target lib/main.dart
        echo "User iOS build completed!"
    else
        echo "Invalid flavor. Use 'admin' or 'user'"
        exit 1
    fi
    
else
    echo "Invalid platform. Use 'android' or 'ios'"
    exit 1
fi

echo "Build completed for $FLAVOR flavor on $PLATFORM!"
