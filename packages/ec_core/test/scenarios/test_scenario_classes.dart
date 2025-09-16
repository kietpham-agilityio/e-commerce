import 'dart:async';

import 'package:bloc_test/bloc_test.dart' as bloc_test;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;

/// Scenario class for BLoC tests
class EcBlocTestScenario<B extends BlocBase<State>, State> {
  const EcBlocTestScenario({
    required this.description,
    required this.build,
    this.setUp,
    this.act,
    this.seed,
    this.wait,
    this.expect,
    this.verify,
    this.errors,
    this.tearDown,
  });

  final String description;
  final B Function() build;
  final FutureOr<void> Function()? setUp;
  final void Function(B)? act;
  final State Function()? seed;
  final Duration? wait;
  final void Function()? expect;
  final void Function(B)? verify;
  final void Function()? errors;
  final FutureOr<void> Function()? tearDown;

  Future<void> test() async {
    bloc_test.blocTest<B, State>(
      description,
      build: build,
      act: act,
      seed: seed,
      setUp: setUp,
      wait: wait,
      verify: verify,
      expect: expect,
    );
  }
}

/// Scenario class for unit tests
class EcUTScenario<T, R> {
  const EcUTScenario({
    required this.description,
    required this.act,
    required this.when,
    required this.expect,
  });

  final String description;
  final FutureOr<T> Function() when;
  final FutureOr<dynamic> Function(T result) act;
  final FutureOr<void> Function(R result) expect;

  Future<void> test() async {
    flutter_test.test(description, () async {
      final res = await when();

      final result = await act(res) as R;

      expect(result);
    });
  }
}
