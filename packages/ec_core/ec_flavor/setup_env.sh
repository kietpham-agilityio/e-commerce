#!/bin/bash

# Environment Setup Script for E-Commerce Flavor Package
# Usage: ./setup_env.sh [dev|staging|prod]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

# Check if environment argument is provided
if [ $# -eq 0 ]; then
    print_error "Please specify an environment: dev, staging, or prod"
    echo "Usage: $0 [dev|staging|prod]"
    exit 1
fi

ENV=$1

# Validate environment argument
case $ENV in
    dev|development)
        SOURCE_FILE="env.dev"
        ENV_NAME="Development"
        ;;
    staging)
        SOURCE_FILE="env.staging"
        ENV_NAME="Staging"
        ;;
    prod|production)
        SOURCE_FILE="env.prod"
        ENV_NAME="Production"
        ;;
    *)
        print_error "Invalid environment: $ENV"
        echo "Valid options: dev, staging, prod"
        exit 1
        ;;
esac

# Check if source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    print_error "Source file $SOURCE_FILE not found!"
    exit 1
fi

# Backup existing .env file if it exists
if [ -f ".env" ]; then
    print_warning "Backing up existing .env file to .env.backup"
    cp .env .env.backup
fi

# Copy the environment file to .env
print_status "Setting up $ENV_NAME environment..."
cp "$SOURCE_FILE" .env

# Verify the copy was successful
if [ -f ".env" ]; then
    print_status "Successfully set up $ENV_NAME environment!"
    print_status "Environment file: .env"
    
    # Show a preview of the configuration
    echo ""
    print_status "Current configuration:"
    echo "----------------------------------------"
    cat .env
    echo "----------------------------------------"
else
    print_error "Failed to create .env file!"
    exit 1
fi

print_status "Environment setup complete!"
print_warning "Remember: .env files are ignored by git for security"
