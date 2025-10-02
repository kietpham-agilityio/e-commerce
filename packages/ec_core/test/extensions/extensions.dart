import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../constants/test_constants.dart';

/// Extension for void answer mocking
extension VoidAnswer on When<Future<void>> {
  void thenAnswerWithVoid() => thenAnswer((_) async {});
}

/// Extension for exception throwing in mocks
extension ThenThrowException on When<Future> {
  void thenThrowException() => thenThrow(exceptionMock);
}

/// Extension for Response future value mocking
extension ThenAnswerResponseFutureValue<T> on When<Future<Response<T>>> {
  void thenAnswerValue(T value) => thenAnswer(
    (_) =>
        Future.value(Response(requestOptions: requestOptionsMock, data: value)),
  );
}

/// Extension for future value mocking
extension ThenAnswerFutureValue<T> on When<Future<T>> {
  void thenAnswerValue(T value) => thenAnswer((_) => Future.value(value));
}

/// Extension for TaskEither answer value mocking
extension ThenTaskEitherAnswerValue<T, F> on When<TaskEither<T, F>> {
  void thenAnswerValue(F value) => thenAnswer((_) => TaskEither.right(value));

  void thenAnswerFailureValue(T value) =>
      thenAnswer((_) => TaskEither.left(value));
}
