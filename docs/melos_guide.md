# Melos Guide - Flutter E-commerce Project

## Overview

Melos is a monorepo management tool for Flutter/Dart projects. In this e-commerce project, Melos is used to efficiently manage multiple packages and scripts.

## Installation

### Install Melos globally

```bash
dart pub global activate melos 6.3.2
```

## Project Structure

```text
e_commerce/
├── melos.yaml               # Main melos config
├── e_commerce_app/          # Main app
└── packages/
    ├── ec_core/             # Core functionality
    ├── ec_design/           # Design system
    │   ├── ec_themes/       # Theme package
    │   └── ec_widgetbook/   # Widget catalog
    ├── ec_lint/             # Custom lint rules
    └── ec_l10n/             # Localization
```

## Melos Configuration (melos.yaml)

### Packages Section

```yaml
packages:
  - . # Root package
  - packages/* # Direct packages
  - packages/*/* # Nested packages (ec_design/ec_themes)
  - packages/*/*/* # Deep nested packages
```

### Scripts Section

```yaml
scripts:
  postbootstrap: >
    melos exec -- puro flutter pub get && 
    melos run build_runner

  build_runner:
    run: |
      melos exec -- "puro flutter pub run build_runner build --delete-conflicting-outputs"
    packageFilters:
      scope:
        - e_commerce
        - ec_core
        - ec_themes
      ignore:
        - ec_widgetbook
```

## Basic Commands

### 1. Initialize Workspace

```bash
# First time or after configuration changes
melos bootstrap
```

### 2. Run Scripts

```bash
# Run build_runner on all scoped packages
melos run build_runner

# Run flutter pub get on all packages
melos exec -- puro flutter pub get

# Run specific command on package
melos exec -p ec_core -- puro flutter analyze
```

### 3. Workspace Management

```bash
# Clean workspace
melos clean

# Check package status
melos list

# Run command on specific package
melos exec -p ec_themes -- puro flutter test
```

## Package Filters

### Scope

Specify which packages will be executed:

```yaml
packageFilters:
  scope:
    - e_commerce # Main app
    - ec_core # Core package
    - ec_themes # Theme package
```

### Ignore

Exclude packages from execution:

```yaml
packageFilters:
  ignore:
    - ec_widgetbook # Don't run build_runner
    - ec_lint # Don't run build_runner
```

## Development Workflow

### 1. When starting work

```bash
# Bootstrap workspace
melos bootstrap

# Run build_runner if needed
melos run build_runner
```

### 2. When adding new package

```bash
# Create new package
mkdir packages/new_package
cd packages/new_package
puro flutter create --template=package .

# Bootstrap again for Melos to recognize
melos bootstrap
```

### 3. When changing dependencies

```bash
# Update dependencies
melos exec -- puro flutter pub get

# Run build_runner if needed
melos run build_runner
```

### 4. When changing Melos configuration

```bash
# Clean workspace
melos clean

# Bootstrap again
melos bootstrap
```

## Custom Scripts

### Add New Script

```yaml
scripts:
  analyze:
    run: melos exec -- puro flutter analyze

  test:
    run: melos exec -- puro flutter test

  format:
    run: melos exec -- puro dart format .

  lint:
    run: melos exec -- puro flutter analyze
```

### Using Scripts

```bash
# Run all tests
melos run test

# Format code
melos run format

# Analyze code
melos run lint
```

## Troubleshooting

### 1. Package not appearing in scope

- Check package name in `scope` section
- Use package name (not path)
- Run `melos clean` and `melos bootstrap`

### 2. Script not running on package

- Check `packageFilters.scope`
- Ensure package is listed in `packages` section
- Check YAML syntax

### 3. Puro errors

- Check Puro installation: `puro --version`
- Reinstall Puro if needed
- Check Flutter version: `puro flutter --version`

## Best Practices

### 1. Package Naming

- Use `ec_` prefix for all packages
- Use clear, descriptive names
- Avoid overly long or confusing names

### 2. Script Organization

- Group related scripts
- Use `packageFilters` to control scope
- Add clear comments for each script

### 3. Dependency Management

- Always run `melos bootstrap` after changing dependencies
- Use `melos exec` to run commands on multiple packages
- Check for conflicts between packages

### 4. Version Control

- Commit `melos.yaml` to repository
- Update `pubspec.lock` when changing dependencies
- Use semantic versioning for packages

## Real Examples

### Running Build Runner

```bash
# Run on all scoped packages
melos run build_runner

# Run on specific package
melos exec -p ec_themes -- puro flutter pub run build_runner build

# Run with watch mode
melos exec -p ec_core -- puro flutter pub run build_runner watch
```

### Development Workflow Example

```bash
# 1. Bootstrap workspace
melos bootstrap

# 2. Run build_runner
melos run build_runner

# 3. Run tests
melos run test

# 4. Format code
melos run format

# 5. Analyze code
melos run lint
```

## Conclusion

Melos helps manage Flutter monorepos efficiently. With proper configuration, you can:

- Manage multiple packages easily
- Run scripts on multiple packages simultaneously
- Control scope for each script
- Automate development workflows

Always remember to run `melos bootstrap` after changing configuration and use `packageFilters` to control script execution.

## 📎 References

- Melos Docs: [https://melos.invertase.dev](https://melos.invertase.dev)
- Invertase Blog: [https://invertase.io/blog/melos](https://invertase.io/blog/melos)
