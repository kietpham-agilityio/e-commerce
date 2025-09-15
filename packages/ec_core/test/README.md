# Test Utilities Module

This directory contains modularized test utilities and helpers for the e-commerce app.

## 📁 Structure

```
test/
├── test.dart                 # Main export file - imports all modules
├── constants/
│   └── test_constants.dart   # Test constants and mock objects
├── base/
│   └── test_base_classes.dart # Base test classes (EcUnitTest, EcBlocTest)
├── features/
│   └── test_feature_classes.dart # Feature classes (EcUTFeature, EcBlocTestFeature)
├── scenarios/
│   └── test_scenario_classes.dart # Scenario classes (EcUTScenario, EcBlocTestScenario)
├── steps/
│   └── test_step_class.dart  # Test step class (EcUTStep)
├── mocks/
│   └── mock_extensions.dart  # Mock extensions and utilities
└── README.md                 # This documentation
```

## 🚀 Usage

Import the main test file to get access to all test utilities:

```dart
import 'package:ec_core/test/test.dart';
```

Or import specific modules as needed:

```dart
import 'package:ec_core/test/base/test_base_classes.dart';
import 'package:ec_core/test/mocks/mock_extensions.dart';
```

## 📋 Modules

### constants/test_constants.dart
- `exceptionMock` - Common exception for testing
- `requestOptionsMock` - Mock RequestOptions for Dio

### base/test_base_classes.dart
- `EcUnitTest` - Base class for unit tests with setup/teardown
- `EcBlocTest` - Base class for BLoC tests with setup/teardown

### features/test_feature_classes.dart
- `EcUTFeature` - Feature class for unit tests
- `EcBlocTestFeature` - Feature class for BLoC tests

### scenarios/test_scenario_classes.dart
- `EcUTScenario<T, R>` - Scenario class for unit tests
- `EcBlocTestScenario<B, State>` - Scenario class for BLoC tests

### steps/test_step_class.dart
- `EcUTStep` - Step class for test scenarios

### mocks/mock_extensions.dart
- `VoidAnswer` - Extension for void answer mocking
- `ThenThrowException` - Extension for exception throwing
- `ThenAnswerResponseFutureValue<T>` - Extension for Response mocking
- `ThenAnswerFutureValue<T>` - Extension for future value mocking
- `ThenTaskEitherAnswerValue<T, F>` - Extension for TaskEither mocking

## 🧪 Example Usage

```dart
import 'package:ec_core/test/test.dart';

void main() {
  EcUnitTest(
    description: 'User Authentication',
    features: [
      EcUTFeature(
        description: 'Login',
        scenarios: [
          EcUTScenario<String, bool>(
            description: 'should return true when credentials are valid',
            when: () => 'valid_credentials',
            act: (credentials) => authenticateUser(credentials),
            expect: (result) => expect(result, isTrue),
          ),
        ],
      ),
    ],
  ).test();
}
```

## 📝 Naming Convention

All test files follow the naming convention defined in the project guidelines:
- Files: `snake_case` + `_test.dart` for test files
- Classes: `PascalCase` + `Test` for test classes
- Methods: `test_` + `description` for test methods
