import 'package:equatable/equatable.dart';

class Failure<T> extends Equatable {
  const Failure(
    this.message, {
    this.noConnectionData,
  });
  final String message;
  final T? noConnectionData;

  @override
  List<Object> get props => [
        message,
        if (noConnectionData != null) noConnectionData!,
      ];

  @override
  String toString() => message;
}
