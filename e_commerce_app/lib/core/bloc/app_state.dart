part of 'app_bloc.dart';

/// App state
class AppState extends Equatable {
  final EcFeatureFlag flags;
  final String? error;
  final bool isLoading;

  const AppState({required this.flags, this.error, this.isLoading = false});

  /// Initial state with default flags
  factory AppState.initial() {
    return AppState(flags: EcFeatureFlag.withEnvironment());
  }

  /// Copy with new values
  AppState copyWith({EcFeatureFlag? flags, String? error, bool? isLoading}) {
    return AppState(
      flags: flags ?? this.flags,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [flags, error, isLoading];
}
