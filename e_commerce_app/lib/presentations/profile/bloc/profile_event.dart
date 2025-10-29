part of 'profile_bloc.dart';

/// Base class for Profile events
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Event when logout button is pressed
class OnLogoutButtonPressed extends ProfileEvent {
  const OnLogoutButtonPressed();
}
