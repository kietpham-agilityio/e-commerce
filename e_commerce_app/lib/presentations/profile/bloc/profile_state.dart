part of 'profile_bloc.dart';

/// Profile page status
enum ProfileStatus { initial, loading, logoutSuccess, failure }

/// Profile state
class ProfileState extends Equatable {
  final ProfileStatus status;
  final String? errorMessage;

  const ProfileState({this.status = ProfileStatus.initial, this.errorMessage});

  /// Copy with new values
  ProfileState copyWith({ProfileStatus? status, String? errorMessage}) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
