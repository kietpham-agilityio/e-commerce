import 'dart:async';

import 'package:flutter_test/flutter_test.dart' as flutter_test;

import '../features/test_feature_classes.dart';

/// Base class for unit tests with setup/teardown capabilities
class EcUnitTest {
  const EcUnitTest({
    required this.description,
    required this.features,
    this.setUp,
    this.setUpAll,
    this.tearDown,
    this.tearDownAll,
  });

  final String description;
  final List<EcUTFeature> features;
  final FutureOr<void> Function()? setUp;
  final FutureOr<void> Function()? setUpAll;
  final FutureOr<void> Function()? tearDown;
  final FutureOr<void> Function()? tearDownAll;

  /// Runs all test methods.
  void test() {
    // Runs setup/teardown/setupAll/teardownAll function
    _setUpAndTeardown();

    flutter_test.group(description, () {
      for (var i = 0; i < features.length; i++) {
        features[i].test();
      }
    });
  }

  /// Runs any provided [setUp, setUpAll, tearDown, tearDownAll] methods.
  void _setUpAndTeardown() {
    if (setUpAll != null) {
      flutter_test.setUpAll(setUpAll!);
    }
    if (tearDownAll != null) {
      flutter_test.tearDownAll(tearDownAll!);
    }
    if (setUp != null) {
      flutter_test.setUp(setUp!);
    }
    if (tearDown != null) {
      flutter_test.tearDown(tearDown!);
    }
  }
}

/// Base class for BLoC tests with setup/teardown capabilities
class EcBlocTest {
  const EcBlocTest({
    required this.description,
    required this.features,
    this.setUp,
    this.setUpAll,
    this.tearDown,
    this.tearDownAll,
  });

  final String description;
  final List<EcBlocTestFeature> features;
  final FutureOr<void> Function()? setUp;
  final FutureOr<void> Function()? setUpAll;
  final FutureOr<void> Function()? tearDown;
  final FutureOr<void> Function()? tearDownAll;

  /// Runs all test methods.
  void test() {
    // Runs setup/teardown/setupAll/teardownAll function
    _setUpAndTeardown();

    flutter_test.group(description, () {
      for (var i = 0; i < features.length; i++) {
        features[i].test();
      }
    });
  }

  /// Runs any provided [setUp, setUpAll, tearDown, tearDownAll] methods.
  void _setUpAndTeardown() {
    if (setUpAll != null) {
      flutter_test.setUpAll(() => setUpAll?.call());
    }
    if (tearDownAll != null) {
      flutter_test.tearDownAll(() => tearDownAll?.call());
    }
    if (setUp != null) {
      flutter_test.setUp(() => setUp?.call());
    }
    if (tearDown != null) {
      flutter_test.tearDown(() => tearDown?.call());
    }
  }
}
