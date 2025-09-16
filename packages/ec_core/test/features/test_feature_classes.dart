import 'package:flutter_test/flutter_test.dart' as flutter_test;

import '../scenarios/test_scenario_classes.dart';

/// Feature class for unit tests
class EcUTFeature {
  const EcUTFeature({required this.description, required this.scenarios});

  final String description;
  final List<EcUTScenario> scenarios;

  void test() {
    flutter_test.group(description, () {
      for (var i = 0; i < scenarios.length; i++) {
        scenarios[i].test();
      }
    });
  }
}

/// Feature class for BLoC tests
class EcBlocTestFeature {
  const EcBlocTestFeature({required this.description, required this.scenarios});

  final String description;
  final List<EcBlocTestScenario> scenarios;

  void test() {
    flutter_test.group(description, () {
      for (var i = 0; i < scenarios.length; i++) {
        scenarios[i].test();
      }
    });
  }
}
