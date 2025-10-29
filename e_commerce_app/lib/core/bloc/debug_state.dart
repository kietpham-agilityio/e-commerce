part of 'debug_bloc.dart';

/// App state
class DebugState extends Equatable {
  final EcFeatureFlag flags;
  final String? error;
  final bool isLoading;

  const DebugState({required this.flags, this.error, this.isLoading = false});

  /// Initial state with default flags
  factory DebugState.initial() {
    return DebugState(flags: EcFeatureFlag.withEnvironment());
  }

  /// Copy with new values
  DebugState copyWith({EcFeatureFlag? flags, String? error, bool? isLoading}) {
    return DebugState(
      flags: flags ?? this.flags,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [flags, error, isLoading];
}
