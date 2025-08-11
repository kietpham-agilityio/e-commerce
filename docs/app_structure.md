# App Structure & Architecture

## Overview

This is a Flutter e-commerce application built using a **monorepo architecture** with **Clean Architecture** principles. The project is organized into multiple packages that can be developed, tested, and maintained independently while sharing common functionality.

## Repository Structure

```
e_commerce/
├── e_commerce_app/         # Main Flutter application
├── packages/               # Shared packages/libraries
│   ├── ec_core/            # Core business logic & services
│   ├── ec_design/          # UI components & design system
│   ├── ec_l10n/            # Localization & internationalization
│   ├── ec_lint/            # Custom linting rules
│   └── ec_secrets/         # Configuration & secure storage
├── docs/                   # Project documentation
└── .puro.json              # Puro configuration for monorepo
```

## Architecture Principles

### 1. Clean Architecture
The app follows Clean Architecture with clear separation of concerns:

- **Presentation Layer**: UI components, screens, and state management
- **Domain Layer**: Business logic, entities, and use cases
- **Data Layer**: Data sources, repositories, and external APIs

### 2. Monorepo Structure
- **Single repository** containing multiple packages
- **Shared dependencies** and common utilities
- **Independent development** of packages
- **Consistent tooling** across all packages

### 3. Package Organization
Each package has a specific responsibility and can be used independently:

## Package Details

### 📱 e_commerce_app (Main App)
**Location**: `e_commerce_app/`
**Purpose**: Main Flutter application entry point

**Structure**:
```
lib/
├── main_dev.dart           # Development environment entry
├── main_stag.dart          # Staging environment entry
├── main_prod.dart          # Production environment entry
├── core/                   # App-specific core utilities
├── data/                   # Data layer implementation
├── domain/                 # Domain layer (entities, use cases)
└── presentations/          # UI layer (screens, widgets)
```

**Key Features**:
- Environment-specific configurations
- Clean Architecture implementation
- Custom linting integration
- Platform-specific configurations (Android/iOS)

### 🔧 ec_core (Core Package)
**Location**: `packages/ec_core/`
**Purpose**: Core business logic, services, and utilities

**Structure**:
```
ec_core/
├── api_client/             # HTTP client & API integration
├── di/                     # Dependency injection
├── feature_flags/          # Feature toggle system
├── mocked_backend/         # Mock data for development
├── services/               # Core services
│   ├── ec_local_store/    # Local storage service
│   └── ec_notifications/  # Notification service
└── debug_tools/            # Development & debugging utilities
```

**Responsibilities**:
- API communication
- Data persistence
- Business logic implementation
- Service orchestration
- Development tools

### 🎨 ec_design (Design System)
**Location**: `packages/ec_design/`
**Purpose**: Reusable UI components and design system

**Structure**:
```
ec_design/
├── components/             # Reusable UI components
├── themes/                 # App themes & styling
└── widget_books/          # Component documentation
```

**Responsibilities**:
- Consistent UI components
- Design system implementation
- Theme management
- Component library

### 🌍 ec_l10n (Localization)
**Location**: `packages/ec_l10n/`
**Purpose**: Internationalization and localization

**Structure**:
```
ec_l10n/
└── resources/              # Localization resources
```

**Responsibilities**:
- Multi-language support
- Text resource management
- Locale-specific formatting

### 🔒 ec_secrets (Security & Config)
**Location**: `packages/ec_secrets/`
**Purpose**: Configuration management and secure storage

**Structure**:
```
ec_secrets/
├── config/                 # Configuration files
├── env/                    # Environment variables
└── secure_storage/         # Secure data storage
```

**Responsibilities**:
- Environment configuration
- Secure credential storage
- Configuration management
- API key management

### ✅ ec_lint (Custom Linting)
**Location**: `packages/ec_lint/`
**Purpose**: Custom code quality rules and standards

**Structure**:
```
ec_lint/
└── lib/
    ├── ec_lint.dart        # Main plugin entry point
    └── src/                # Rule implementations
```

**Responsibilities**:
- Code quality enforcement
- Custom business rules
- Consistent coding standards
- Automated code review

## Development Workflow

### 1. Package Development
- Each package can be developed independently
- Use `flutter pub get` in individual package directories
- Test packages in isolation before integration

### 2. App Integration
- Main app consumes packages via path dependencies
- Packages are referenced in `pubspec.yaml` using relative paths
- Changes in packages automatically reflect in the main app

### 3. Environment Management
- **Development**: `main_dev.dart` - Development-specific configurations
- **Staging**: `main_stag.dart` - Pre-production testing
- **Production**: `main_prod.dart` - Live environment
