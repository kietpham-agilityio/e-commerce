import 'package:ec_core/ec_core.dart';
import 'package:equatable/equatable.dart';

/// App state
class AppState extends Equatable {
  final EcFeatureFlag flags;
  final String? error;

  const AppState({required this.flags, this.error});

  /// Initial state with default flags
  factory AppState.initial() {
    return AppState(flags: EcFeatureFlag.withEnvironment());
  }

  /// Copy with new values
  AppState copyWith({EcFeatureFlag? flags, String? error}) {
    return AppState(flags: flags ?? this.flags, error: error);
  }

  @override
  List<Object?> get props => [flags, error];
}
