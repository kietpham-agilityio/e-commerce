# Environment Configuration

This package uses `flutter_dotenv` to manage environment-specific configuration values.

## Setup

### Option 1: Using the Setup Script (Recommended)

```bash
# Make sure the script is executable
chmod +x setup_env.sh

# Set up development environment
./setup_env.sh dev

# Set up staging environment
./setup_env.sh staging

# Set up production environment
./setup_env.sh prod
```

### Option 2: Manual Setup

1. Copy the appropriate environment file for your target environment:

   ```bash
   # For development
   cp env.dev .env
   
   # For staging
   cp env.staging .env
   
   # For production
   cp env.prod .env
   ```

2. Update the `.env` file with your actual environment values if needed.

## Environment Files

The package provides separate environment files for each flavor:

- `env.dev` - Development environment configuration
- `env.staging` - Staging environment configuration  
- `env.prod` - Production environment configuration
- `env_template` - Template with all environments (for reference)

## Environment Variables

Each environment file contains these configuration variables:

- `API_BASE_URL` - API base URL
- `APP_NAME` - Application name
- `APP_VERSION` - Application version
- `ENABLE_LOGGING` - Enable logging (true/false)
- `ENABLE_ANALYTICS` - Enable analytics (true/false)
- `ENABLE_CRASHLYTICS` - Enable crashlytics (true/false)
- `TIMEOUT_SECONDS` - Request timeout in seconds
- `MAX_RETRIES` - Maximum retry attempts

## Usage

To load the environment variables in your app:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Load environment variables
await dotenv.load(fileName: ".env");

// Access environment variables
String apiUrl = dotenv.env['API_BASE_URL'] ?? 'default_url';
String appName = dotenv.env['APP_NAME'] ?? 'default_name';
```

## Build Configuration

You can configure your build process to copy the appropriate environment file:

```bash
# Development build
cp env.dev .env && flutter build apk --flavor dev

# Staging build  
cp env.staging .env && flutter build apk --flavor staging

# Production build
cp env.prod .env && flutter build apk --flavor prod
```

## Security Note

- Never commit the `.env` file to version control
- All environment files are already added to `.gitignore`
- Use the template files as a reference for required variables
