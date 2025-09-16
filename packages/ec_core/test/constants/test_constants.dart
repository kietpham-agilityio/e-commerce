import 'package:dio/dio.dart';
import 'package:faker/faker.dart';

/// Test constants and mock objects used across test files
final exceptionMock = Exception('oops');

final requestOptionsMock = RequestOptions(path: faker.lorem.word());
