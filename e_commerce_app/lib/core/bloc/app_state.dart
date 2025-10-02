import 'package:ec_core/ec_core.dart';
import 'package:equatable/equatable.dart';

/// App state
class AppState extends Equatable {
  final EcFeatureFlag flags;

  const AppState({required this.flags});

  /// Initial state with default flags
  factory AppState.initial() {
    return AppState(flags: EcFeatureFlag.withEnvironment());
  }

  /// Copy with new values
  AppState copyWith({EcFeatureFlag? flags}) {
    return AppState(flags: flags ?? this.flags);
  }

  @override
  List<Object?> get props => [flags];
}
