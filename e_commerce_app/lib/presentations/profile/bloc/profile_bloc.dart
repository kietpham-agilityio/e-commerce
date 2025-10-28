import 'package:ec_core/api_client/apis/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/login_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

/// BLoC for managing profile page state and business logic
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required LogoutUseCase logoutUseCase})
    : _logoutUseCase = logoutUseCase,
      super(const ProfileState()) {
    on<OnLogoutButtonPressed>(_onLogoutButtonPressed);
  }

  final LogoutUseCase _logoutUseCase;

  /// Handle logout button press
  Future<void> _onLogoutButtonPressed(
    OnLogoutButtonPressed event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      await _logoutUseCase();
      emit(state.copyWith(status: ProfileStatus.logoutSuccess));
    } on Failure catch (failure) {
      String errorMessage = 'Logout failed. Please try again.';

      if (failure.isNetworkError) {
        errorMessage =
            'Unable to connect. Please check your internet connection.';
      } else if (failure.isServerError) {
        errorMessage =
            'Logout service is temporarily unavailable. Try again later.';
      }

      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: errorMessage,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }
}
